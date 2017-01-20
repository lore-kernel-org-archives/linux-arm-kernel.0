From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 20 Jan 2017 20:54:58 +0100
Subject: [PATCH v10 7/8] arm/arm64: vgic: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <CAFEAcA-Ev4_949mRvagAa0wtMnUZBuQmMssWsMs3JPTBw_FviQ@mail.gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-8-git-send-email-vijay.kilari@gmail.com>
 <4272e489-7aa4-b77d-ec09-22b58af78336@redhat.com>
 <CAFEAcA-Ev4_949mRvagAa0wtMnUZBuQmMssWsMs3JPTBw_FviQ@mail.gmail.com>
Message-ID: <20170120195458.GI13531@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 12:44:18PM +0000, Peter Maydell wrote:
> On 16 December 2016 at 12:07, Auger Eric <eric.auger@redhat.com> wrote:
> > Hi Vijaya,
> >
> > On 01/12/2016 08:09, vijay.kilari at gmail.com wrote:
> >> +void vgic_write_irq_line_level_info(struct kvm_vcpu *vcpu, u32 intid,
> >> +                                 const u64 val)
> >> +{
> >> +     int i;
> >> +
> >> +     for (i = 0; i < 32; i++) {
> >> +             struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
> >> +
> > same as above.
> >> +             spin_lock(&irq->irq_lock);
> >> +             if (val & (1U << i)) {
> >> +                     if (irq->config == VGIC_CONFIG_LEVEL) {
> >> +                             irq->line_level = true;
> >> +                             irq->pending = true;
> >> +                             vgic_queue_irq_unlock(vcpu->kvm, irq);
> >> +                     } else {
> >> +                             spin_unlock(&irq->irq_lock);
> >> +                     }
> >> +             } else {
> >> +                     if (irq->config == VGIC_CONFIG_EDGE ||
> > can't we just ignore VGIC_CONFIG_EDGE case for which line_level is not
> > modeled?
> >> +                         (irq->config == VGIC_CONFIG_LEVEL &&
> >> +                         !irq->soft_pending))
> >> +                             irq->line_level = false;
> > To me the line level does not depend on the soft_pending bit. The
> > pending state depends on both.
> 
> Without having looked at the details, it seems surprising to
> me that the implementation of "set line level to X" is not
> "set irq->line_level to X; figure out consequences and update
> other state as necessary"...
> 
Indeed.  Assuming you're ok with the API requiring config state to be
restored before the line level state, I think my suggestion in the
separate reply should work.

Of course, we need to clarify the ordering requirement in the API.

Thanks,
-Christoffer
