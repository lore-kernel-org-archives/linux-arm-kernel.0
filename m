From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 19 Apr 2016 13:34:48 +0100
Subject: [PATCH 26/45] KVM: arm/arm64: vgic-new: Add GICv3 IDREGS register
 handler
In-Reply-To: <1460740316-8755-27-git-send-email-andre.przywara@arm.com>
References: <1460740316-8755-1-git-send-email-andre.przywara@arm.com>
 <1460740316-8755-27-git-send-email-andre.przywara@arm.com>
Message-ID: <CAFEAcA9Hy2cSVguOWrxBo6By24BjiE2rgoCPGbfo+OuuPMtSQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2016 at 18:11, Andre Przywara <andre.przywara@arm.com> wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic_mmio.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
> index 7d275a7..dafa235 100644
> --- a/virt/kvm/arm/vgic/vgic_mmio.c
> +++ b/virt/kvm/arm/vgic/vgic_mmio.c
> @@ -784,6 +784,23 @@ static int vgic_mmio_read_v3r_iidr(struct kvm_vcpu *vcpu,
>         return 0;
>  }
>
> +static int vgic_mmio_read_v3_idregs(struct kvm_vcpu *vcpu,
> +                                   struct kvm_io_device *dev,
> +                                   gpa_t addr, int len, void *val)
> +{
> +       u32 regnr = (addr & 0x3f) - (GICD_IDREGS & 0x3f);
> +       u32 reg = 0;
> +
> +       switch (regnr + GICD_IDREGS) {
> +       case GICD_PIDR2:
> +               /* report a GICv3 compliant implementation */
> +               reg = 0x3b;
> +               break;
> +       }

We claim to be an ARM implementation, so we should report the full
set of ARM ID registers, not just GICD_PIDR2:

        0x44, 0x00, 0x00, 0x00, 0x92, 0xB4, 0x3B, 0x00, 0x0D, 0xF0, 0x05, 0xB1

(starting at 0xFFD0 and going up to 0xFFFC.)

> +       write_mask32(reg , addr & 3, len, val);
> +       return 0;
> +}
>  #endif

thanks
-- PMM
