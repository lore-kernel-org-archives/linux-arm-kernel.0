From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 26 Jul 2016 17:21:03 +0800
Subject: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <20160725224957.GU1041@n2100.armlinux.org.uk>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
 <20160725153118.GD19209@arm.com>
 <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg@mail.gmail.com>
 <20160725163144.GE19209@arm.com> <20160725224957.GU1041@n2100.armlinux.org.uk>
Message-ID: <CADyBb7s__Cr1v1UBS+CdSNGcAAZTgPYG+DmzcmwMsDDy8sDnxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,

On 26 July 2016 at 06:49, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jul 25, 2016 at 05:31:45PM +0100, Will Deacon wrote:
>> On Mon, Jul 25, 2016 at 11:55:49PM +0800, Fu Wei wrote:
>> > On 25 July 2016 at 23:31, Will Deacon <will.deacon@arm.com> wrote:
>> > > On Mon, Jul 25, 2016 at 11:27:02PM +0800, fu.wei at linaro.org wrote:
>> > >> From: Fu Wei <fu.wei@linaro.org>
>> > >>
>> > >> This patch simplify arch_counter_get_cntvct_mem function by
>> > >> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
>> > >>
>> > >> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> > >> ---
>> > >>  drivers/clocksource/arm_arch_timer.c | 10 +---------
>> > >>  1 file changed, 1 insertion(+), 9 deletions(-)
>> > >>
>> > >> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> > >> index e6fd42d..483d2f9 100644
>> > >> --- a/drivers/clocksource/arm_arch_timer.c
>> > >> +++ b/drivers/clocksource/arm_arch_timer.c
>> > >> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
>> > >>
>> > >>  static u64 arch_counter_get_cntvct_mem(void)
>> > >>  {
>> > >> -     u32 vct_lo, vct_hi, tmp_hi;
>> > >> -
>> > >> -     do {
>> > >> -             vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> > >> -             vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>> > >> -             tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> > >> -     } while (vct_hi != tmp_hi);
>> > >> -
>> > >> -     return ((u64) vct_hi << 32) | vct_lo;
>> > >> +     return readq(arch_counter_base + CNTVCT_LO);
>> > >
>> > > Please drop this patch. It doesn't work.
>> >
>> > I am OK to drop this, but could you let me know why it doesn't work?
>> >
>> > I did get some problem on Foundation model about readq, but it works on Seattle.
>> > I guess that is a problem of model, but not a code problem.
>> > So I just got confused, why readq  doesn't work,  :-)
>>
>> The kernel really needs to support both of those platforms :/
>>
>> For the memory-mapped counter registers, the architecture says:
>>
>>   `If the implementation supports 64-bit atomic accesses, then the
>>    CNTV_CVAL register must be accessible as an atomic 64-bit value.'
>>
>> which is borderline tautological. If we take the generous reading that
>> this means AArch64 CPUs can use readq (and I'm not completely
>> comfortable with that assertion, particularly as you say that it breaks
>> the model), then you still need to use readq_relaxed here to avoid a
>> DSB. Furthermore, what are you going to do for AArch32? readq doesn't
>> exist over there, and if you use the generic implementation then it's
>> not atomic. In which case, we end up with the current code, as well as a
>> readq_relaxed guarded by a questionable #ifdef that is known to break a
>> supported platform for an unknown performance improvement. Hardly a big
>> win.
>>
>> Did you see any performance advantage from this? Given that you've added
>> a DSB, this looks to be extremely premature.
>
> +1, absolutely agreed on the 32-bit ARM bits.

Sorry for misunderstanding it, will drop it in v10.

Great thanks for your help! :-)

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
