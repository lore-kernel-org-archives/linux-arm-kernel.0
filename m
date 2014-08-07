From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Aug 2014 10:06:14 +0100
Subject: [RFC PATCH 2/6] ARM64: perf: Re-enable overflow interrupt from
 interrupt handler
In-Reply-To: <CALrVBkvJ0qQnsJS_DVfRNBoeLGEc7szHzx4AzOAF9e9voWOy2Q@mail.gmail.com>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
 <1407230655-28864-3-git-send-email-anup.patel@linaro.org>
 <20140806142439.GS25953@arm.com>
 <CALrVBkvJ0qQnsJS_DVfRNBoeLGEc7szHzx4AzOAF9e9voWOy2Q@mail.gmail.com>
Message-ID: <20140807090614.GD13703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 10:03:58AM +0100, Anup Patel wrote:
> On 6 August 2014 19:54, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Aug 05, 2014 at 10:24:11AM +0100, Anup Patel wrote:
> >> A hypervisor will typically mask the overflow interrupt before
> >> forwarding it to Guest Linux hence we need to re-enable the overflow
> >> interrupt after clearing it in Guest Linux. Also, this re-enabling
> >> of overflow interrupt does not harm in non-virtualized scenarios.
> >>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> ---
> >>  arch/arm64/kernel/perf_event.c |    8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> >> index 47dfb8b..19fb140 100644
> >> --- a/arch/arm64/kernel/perf_event.c
> >> +++ b/arch/arm64/kernel/perf_event.c
> >> @@ -1076,6 +1076,14 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
> >>               if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
> >>                       continue;
> >>
> >> +             /*
> >> +              * If we are running under a hypervisor such as KVM then
> >> +              * hypervisor will mask the interrupt before forwarding
> >> +              * it to Guest Linux hence re-enable interrupt for the
> >> +              * overflowed counter.
> >> +              */
> >> +             armv8pmu_enable_intens(idx);
> >> +
> >
> > Really? This is a giant bodge in the guest to work around short-comings in
> > the hypervisor. Why can't we fix this properly using something like Marc's
> > irq forwarding code?
> 
> This change is in accordance with our previous RFC thread about
> PMU virtualization where Marc Z had suggest to do interrupt
> mask/unmask dance similar to arch-timer.
> 
> I have not tried Marc'z irq forwarding series. In next revision of this
> patchset, I will try to use Marc's irq forwarding approach.

That would be good. Judging by the colour Marc went when he saw this patch,
I don't think he intended you to hack perf in this way :)

Will
