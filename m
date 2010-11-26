From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 26 Nov 2010 12:16:39 +0200
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <20101126091832.GE9310@n2100.arm.linux.org.uk>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101126045912.GC6598@lixom.net>
	<AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
	<20101126091832.GE9310@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimS-cSi1B5LdtwhJWhKDuFKOYG1j_p-iQiH=zRe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 11:18 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 26, 2010 at 10:53:10AM +0200, Ohad Ben-Cohen wrote:
>> >> +int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
>> >> +{
>> >> + ? ? int ret;
>> >> +
>> >> + ? ? if (unlikely(!hwlock)) {
>> >> + ? ? ? ? ? ? pr_err("invalid hwlock\n");
>> >
>> > These kind of errors can get very spammy for buggy drivers.
>>
>> Yeah, but that's the purpose - I want to catch such egregious drivers
>> who try to crash the kernel.
>
> That can be better - because you get a backtrace, and it causes people
> to report the problem rather than just ignore it. ?It may also prevent
> the driver author releasing his code (as it won't work on their
> initial testing.)
>
...
>
> If it's "extremely buggy behaviour" then the drivers deserve to crash.
> Such stuff should cause them not to get out the door. ?A simple printk
> with an error return can just be ignored.

I like this approach too, but recently we had a few privilege
escalation exploits which involved NULL dereference kernel bugs
(process context mapped address 0 despite a positive mmap_min_addr).

Since we can't rely on the oops to always happen, I decided not to
omit the NULL checks.

>
