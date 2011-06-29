From: ccross@google.com (Colin Cross)
Date: Wed, 29 Jun 2011 09:57:18 -0700
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <20110629140059.GE23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
	<CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
	<20110628234621.GD23312@n2100.arm.linux.org.uk>
	<CAMbhsRRBhT5YX6E4Nkyvns5YykqzqV3-g4JhR2KPcxBhj0ABww@mail.gmail.com>
	<20110629140059.GE23312@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRSWh0j-ZUx0bVZYcK-+K=z1ywwofJws6P_vrru9U8NKHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 7:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 28, 2011 at 04:59:57PM -0700, Colin Cross wrote:
>> On Tue, Jun 28, 2011 at 4:46 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Jun 28, 2011 at 04:37:08PM -0700, Colin Cross wrote:
>> >> I don't think it affects bogomips - loops_per_jiffy can still be
>> >> calibrated and updated by cpufreq, udelay just wont use them.
>> >
>> > No, you can't avoid it. ?__delay(), udelay(), and the global
>> > loops_per_jiffy are all linked together - for instance this is how
>> > the spinlock code has a 1s timeout:
>> >
>> > static void __spin_lock_debug(raw_spinlock_t *lock)
>> > {
>> > ? ? ? ?u64 loops = loops_per_jiffy * HZ;
>> > ? ? ? ?int print_once = 1;
>> >
>> > ? ? ? ?for (;;) {
>> > ? ? ? ? ? ? ? ?for (i = 0; i < loops; i++) {
>> > ? ? ? ? ? ? ? ? ? ? ? ?if (arch_spin_trylock(&lock->raw_lock))
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?return;
>> > ? ? ? ? ? ? ? ? ? ? ? ?__delay(1);
>> > ? ? ? ? ? ? ? ?}
>> >
>> > which goes wrong for all the same reasons you're pointing out about
>> > udelay(). ?So just restricting your argument to udelay() is not
>> > realistic.
>> >
>>
>> True, there are a few other users of loops_per_jiffy and __delay, but
>> it looks like __spin_lock_debug is the only one worth worrying about,
>> and it's timing is not as critical as udelay - worst case here is that
>> the warning occurs after 250 ms instead of 1s. ?Leaving
>> loops_per_jiffy and __delay intact, and fixing udelay, would still be
>> a net gain.
>
> Other users of loops_per_jiffy are incorrect in any case:

The same conclusion I came to on a quick scan of other uses of
loops_per_jiffy...

<snip>

> And strangely the major offender of this stuff are ARM drivers, not other
> peoples stuff and not stuff in drivers/staging.
>
> So I don't think its sane to ignore loops_per_jiffy and __delay, and just
> concentrate on udelay().

But this I don't understand.  Every other use I found of
loops_per_jiffy is incorrect and should be changed.  Fixing udelay now
would not make them any worse - they would stay just as broken as they
were, so there is no need to couple a fix to udelay with fixing other
users of loops_per_jiffy.  Why block a legitimate fix because some
other broken code uses a variable whose behavior would not change?

If you are requesting an alternate change that would allow __delay to
continue to be used to time loops while irqs are off and jiffies is
not being updated, but also allows loops_per_jiffy to change in the
middle of a loop, while not increasing the number of instructions
executed in __delay, I don't think that is possible.  You could
replace __delay with a function that tests against a timer, and
loops_per_jiffy with the frequency of the counter divided by HZ, but
that would limit your spinlock spins to the frequency of the counter -
1MHz on Tegra.

Are there ever other legitimate uses of loops_per_jiffy/__delay?  I
don't think even the spinlock_debug use is correct - the number of
instructions executed in the loop before the __delay call (I count 17)
is going to be much higher than the instructions in the __delay(1)
call (3 instructions).  The spinlock debug timeout is already going to
be much longer than expected.  It looks to me like the only legitimate
use of loops_per_jiffy is to calculate the number of loops and call
__delay(loops) (exactly what udelay does), the overhead of doing
anything else will swamp the __delay call.  spinlock debug can get
away with its incorrect usage, because it doesn't really care how long
the delay is, and must have a minimum overhead.
