From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2016 23:47:36 +0100
Subject: [PATCH v8 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <CADyBb7tR4+78k52JrVZGo9FMuO8a8RBTTYK7PBx1RzP3Lx9snQ@mail.gmail.com>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
 <1468952284-28942-5-git-send-email-fu.wei@linaro.org>
 <20160725090258.GA15864@arm.com>
 <CADyBb7tR4+78k52JrVZGo9FMuO8a8RBTTYK7PBx1RzP3Lx9snQ@mail.gmail.com>
Message-ID: <20160725224736.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 11:50:19PM +0800, Fu Wei wrote:
> Hi Will,
> 
> On 25 July 2016 at 17:02, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 20, 2016 at 02:17:59AM +0800, fu.wei at linaro.org wrote:
> >> From: Fu Wei <fu.wei@linaro.org>
> >>
> >> This patch simplify arch_counter_get_cntvct_mem function by
> >> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
> >>
> >> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> >> ---
> >>  drivers/clocksource/arm_arch_timer.c | 10 +---------
> >>  1 file changed, 1 insertion(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> >> index e6fd42d..483d2f9 100644
> >> --- a/drivers/clocksource/arm_arch_timer.c
> >> +++ b/drivers/clocksource/arm_arch_timer.c
> >> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
> >>
> >>  static u64 arch_counter_get_cntvct_mem(void)
> >>  {
> >> -     u32 vct_lo, vct_hi, tmp_hi;
> >> -
> >> -     do {
> >> -             vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> >> -             vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> >> -             tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> >> -     } while (vct_hi != tmp_hi);
> >> -
> >> -     return ((u64) vct_hi << 32) | vct_lo;
> >> +     return readq(arch_counter_base + CNTVCT_LO);
> >
> 
> Sorry, right after posting v9, I got your comment,
> 
> > What's the benefit of doing this? If you use readq here, how can we
> 
> benefit:
> 1. simplify the code
> 2. from arch/arm64/include/asm/io.h, I guess readq is more efficient

And the harm is that it breaks the build on ARM, because ARM doesn't
provide readq (as it can't, as not all CPUs on ARM support 64-bit
reads) and it's not appropriate for architecture code to emulate it.
Consider carefully why the original code has that loop present -
only a device driver hows how to read a 64-bit register safely using
two 32-bit reads.  Such a loop may not be appropriate for some other
device.

So... as the 0-day builder detected a failure on ARM with this, NAK.

If you want to make this conditional on readq() being present, that'd
be acceptable, but you must support the case where readq() is not
provided.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
