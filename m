From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Nov 2016 09:13:18 -0800
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161118125409.GK1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
Message-ID: <CAD=FV=VoycW9btkdKubq_Uxh52PYK5R1X2GD10DcxRQj2K-_UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 18, 2016 at 4:54 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Nov 18, 2016 at 12:06:30PM +0000, Will Deacon wrote:
>> On Tue, Nov 15, 2016 at 02:36:33PM +0100, Mason wrote:
>> > When polling a tick counter in a busy loop, one might sample the
>> > counter just *before* it is updated, and then again just *after*
>> > it is updated. In that case, while mathematically v2-v1 equals 1,
>> > only epsilon has really passed.
>> >
>> > So, if a caller requests an N-cycle delay, we spin until v2-v1
>> > is strictly greater than N to avoid these random corner cases.
>> >
>> > Signed-off-by: Mason <slash.tmp@free.fr>
>> > ---
>> >  arch/arm/lib/delay.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>> > index 69aad80a3af4..3f1cd15ca102 100644
>> > --- a/arch/arm/lib/delay.c
>> > +++ b/arch/arm/lib/delay.c
>> > @@ -60,7 +60,7 @@ static void __timer_delay(unsigned long cycles)
>> >  {
>> >     cycles_t start = get_cycles();
>> >
>> > -   while ((get_cycles() - start) < cycles)
>> > +   while ((get_cycles() - start) <= cycles)
>> >             cpu_relax();
>> >  }
>>
>> I thought a bit about this last night. It is well known that the delay
>> routines are not guaranteed to be accurate, and I don't *think* that's
>> limited to over-spinning, so arguably this isn't a bug. However, taking
>> the approach that "drivers should figure it out" is also unhelpful,
>> because the frequency of the underlying counter isn't generally known
>> and so drivers can't simply adjust the delay parameter.
>
> I don't think this change makes any sense whatsoever.  udelay() is
> inaccurate, period.  It _will_ give delays shorter than requested
> for many reasons, many of which can't be fixed.
>
> Having a super-accurate version just encourages people to write broken
> drivers which assume (eg) that udelay(10) will give _at least_ a 10us
> delay.  However, there is no such guarantee.
>
> So, having udelay() for timers return slightly short is actually a good
> thing - it causes people not to make the mistake to be soo accurate
> with their delay specifications.
>
> So, NAK on this change.  udelay is not super-accurate.
>
> Reference (and this is the most important one):
>
>   http://lists.openwall.net/linux-kernel/2011/01/12/372

Mason's change adds no complexity to the code and seems like a
generally good idea.

As per John Stultz [1] there is agreement that udelay() really
shouldn't delay less than the requested amount.  In fact, we even have
a test committed to the tree: "kernel/time/test_udelay.c".  As your
reference says, maybe 1% isn't enough to throw a hissyfit about, but
when the change is so simple and adds no complexity then it seems like
a worthwhile thing to do.  Why make things inaccurate for no reason?

[1] http://www.gossamer-threads.com/lists/linux/kernel/1918249


For what it's worth, Mason's change is:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
