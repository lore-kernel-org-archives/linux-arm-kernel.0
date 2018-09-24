From: bp@alien8.de (Borislav Petkov)
Date: Mon, 24 Sep 2018 11:53:14 +0200
Subject: [PATCH v7 7/7] edac: synopsys: Add Error Injection support for
 ZynqMP DDRC
In-Reply-To: <1537194305-9243-8-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-8-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180924095314.GB20187@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:55:05PM +0530, Manish Narani wrote:
> Add support for Error Injection for ZynqMP DDRC IP. For injecting
> errors, the Row, Column, Bank, Bank Group and Rank bits positions are
> determined via Address Map registers of Synopsys DDRC.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 423 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 417 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7ab5b9a..177b5c3 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -302,12 +302,18 @@ struct synps_ecc_status {
>  
>  /**
>   * struct synps_edac_priv - DDR memory controller private instance data.
> - * @baseaddr:	Base address of the DDR controller.
> - * @message:	Buffer for framing the event specific info.
> - * @stat:	ECC status information.
> - * @p_data:	Platform data
> - * @ce_cnt:	Correctable Error count.
> - * @ue_cnt:	Uncorrectable Error count.
> + * @baseaddr:		Base address of the DDR controller.
> + * @message:		Buffer for framing the event specific info.
> + * @stat:		ECC status information.
> + * @p_data:		Platform data
> + * @ce_cnt:		Correctable Error count.
> + * @ue_cnt:		Uncorrectable Error count.
> + * @poison_addr:	Data poison address.
> + * @row_shift:		Bit shifts for row bit.
> + * @col_shift:		Bit shifts for column bit.
> + * @bank_shift:		Bit shifts for bank bit.
> + * @bankgrp_shift:	Bit shifts for bank group bit.
> + * @rank_shift:		Bit shifts for rank bit.
>   */
>  struct synps_edac_priv {
>  	void __iomem *baseaddr;
> @@ -316,6 +322,14 @@ struct synps_edac_priv {
>  	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
> +#ifdef CONFIG_EDAC_DEBUG
> +	ulong poison_addr;
> +	u32 row_shift[18];
> +	u32 col_shift[14];
> +	u32 bank_shift[3];
> +	u32 bankgrp_shift[2];
> +	u32 rank_shift[1];
> +#endif
>  };
>  
>  /**
> @@ -842,7 +856,12 @@ static const struct synps_platform_data zynqmp_edac_def = {
>  	.get_mtype	= zynqmp_get_mtype,
>  	.get_dtype	= zynqmp_get_dtype,
>  	.get_eccstate	= zynqmp_get_eccstate,
> +#ifdef CONFIG_EDAC_DEBUG
> +	.quirks		= (DDR_ECC_INTR_SUPPORT |
> +			   DDR_ECC_DATA_POISON_SUPPORT),
> +#else
>  	.quirks		= DDR_ECC_INTR_SUPPORT,
> +#endif
>  };

Simplify that:

        .quirks         = (DDR_ECC_INTR_SUPPORT
#ifdef CONFIG_EDAC_DEBUG
                          | DDR_ECC_DATA_POISON_SUPPORT
#endif
                        ),

> +/**
> + * setup_address_map -	Set Address Map by querying ADDRMAP registers.
> + * @priv:		DDR memory controller private instance data.
> + *
> + * Set Address Map by querying ADDRMAP registers.
> + *
> + * Return: none.
> + */
> +static void setup_address_map(struct synps_edac_priv *priv)
> +{
> +	u32 addrmap[12];
> +	int index;
> +
> +	for (index = 0; index < 12; index++) {
> +		u32 addrmap_offset;
> +
> +		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
> +		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
> +	}
> +
> +	/* Set Row Address Map */
> +	setup_row_address_map(priv, addrmap);
> +
> +	/* Set Column Address Map */
> +	setup_column_address_map(priv, addrmap);
> +
> +	/* Set Bank Address Map */
> +	setup_bank_address_map(priv, addrmap);
> +
> +	/* Set Bank Group Address Map */
> +	setup_bg_address_map(priv, addrmap);
> +
> +	/* Set Rank Address Map */
> +	setup_rank_address_map(priv, addrmap);

All those comments which basically repeat the function name look useless
to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
