From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jul 2016 11:44:07 +0100
Subject: [PATCH 2/2] arm-cci: ensure perf synchronisation
In-Reply-To: <20160704103130.GA6774@leverpostej>
References: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
 <1467136218-15789-3-git-send-email-mark.rutland@arm.com>
 <20160704102205.GD1639@arm.com> <20160704103130.GA6774@leverpostej>
Message-ID: <20160704104407.GB6774@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 11:31:31AM +0100, Mark Rutland wrote:
> On Mon, Jul 04, 2016 at 11:22:05AM +0100, Will Deacon wrote:
> > On Tue, Jun 28, 2016 at 06:50:18PM +0100, Mark Rutland wrote:
> > > Currently the IRQ core is permitted to make the CCI PMU IRQ handler
> > > threaded, and will allow userspace to change the CPU affinity of the
> > > interrupt behind our back. Both of these could violate our
> > > synchronisation requirements with the core perf code, which relies upon
> > > strict CPU affinity and disabling of interrupts to guarantee mutual
> > > exclusion in some cases.
> > 
> > Minor nit, but I think $subject is particularly unhelpful for these two
> > patches. How about "arm-ccX: fix PMU interrupt flags"?
> 
> Sure, I'll move over to that wording.
> 
> > > @@ -881,7 +881,8 @@ static int pmu_request_irq(struct cci_pmu *cci_pmu, irq_handler_t handler)
> > >  	 * This should allow handling of non-unique interrupt for the counters.
> > >  	 */
> > >  	for (i = 0; i < cci_pmu->nr_irqs; i++) {
> > > -		int err = request_irq(cci_pmu->irqs[i], handler, IRQF_SHARED,
> > 
> > Why is this shared and who is the line shared with? We should check that
> > we don't have contradictory IRQ flags in the other irq request path(s).
> 
> Hmm... I thought that was so the driver could request the same IRQ
> multiple times in the case of muxing, but I see we've always had the
> is_duplicate_irq logic.
> 
> The IRQF_SHARED flags has also been there since day one, so I'm not sure
> if that's needed for some platform or whether that was added out of
> habit.
> 
> Punit, do you recall if/why IRQF_SHARED was used?
> 
> I'll take a look at dts and see if I can get rid of it.

Tree-wide there only appears to be one instance of the pmu node:

[mark at leverpostej:~/src/linux]% git grep 'cci-.*-pmu' -- arch
arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts:                      compatible = "arm,cci-400-pmu,r0";

Which has locally-unique interrupts...

pmu at 9000 {
         compatible = "arm,cci-400-pmu,r0";
         reg = <0x9000 0x5000>;
         interrupts = <0 105 4>,
                      <0 101 4>,
                      <0 102 4>,
                      <0 103 4>,
                      <0 104 4>;
};

.. and from reading the A15x2-A7x3 board TRM, they're globally unique (i.e. not
shared) too.

I'll drop the IRQF_SHARED in v2.

Thanks,
Mark.
