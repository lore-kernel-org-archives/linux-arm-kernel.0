From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Nov 2014 13:45:22 +0100
Subject: [PATCH v3 17/19] arm64: KVM: add SGI system register trapping
In-Reply-To: <5460A20B.2010107@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-18-git-send-email-andre.przywara@arm.com>
 <20141107150722.GS16132@cbox> <5460A20B.2010107@arm.com>
Message-ID: <20141110124522.GC7544@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 11:31:23AM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 07/11/14 15:07, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:52PM +0000, Andre Przywara wrote:
> >> While the injection of a (virtual) inter-processor interrupt (SGI)
> >> on a GICv2 works by writing to a MMIO register, GICv3 uses system
> >> registers to trigger them.
> >> Trap the appropriate registers on ARM64 hosts and call the SGI
> >
> > Are you actually enabling the trapping here or just putting the trap
> > handler in place?  As I understood so far, we still configure the guest
> > at this point to raise an unexpected exception in the guest if it tries
> > to eaccess the system registers; did I get this wrong?
> 
> You are right, the changes in the patch series at this point are not yet
> visible to userland (and hence the guest), so any guest access to any
> kind of GICv3 registers (MMIO or sysreg) should still fail at this point.
> So a guest Linux GICv3 driver will never issue those MSRs if there is no
> DT node present, but any attempt should still fail nevertheless, since
> the GICv3 structures are not properly initialized.

Shouldn't any guest accesses to these registers just raise an undef
exception in the guest because we're not yet setting SRE?

In any case, it seems your commit message is misleading and should be
rewritten.


> 
> >> handler function in the vGICv3 emulation code.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  arch/arm64/kvm/sys_regs.c |   26 ++++++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index dcc5867..cf0452e 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
> >>      return true;
> >>  }
> >>
> >> +/*
> >> + * Trapping on the GICv3 SGI system register.
> >
> > Use the architecture name for the register here.
> >
> >> + * Forward the request to the VGIC emulation.
> >> + * The cp15_64 code makes sure this automatically works
> >> + * for both AArch64 and AArch32 accesses.
> >> + */
> >> +static bool access_gic_sgi(struct kvm_vcpu *vcpu,
> >> +                       const struct sys_reg_params *p,
> >> +                       const struct sys_reg_desc *r)
> >> +{
> >> +    u64 val;
> >> +
> >> +    if (!p->is_write)
> >> +            return read_from_write_only(vcpu, p);
> >> +
> >> +    val = *vcpu_reg(vcpu, p->Rt);
> >> +    vgic_v3_dispatch_sgi(vcpu, val);
> >
> > So do we guarantee somehow that we'll never get here if userspace didn't
> > successfully create a virtual GICv3?
> 
> No :-( Nothing prevents a guest from writing to this architectural
> sysreg, but it shouldn't do since nothing tells it yet about a GICv3 yet.

I really don't care whether the guest should or should not do something,
if something is possible, we need to handle it.

> 
> What about just introducing the handler functions in this patch and
> wiring them up in the sys_reg_descs struct later with the final
> enablement patch?

yes, but that's not what this comment is about.

> This would provoke a compile warning though due to the unused static
> functions. Is it worth to declare them as non-static until there are
> referenced in the later patch?
> 
> Is there any other trick to avoid this warning or to work around this issue?
> 
Hmmm, my concern is that you're calling vgic_v3_dispatch_sgi(), but
you're not doing anything to check if irqchip_in_kernel(), so I just
didn't manage to think through the entire flow, in the sense of whether
we've excluded this function from ever being called if the gicv3 is not
created (becasue we never set SRE, for example).

I'd like to avoid a host NULL pointer dereference just because the guest
is being a little naughty.

-Christoffer
