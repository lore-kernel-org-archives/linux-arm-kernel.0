From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 23 Oct 2012 10:17:58 +0000
Subject: [PATCH 2/4] mtd: devices: elm: Add support for ELM error
 correction
In-Reply-To: <87hapvv800.fsf@macbook.be.48ers.dk>
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
 <1349274589-11389-3-git-send-email-avinashphilip@ti.com>
 <87hapvv800.fsf@macbook.be.48ers.dk>
Message-ID: <518397C60809E147AF5323E0420B992E3E9D29C3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 01:10:47, Peter Korsgaard wrote:
> >>>>> Philip, Avinash <avinashphilip@ti.com> writes:
> 
>  > Platforms containing the ELM module can be used to correct errors
>  > reported by BCH 4, 8 & 16 bit ECC scheme. For now only 4 & 8 bit
>  > support is added.
> 
> This sounds odd to me. What about something like:
> 
> The ELM hardware module can be used to speedup BCH 4/8/16 ECC scheme
> error correction.
> 
> For now only 4 & 8 bit support is added.

Ok I will correct it.

> 
> 
>  > +++ b/drivers/mtd/devices/Makefile
>  > @@ -17,8 +17,10 @@ obj-$(CONFIG_MTD_LART)		+= lart.o
>  >  obj-$(CONFIG_MTD_BLOCK2MTD)	+= block2mtd.o
>  >  obj-$(CONFIG_MTD_DATAFLASH)	+= mtd_dataflash.o
>  >  obj-$(CONFIG_MTD_M25P80)	+= m25p80.o
>  > +obj-$(CONFIG_MTD_NAND_OMAP2)	+= elm.o
> 
> You seem to only use it in 4/4 if CONFIG_MTD_NAND_OMAP_BCH is set, so it
> probably makes more sense to use that symbol to not needlessly include
> it if it won't be used.

Ok. This been good.

> 
> 
>  > +static void elm_write_reg(void *offset, u32 val)
>  > +{
>  > +	writel(val, offset);
>  > +}
>  > +
>  > +static u32 elm_read_reg(void *offset)
>  > +{
>  > +	return readl(offset);
>  > +}
> 
> As written these read/write wrappers don't add anything. How about
> passing struct elm_info and offset as an integer so you can drop
> elm_base from all call sites, E.G.:
> 
> static void elm_write_reg(struct elm_info *info, int offset, u32 val)
> {
>         writel(val, info->elm_base + offset);
> }
>

Ok, this helps to reduce some indentation levels also.
 
> 
>  > +void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>  > +		struct elm_errorvec *err_vec)
>  > +{
>  > +	int i;
>  > +	u8 syndrome[BCH_MAX_ECC_BYTES_PER_SECTOR] = {0}, *syn_p;
> 
> 
> Why do you need to keep the entire syndrome around? You seem to only use
> it between elm_reverse_eccdata() and elm_load_syndrome(), so it could as
> well be BCH8_ECC_OOB_BYTES long (or rather a multiple of sizeof(u32).
> 
> It would also be good to do the shuffeling directly in elm_load_syndrome
> so you don't need the extra copy.

I will check.

> 
> 
>  > + */
>  > +
>  > +#ifndef __ELM_H
>  > +#define __ELM_H
>  > +
>  > +enum bch_ecc {
>  > +	BCH4_ECC = 0,
>  > +	BCH8_ECC,
>  > +	BCH16_ECC,
> 
> It probably makes more sense to not provide the enum value for BCH16 as
> you don't support it.
> 

Ok I will remove.

> 
>  > +};
>  > +

Thanks
Avinash
