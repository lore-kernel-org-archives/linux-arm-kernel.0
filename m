From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon, 6 Mar 2017 14:20:44 -0500
Subject: [PATCH v2] KVM: arm/arm64: Let vcpu thread modify its own active
 state
In-Reply-To: <1488807757-86131-1-git-send-email-christoffer.dall@linaro.org>
References: <1488807757-86131-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAHyh4xgQDy9t8YD2P_q8MSQfv_1wa9JicZkQKV2OQNG3w48+9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

thanks for submitting this patch.

On Mon, Mar 6, 2017 at 8:42 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> From: Jintack Lim <jintack@cs.columbia.edu>
>
> Currently, if a vcpu thread tries to change the active state of an
> interrupt which is already on the same vcpu's AP list,

"it'll loop forever" is remove accidentally in the commit message in v2?

> Since the VGIC
> mmio handler is called after a vcpu has already synced back the LR state
> to the struct vgic_irq, we can just let it proceed safely.
>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
> Changes since v1:
>  - Reworked comment
>  - Consider userspace accesses
>  - Get the right requester VCPU for GICv3 private IRQ accesses
>  - Tested using kvm-unit-tests and verified that it deadlocked without
>    this patch and passed the test with this patch :)

nice!

>
>  virt/kvm/arm/vgic/vgic-mmio.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> index 3654b4c..2a5db13 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> @@ -180,21 +180,37 @@ unsigned long vgic_mmio_read_active(struct kvm_vcpu *vcpu,
>  static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
>                                     bool new_active_state)
>  {
> +       struct kvm_vcpu *requester_vcpu;
>         spin_lock(&irq->irq_lock);
> +
> +       /*
> +        * The vcpu parameter here can mean multiple things depending on how
> +        * this function is called; when handling a trap from the kernel it
> +        * depends on the GIC version, and these functions are also called as
> +        * part of save/restore from userspace.
> +        *
> +        * Therefore, we have to figure out the requester in a reliable way.
> +        *
> +        * When accessing VGIC state from user space, the requester_vcpu is
> +        * NULL, which is fine, because we guarantee that no VCPUs are running
> +        * when accessing VGIC state from user space so irq->vcpu->cpu is
> +        * always -1.
> +        */
> +       requester_vcpu = kvm_arm_get_running_vcpu();
> +
>         /*
>          * If this virtual IRQ was written into a list register, we
>          * have to make sure the CPU that runs the VCPU thread has
> -        * synced back LR state to the struct vgic_irq.  We can only
> -        * know this for sure, when either this irq is not assigned to
> -        * anyone's AP list anymore, or the VCPU thread is not
> -        * running on any CPUs.
> +        * synced back the LR state to the struct vgic_irq.
>          *
> -        * In the opposite case, we know the VCPU thread may be on its
> -        * way back from the guest and still has to sync back this
> -        * IRQ, so we release and re-acquire the spin_lock to let the
> -        * other thread sync back the IRQ.
> +        * As long as the conditions below are true, we know the VCPU thread
> +        * may be on its way back from the guest (we kicked the VCPU thread in
> +        * vgic_change_active_prepare)  and still has to sync back this IRQ,
> +        * so we release and re-acquire the spin_lock to let the other thread
> +        * sync back the IRQ.
>          */
>         while (irq->vcpu && /* IRQ may have state in an LR somewhere */
> +              irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
>                irq->vcpu->cpu != -1) /* VCPU thread is running */
>                 cond_resched_lock(&irq->irq_lock);
>
> --
> 2.5.0
>
>
