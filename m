From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 18 Jun 2014 16:47:44 +0200
Subject: [RFC PATCH 6/6] arm/arm64: KVM: vgic: Clarify and correct vgic
 documentation
In-Reply-To: <1402779067-34478-7-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-7-git-send-email-christoffer.dall@linaro.org>
Message-ID: <53A1A690.8030909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2014 10:51 PM, Christoffer Dall wrote:
> The VGIC virtual distributor implementation documentation was written a
> very long time ago, before the true nature of the beast had been
> partially absorbed into my bloodstream.  I think this amalgamates the
> two evil beings (myself and the code) a little more.
> 
> Plus, it fixes an actual bug.  ICFRn, pfff.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/arm/vgic.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 1f91b3b..cc776af 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -36,21 +36,22 @@
>   * How the whole thing works (courtesy of Christoffer Dall):
>   *
>   * - At any time, the dist->irq_pending_on_cpu is the oracle that knows if
> - *   something is pending
> - * - VGIC pending interrupts are stored on the vgic.irq_pending vgic
> - *   bitmap (this bitmap is updated by both user land ioctls and guest
> - *   mmio ops, and other in-kernel peripherals such as the
> - *   arch. timers) and indicate the 'wire' state.
> + *   something is pending on the CPU interface.
> + * - Interrupts that are pending on the distributor are stored on the
> + *   vgic.irq_pending vgic bitmap (this bitmap is updated by both user land
> + *   ioctls and guest mmio ops, and other in-kernel peripherals such as the
> + *   arch. timers).
ok forget my previous comment related to wire state;-)
>   * - Every time the bitmap changes, the irq_pending_on_cpu oracle is
>   *   recalculated
>   * - To calculate the oracle, we need info for each cpu from
>   *   compute_pending_for_cpu, which considers:
>   *   - PPI: dist->irq_pending & dist->irq_enable
>   *   - SPI: dist->irq_pending & dist->irq_enable & dist->irq_spi_target
> - *   - irq_spi_target is a 'formatted' version of the GICD_ICFGR
> + *   - irq_spi_target is a 'formatted' version of the GICD_ITARGETSRn
>   *     registers, stored on each vcpu. We only keep one bit of
>   *     information per interrupt, making sure that only one vcpu can
>   *     accept the interrupt.
> + * - If any of the above state changes, we must recalculate the oracle.
>   * - The same is true when injecting an interrupt, except that we only
>   *   consider a single interrupt at a time. The irq_spi_cpu array
>   *   contains the target CPU for each SPI.
> 
