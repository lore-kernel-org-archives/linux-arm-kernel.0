From: joe@perches.com (Joe Perches)
Date: Wed, 14 Aug 2013 16:29:58 -0700
Subject: [PATCH 02/10] crypto: omap-aes: Add useful debug macros
In-Reply-To: <1376521969-16807-3-git-send-email-joelf@ti.com>
References: <1376521969-16807-1-git-send-email-joelf@ti.com>
 <1376521969-16807-3-git-send-email-joelf@ti.com>
Message-ID: <1376522998.1949.118.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-14 at 18:12 -0500, Joel Fernandes wrote:
> When DEBUG is enabled, these macros can be used to print variables
> in integer and hex format, and clearly display which registers,
> offsets and values are being read/written , including printing the
> names of the offsets and their values.
[]
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
[]
> @@ -15,6 +15,14 @@
>  
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
> +#ifdef DEBUG
> +#define prn(num) printk(#num "=%d\n", num)
> +#define prx(num) printk(#num "=%x\n", num)

pr_debug?

> +#else
> +#define prn(num) do { } while (0)
> +#define prx(num)  do { } while (0)
> +#endif
[]
> @@ -172,13 +180,35 @@ struct omap_aes_dev {
>  static LIST_HEAD(dev_list);
>  static DEFINE_SPINLOCK(list_lock);
>  
> +#ifdef DEBUG
> +#define omap_aes_read(dd, offset)					\
> +	do {								\
> +		omap_aes_read_1(dd, offset);				\
> +		pr_debug("omap_aes_read(" #offset ")\n");		\
> +	} while (0)
> +
> +static inline u32 omap_aes_read_1(struct omap_aes_dev *dd, u32 offset)
> +#else
>  static inline u32 omap_aes_read(struct omap_aes_dev *dd, u32 offset)
> +#endif
>  {
>  	return __raw_readl(dd->io_base + offset);
>  }
>  
> +#ifdef DEBUG
> +#define omap_aes_write(dd, offset, value)				\
> +	do {								\
> +		pr_debug("omap_aes_write(" #offset "=%x) value=%d\n",	\
> +			 offset, value);				\
> +		omap_aes_write_1(dd, offset, value);			\
> +	} while (0)
> +
> +static inline void omap_aes_write_1(struct omap_aes_dev *dd, u32 offset,
> +				  u32 value)
> +#else
>  static inline void omap_aes_write(struct omap_aes_dev *dd, u32 offset,
>  				  u32 value)
> +#endif
>  {
>  	__raw_writel(value, dd->io_base + offset);
>  }

Umm, yuck?

Is there any real value in read_1 and write_1?
