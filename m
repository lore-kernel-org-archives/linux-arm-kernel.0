From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Aug 2016 12:49:09 +0200
Subject: [RFC PATCH v3 1/5] arm/arm64: vgic-new: Implement support for
 userspace access
In-Reply-To: <20160830103150.GE10162@cbox>
References: <1472037609-4164-1-git-send-email-vijay.kilari@gmail.com>
 <1472037609-4164-2-git-send-email-vijay.kilari@gmail.com>
 <20160830103150.GE10162@cbox>
Message-ID: <20160830104909.GF10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[replying to myself...]

On Tue, Aug 30, 2016 at 12:31:50PM +0200, Christoffer Dall wrote:
> On Wed, Aug 24, 2016 at 04:50:05PM +0530, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

[...]

> 
> >  static const struct vgic_register_region vgic_v3_dist_registers[] = {
> >  	REGISTER_DESC_WITH_LENGTH(GICD_CTLR,
> >  		vgic_mmio_read_v3_misc, vgic_mmio_write_v3_misc, 16,
> > @@ -380,11 +400,13 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
> >  	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ICENABLER,
> >  		vgic_mmio_read_enable, vgic_mmio_write_cenable, 1,
> >  		VGIC_ACCESS_32bit),
> > -	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ISPENDR,
> > -		vgic_mmio_read_pending, vgic_mmio_write_spending, 1,
> > +	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED_UACCESS(GICD_ISPENDR,
> > +		vgic_mmio_read_pending, vgic_mmio_write_spending,
> > +		vgic_mmio_read_soft_pending, vgic_mmio_write_spending, 1,
> 
> You need a uaccess for the write part as well to provide raw access to
> the latch state, without imposing any ordering requirements for the
> restore part of userspace.  For example, you cannot rely on userspace
> having restored the configuration state of the IRQs before the pending
> state, unless we modify the API to require this.
> 
> I think you need a function that looks very similar tot he
> write_spending function, but which always sets the soft_pending state,
> regardless of the configuration of the IRQ.
> 
> We need to tweak the vgic_mmio_write_config function to queue interrupts
> that become pending when changed to LEVEL to go along with this.  I can
> send a patch with this separately.
> 
> 

Thinking about this some more, this last part of my comment, about
vgic_mmio_write_config, is not necessary.

If we implement the uaccess_write_pending such that we call
vgic_queue_irq_unlock when setting the pending state, then we obviously
don't need to do it again later, just because we're changing the
configuration.

Another thing I forgot to say was that the API also specifies that
writes to the CPENDR registers are ignored and writes to the SPENDR
register directly set the latch state, so I you need to make sure the
uaccess writes to CPENDR are ignored and that the writes to SPENDR can
both set/clear the values.

I think the uaccess_write_pending function needs to look something like
this (completely untested):

void vgic_uaccess_write_pending(struct kvm_vcpu *vcpu,
				gpa_t addr, unsigned int len,
				unsigned long val)
{
	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
	int i;

	for (i = 0; i < len * 8; i++) {
		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);

		spin_lock(&irq->irq_lock);
		if (test_bit(i, &val)) {
			irq->pending = true;
			irq->soft_pending = true;
			vgic_queue_irq_unlock(vcpu->kvm, irq);
		} else {
			irq->soft_pending = false;
			if (irq->config == VGIC_CONFIG_EDGE ||
			    (irq->config == VGIC_CONFIG_LEVEL && !irq->line_level))
				irq->pending = false;
			spin_unlock(&irq->irq_lock);
		}

		vgic_put_irq(vcpu->kvm, irq);
	}
}


Thanks,
-Christoffer
