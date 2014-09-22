From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 23:07:10 +0100
Subject: [GIT PULL] arm/arm64: KVM: Fix unaligned access bug on gicv2
 access
In-Reply-To: <1411420350-368-2-git-send-email-christoffer.dall@linaro.org>
References: <1411420350-368-1-git-send-email-christoffer.dall@linaro.org>
 <1411420350-368-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140922220710.GA24499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 10:12:30PM +0100, Christoffer Dall wrote:
> We were using an atomic bitop on the vgic_v2.vgic_elrsr field which was
> not aligned to the natural size on 64-bit platforms.  This bug showed up
> after QEMU correctly identifies the pl011 line as being level-triggered,
> and not edge-triggered.
> 
> These data structures are protected by a spinlock so simply use a
> non-atomic version of the accessor instead.
> 
> Tested-by: Joel Schopp <joel.schopp@amd.com>
> Reported-by: Riku Voipio <riku.voipio@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/arm/vgic-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> index 01124ef..416baed 100644
> --- a/virt/kvm/arm/vgic-v2.c
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -71,7 +71,7 @@ static void vgic_v2_sync_lr_elrsr(struct kvm_vcpu *vcpu, int lr,
>  				  struct vgic_lr lr_desc)
>  {
>  	if (!(lr_desc.state & LR_STATE_MASK))
> -		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
> +		__set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
>  }

Does this work for big-endian arm64 machines? Surely the bug is due to
casting a u32 * to an unsigned long *, and not specifically related to
atomics (which is where it happened to explode)?

Will
