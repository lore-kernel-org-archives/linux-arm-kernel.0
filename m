From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:43:36 -0700
Subject: [PATCH 5/5] ARM64: KVM: fix vgic_bitmap_get_reg function for BE
 64bit case
In-Reply-To: <1392184643-6108-6-git-send-email-victor.kamensky@linaro.org>
References: <1392184643-6108-1-git-send-email-victor.kamensky@linaro.org>
 <1392184643-6108-6-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320034336.GU1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:57:23PM -0800, Victor Kamensky wrote:
> Fix vgic_bitmap_get_reg function to return 'right' word address of
> 'unsigned long' bitmap value in case of BE 64bit image.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  virt/kvm/arm/vgic.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 7e11458..e56c5f8 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -96,14 +96,37 @@ static u32 vgic_nr_lr;
>  
>  static unsigned int vgic_maint_irq;
>  
> +/*
> + * struct vgic_bitmap is union that provides two view of

contains untions that provide two views

> + * the same data. In one case it is array of registers of

an array

> + * u32 type (.reg). And in another it is bitmap, which is

, and in the other case it is a bitmap, which is an array...

> + * array of 'unsgined long' (.reg_ul). It works all well in

It all works well on 32-bit

> + * case of 32bit (u32 and 'unsigned long' have the same size).
> + * It works ok in 64bit LE case, where 'unsigned long'

It also works well on 64-bit LE, but breaks on 64-bit BE.

> + * size is 8 bytes, while u32 is 4 bytes, and least siginificant
> + * word of 'unsigned long' matches lower index of .reg array.

Drop these two lines.

> + * It breaks in 64bit BE case. In this case word sized
> + * register of even index actually resides in least significant
> + * word of 'unsigned long' which has address at offset plus 4
> + * bytes. And word sized register of odd index resides at most
> + * significant of 'unsigned long' which has offset minus 4
> + * bytes. Define REG_OFFSET_SWIZZLE that would help to
> + * change offset of register in case of BE 64bit system.
> + */
> +#if defined(CONFIG_CPU_BIG_ENDIAN) && BITS_PER_LONG == 64
> +#define REG_OFFSET_SWIZZLE	1
> +#else
> +#define REG_OFFSET_SWIZZLE	0
> +#endif
> +

Wondering if it's worth the trouble in this case of having the union;
the union is there only for this function to be simpler, but if it
doesn't work for BE, then maybe it's not worth it?

>  static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
>  				int cpuid, u32 offset)
>  {
>  	offset >>= 2;
>  	if (!offset)
> -		return x->percpu[cpuid].reg;
> +		return x->percpu[cpuid].reg + (offset^REG_OFFSET_SWIZZLE);

you need spaces around the '^' according to CodingStyle.

>  	else
> -		return x->shared.reg + offset - 1;
> +		return x->shared.reg + ((offset - 1)^REG_OFFSET_SWIZZLE);

ditto

>  }
>  
>  static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
> -- 
> 1.8.1.4
> 

Functionally, this looks correct to me.

-Christoffer
