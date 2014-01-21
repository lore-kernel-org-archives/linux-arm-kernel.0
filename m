From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 20 Jan 2014 17:19:04 -0800
Subject: [PATCH REPOST 4/5] ARM: kvm vgic mmio should return data in BE
 format in BE case
In-Reply-To: <1387558125-3460-5-git-send-email-victor.kamensky@linaro.org>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-5-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140121011904.GL13432@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 08:48:44AM -0800, Victor Kamensky wrote:
> KVM mmio in BE case assumes that data it recieves is in BE format. Vgic
> operates in LE, so need byteswap data in BE case.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  virt/kvm/arm/vgic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 685fc72..7e11458 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -236,12 +236,12 @@ static void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq)
>  
>  static u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
>  {
> -	return *((u32 *)mmio->data) & mask;
> +	return le32_to_cpu(*((u32 *)mmio->data)) & mask;
>  }
>  
>  static void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
>  {
> -	*((u32 *)mmio->data) = value & mask;
> +	*((u32 *)mmio->data) = cpu_to_le32(value) & mask;
>  }
>  
>  /**
> -- 
> 1.8.1.4
> 

The VGIC code is complicated enough without adding endianness logic in
its depths.  I would strongly prefer that the VGIC emulation is an
endianness-agnostic software model of a device.  In fact, a better fix
for this whole situation would probably be to let the vgic_handle_mmio()
function take a typed union (or a u64)  instead of the byte array and
deal with any endianness conversion outside of the vgic itself.

-Christoffer
