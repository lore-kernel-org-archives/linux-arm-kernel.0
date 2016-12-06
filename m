From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Dec 2016 15:30:48 +0100
Subject: [PATCH v9 01/11] arm/arm64: vgic: Implement support for
 userspace access
In-Reply-To: <20c63256-48f7-692c-1c6c-c4fcdb82f401@redhat.com>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
 <1479906118-15832-2-git-send-email-vijay.kilari@gmail.com>
 <20161128130512.GC18170@cbox>
 <20c63256-48f7-692c-1c6c-c4fcdb82f401@redhat.com>
Message-ID: <20161206143048.GC4816@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 12:42:09PM +0100, Auger Eric wrote:
> Hi,
> 
> On 28/11/2016 14:05, Christoffer Dall wrote:
> > On Wed, Nov 23, 2016 at 06:31:48PM +0530, vijay.kilari at gmail.com wrote:
> >> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> >>
> >> Read and write of some registers like ISPENDR and ICPENDR
> >> from userspace requires special handling when compared to
> >> guest access for these registers.
> >>
> >> Refer to Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> >> for handling of ISPENDR, ICPENDR registers handling.
> >>
> >> Add infrastructure to support guest and userspace read
> >> and write for the required registers
> >> Also moved vgic_uaccess from vgic-mmio-v2.c to vgic-mmio.c
> >>
> >> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> >> ---
> >>  virt/kvm/arm/vgic/vgic-mmio-v2.c |  25 ----------
> >>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 102 ++++++++++++++++++++++++++++++++-------
> >>  virt/kvm/arm/vgic/vgic-mmio.c    |  78 +++++++++++++++++++++++++++---
> >>  virt/kvm/arm/vgic/vgic-mmio.h    |  19 ++++++++
> >>  4 files changed, 175 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >> index b44b359..0b32f40 100644
> >> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> >> @@ -406,31 +406,6 @@ int vgic_v2_has_attr_regs(struct kvm_device *dev, struct kvm_device_attr *attr)
> >>  	return -ENXIO;
> >>  }
> >>  
> >> -/*
> >> - * When userland tries to access the VGIC register handlers, we need to
> >> - * create a usable struct vgic_io_device to be passed to the handlers and we
> >> - * have to set up a buffer similar to what would have happened if a guest MMIO
> >> - * access occurred, including doing endian conversions on BE systems.
> >> - */
> >> -static int vgic_uaccess(struct kvm_vcpu *vcpu, struct vgic_io_device *dev,
> >> -			bool is_write, int offset, u32 *val)
> >> -{
> >> -	unsigned int len = 4;
> >> -	u8 buf[4];
> >> -	int ret;
> >> -
> >> -	if (is_write) {
> >> -		vgic_data_host_to_mmio_bus(buf, len, *val);
> >> -		ret = kvm_io_gic_ops.write(vcpu, &dev->dev, offset, len, buf);
> >> -	} else {
> >> -		ret = kvm_io_gic_ops.read(vcpu, &dev->dev, offset, len, buf);
> >> -		if (!ret)
> >> -			*val = vgic_data_mmio_bus_to_host(buf, len);
> >> -	}
> >> -
> >> -	return ret;
> >> -}
> >> -
> >>  int vgic_v2_cpuif_uaccess(struct kvm_vcpu *vcpu, bool is_write,
> >>  			  int offset, u32 *val)
> >>  {
> >> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> >> index 50f42f0..8e76d04 100644
> >> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> >> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> >> @@ -207,6 +207,66 @@ static unsigned long vgic_mmio_read_v3_idregs(struct kvm_vcpu *vcpu,
> >>  	return 0;
> >>  }
> >>  
> >> +static unsigned long vgic_v3_uaccess_read_pending(struct kvm_vcpu *vcpu,
> >> +						  gpa_t addr, unsigned int len)
> >> +{
> >> +	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
> >> +	u32 value = 0;
> >> +	int i;
> >> +
> >> +	/*
> >> +	 * A level triggerred interrupt pending state is latched in both
> >> +	 * "soft_pending" and "line_level" variables. Userspace will save
> >> +	 * and restore soft_pending and line_level separately.
> >> +	 * Refer to Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> >> +	 * handling of ISPENDR and ICPENDR.
> >> +	 */
> >> +	for (i = 0; i < len * 8; i++) {
> >> +		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
> >> +
> >> +		if (irq->config == VGIC_CONFIG_LEVEL && irq->soft_pending)
> >> +			value |= (1U << i);
> >> +		if (irq->config == VGIC_CONFIG_EDGE && irq->pending)
> >> +			value |= (1U << i);
> >> +
> >> +		vgic_put_irq(vcpu->kvm, irq);
> >> +	}
> >> +
> >> +	return value;
> >> +}
> >> +
> >> +static void vgic_v3_uaccess_write_pending(struct kvm_vcpu *vcpu,
> >> +					  gpa_t addr, unsigned int len,
> >> +					  unsigned long val)
> >> +{
> >> +	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
> >> +	int i;
> >> +
> >> +	for (i = 0; i < len * 8; i++) {
> >> +		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
> >> +
> >> +		spin_lock(&irq->irq_lock);
> >> +		if (test_bit(i, &val)) {
> >> +			/* soft_pending is set irrespective of irq type
> >> +			 * (level or edge) to avoid dependency that VM should
> >> +			 * restore irq config before pending info.
> >> +			 */
> > 
> > nit: kernel commenting style
> > 
> >> +			irq->pending = true;
> >> +			irq->soft_pending = true;
> >> +			vgic_queue_irq_unlock(vcpu->kvm, irq);
> >> +		} else {
> >> +			irq->soft_pending = false;
> >> +			if (irq->config == VGIC_CONFIG_EDGE ||
> >> +			    (irq->config == VGIC_CONFIG_LEVEL &&
> >> +			    !irq->line_level))
> >> +				irq->pending = false;
> I am confused by the comment above. Since we test the irq config here
> don't we assume the config was restored before the pending state?

THe idea here was that if you're setting the value, then if you later
set the config to level, then the soft_pending state has already been
set properly, and if the irq stays an edge, then it doesn't matter what
that field is.

If you read the value, the assumption is that you're reading a
consistently configured GIC, if not, then all bets are off anyhow.

Does that make sense?

Perhaps only the comment should be adjusted or do you think the logic is
flawed?

Thanks,
-Christoffer
