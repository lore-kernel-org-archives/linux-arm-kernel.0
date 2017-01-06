From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 6 Jan 2017 11:53:22 +0100
Subject: [RFC PATCH 4/7] KVM: arm/arm64: Check that system supports split
 eoi/deactivate
In-Reply-To: <c3f788da-4cae-76ee-d186-ad44fcf3a318@arm.com>
References: <20161210204712.21830-1-christoffer.dall@linaro.org>
 <20161210204712.21830-5-christoffer.dall@linaro.org>
 <7e44980f-d4b9-a5d0-b0a9-5424548300d8@arm.com>
 <20170106100257.GD21089@cbox>
 <c3f788da-4cae-76ee-d186-ad44fcf3a318@arm.com>
Message-ID: <20170106105322.GC27758@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 10:24:04AM +0000, Marc Zyngier wrote:
> On 06/01/17 10:02, Christoffer Dall wrote:
> > On Thu, Jan 05, 2017 at 05:40:58PM +0000, Marc Zyngier wrote:
> >> On 10/12/16 20:47, Christoffer Dall wrote:
> >>> Some systems without proper firmware and/or hardware description data
> >>> don't support the split EOI and deactivate operation and therefore
> >>> don't provide an irq_set_vcpu_affinity implementation.  On such
> >>> systems, we cannot leave the physical interrupt active after the timer
> >>> handler on the host has run, so we cannot support KVM with the timer
> >>> changes we about to introduce.
> >>>
> >>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >>> ---
> >>>  virt/kvm/arm/arch_timer.c | 30 ++++++++++++++++++++++++++++++
> >>>  1 file changed, 30 insertions(+)
> >>>
> >>> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> >>> index c7c3bfd..f27a086 100644
> >>> --- a/virt/kvm/arm/arch_timer.c
> >>> +++ b/virt/kvm/arm/arch_timer.c
> >>> @@ -418,6 +418,31 @@ static int kvm_timer_dying_cpu(unsigned int cpu)
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static bool has_split_eoi_deactivate_support(void)
> >>> +{
> >>> +	struct irq_desc *desc;
> >>> +	struct irq_data *data;
> >>> +	struct irq_chip *chip;
> >>> +
> >>> +	/*
> >>> +	 * Check if split EOI and deactivate is supported on this machine.
> >>> +	 */
> >>> +	desc = irq_to_desc(host_vtimer_irq);
> >>> +	if (!desc) {
> >>> +		kvm_err("kvm_arch_timer: no host_vtimer_irq descriptor\n");
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	data = irq_desc_get_irq_data(desc);
> >>> +	chip = irq_data_get_irq_chip(data);
> >>> +	if (!chip || !chip->irq_set_vcpu_affinity) {
> >>> +		kvm_err("kvm_arch_timer: no split EOI/deactivate; abort\n");
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	return true;
> >>> +}
> >>
> >> That feels really involved. How about reporting that we don't have a
> >> usable VGIC altogether from the GIC driver?
> >>
> > 
> > You mean not booting the kernel at all, or establish some communication
> > from the GIC driver to KVM, telling KVM if it's usable for
> > virtualization or not?
> 
> We already query the vgic configuration by calling gic_get_kvm_info() at
> boot time. My suggestion is to make it return NULL if the GIC can't
> support split EOI/deactivate, and fallback to the "no-vgic" mode, if
> ever implemented.
> 

That sounds good to me.

Thanks,
-Christoffer
