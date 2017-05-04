From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 4 May 2017 09:32:15 +0200
Subject: [PATCH v5 21/22] KVM: arm64: vgic-its: Fix pending table sync
In-Reply-To: <03432fc8-5e39-2f50-1e36-1c4b2f9be773@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-22-git-send-email-eric.auger@redhat.com>
 <20170430211033.GD1499@lvm>
 <03432fc8-5e39-2f50-1e36-1c4b2f9be773@redhat.com>
Message-ID: <20170504073215.GB5923@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 12:20:13AM +0200, Auger Eric wrote:
> Hi,
> 
> On 30/04/2017 23:10, Christoffer Dall wrote:
> > On Fri, Apr 14, 2017 at 12:15:33PM +0200, Eric Auger wrote:
> >> In its_sync_lpi_pending_table() we currently ignore the
> >> target_vcpu of the LPIs. We sync the pending bit found in
> >> the vcpu pending table even if the LPI is not targeting it.
> >>
> >> Also in vgic_its_cmd_handle_invall() we are supposed to
> >> read the config table data for the LPIs associated to the
> >> collection ID. At the moment we refresh all LPI config
> >> information.
> >>
> >> This patch passes a vpcu to vgic_copy_lpi_list() so that
> >> this latter returns a snapshot of the LPIs targeting this
> >> CPU and only those.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  virt/kvm/arm/vgic/vgic-its.c | 24 ++++++++++++------------
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> >> index 86dfc6c..be848be 100644
> >> --- a/virt/kvm/arm/vgic/vgic-its.c
> >> +++ b/virt/kvm/arm/vgic/vgic-its.c
> >> @@ -252,13 +252,13 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
> >>  }
> >>  
> >>  /*
> >> - * Create a snapshot of the current LPI list, so that we can enumerate all
> >> - * LPIs without holding any lock.
> >> - * Returns the array length and puts the kmalloc'ed array into intid_ptr.
> >> + * Create a snapshot of the current LPIs targeting @vcpu, so that we can
> >> + * enumerate those LPIs without holding any lock.
> >> + * Returns their number and puts the kmalloc'ed array into intid_ptr.
> >>   */
> >> -static int vgic_copy_lpi_list(struct kvm *kvm, u32 **intid_ptr)
> >> +static int vgic_copy_lpi_list(struct kvm_vcpu *vcpu, u32 **intid_ptr)
> >>  {
> >> -	struct vgic_dist *dist = &kvm->arch.vgic;
> >> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >>  	struct vgic_irq *irq;
> >>  	u32 *intids;
> >>  	int irq_count = dist->lpi_list_count, i = 0;
> >> @@ -277,14 +277,14 @@ static int vgic_copy_lpi_list(struct kvm *kvm, u32 **intid_ptr)
> >>  	spin_lock(&dist->lpi_list_lock);
> >>  	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
> >>  		/* We don't need to "get" the IRQ, as we hold the list lock. */
> >> -		intids[i] = irq->intid;
> >> -		if (++i == irq_count)
> >> -			break;
> >> +		if (irq->target_vcpu != vcpu)
> >> +			continue;
> >> +		intids[i++] = irq->intid;
> > 
> > were we checking the ++i == irq_count condition for no good reason
> > before since we can just drop it now?
> I didn't get why we had that check.
> 

ok, Andre is cc'ed so unless he complains let's just get rid of it.

Thanks,
-Christoffer
