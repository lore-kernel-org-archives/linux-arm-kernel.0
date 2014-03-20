From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 18:12:19 -0700
Subject: [PATCH v2 6/7] ARM: KVM: vgic mmio should hold data as LE bytes
 array in BE case
In-Reply-To: <1392183693-21238-7-git-send-email-victor.kamensky@linaro.org>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-7-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320011219.GL1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:41:32PM -0800, Victor Kamensky wrote:
> According to recent clarifications of mmio.data array meaning -
> the mmio.data array should hold bytes as they would appear in
> memory. Vgic is little endian device. And in case of BE image
> kernel side that emulates vgic, holds data in BE form. So we
> need to byteswap cpu<->le32 vgic registers when we read/write them
> from mmio.data[].
> 
> Change has no effect in LE case because cpu already runs in le32.
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

I hate the fact that we have endianness handling code inside the vgic
emulation, I would strongly prefer that the interface to the vgic code
is a typed union, but, that being said, I haven't looked at how the
changes to the code would look to accomplish that.  You didn't reply to
my same comment last time around, but did you ahve a look?

The code here, with the ABI specification does look correct, so assuming
that ABI specification gets merged:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
