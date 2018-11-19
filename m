From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 19 Nov 2018 17:07:27 +0000
Subject: [RFC PATCH v2 14/23] KVM: Allow 2048-bit register access via
 ioctl interface
In-Reply-To: <87r2fhhv2z.fsf@linaro.org>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-15-git-send-email-Dave.Martin@arm.com>
 <87r2fhhv2z.fsf@linaro.org>
Message-ID: <20181119170727.GY3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 04:48:36PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > The Arm SVE architecture defines registers that are up to 2048 bits
> > in size (with some possibility of further future expansion).
> >
> > In order to avoid the need for an excessively large number of
> > ioctls when saving and restoring a vcpu's registers, this patch
> > adds a #define to make support for individual 2048-bit registers
> > through the KVM_{GET,SET}_ONE_REG ioctl interface official.  This
> > will allow each SVE register to be accessed in a single call.
> >
> > There are sufficient spare bits in the register id size field for
> > this change, so there is no ABI impact providing that
> > KVM_GET_REG_LIST does not enumerate any 2048-bit register unless
> > userspace explicitly opts in to the relevant architecture-specific
> > features.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  include/uapi/linux/kvm.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 251be35..7c3c5cc 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1110,6 +1110,7 @@ struct kvm_dirty_tlb {
> >  #define KVM_REG_SIZE_U256	0x0050000000000000ULL
> >  #define KVM_REG_SIZE_U512	0x0060000000000000ULL
> >  #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
> > +#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
> 
> Yeah OK I guess - but it does make me question if KVM_REG_SIZE_MASK is
> part of the ABI because although we have space for another few bits that
> is the last one without changing the mask.

Debatable, but KVM_REG_SIZE_MASK is UAPI and suggests a clear intent not
to recycle bit 55 for another purpose.  This allows for reg sizes up to
262144 bits which is hopefully more than enough for the foreseeable
future.

Even if bits 56-59 are currently always 0, KVM_REG_ARCH_MASK suggests
that these bits aren't going to be used for size field bits.


Or am I missing something?

> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Thanks
---Dave
