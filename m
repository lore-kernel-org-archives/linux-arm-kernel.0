From: bp@alien8.de (Borislav Petkov)
Date: Wed, 5 Sep 2018 12:19:35 +0200
Subject: [PATCH v5 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
In-Reply-To: <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180905101935.GD2237@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 06:57:49PM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. Also add support for ECC Error
> Injection in ZynqMP. The corrected and uncorrected error interrupts
> support is added. The Row, Column, Bank, Bank Group and Rank bits
> positions are determined via Address Map registers of Synopsys DDRC.
> Minor indentation changes are also done for better readability.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |    2 +-
>  drivers/edac/synopsys_edac.c | 1054 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 937 insertions(+), 119 deletions(-)

...

> @@ -222,11 +408,77 @@ static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  }
>  
>  /**
> + * zynqmp_geterror_info - Get the current ECC error info
> + * @priv:	DDR memory controller private instance data
> + *
> + * Get the ECC error information from the ECC registers and clear the error
> + * status bits in the ECC registers.
> + *
> + * Return: 0 if there is no error, otherwise return 1
> + */
> +static int zynqmp_geterror_info(struct synps_edac_priv *priv)
> +{
> +	void __iomem *base;
> +	struct synps_ecc_status *p;
> +	u32 regval, clearval = 0;
> +
> +	if (!priv)
> +		return 1;

Same as for the previous patch: why are you testing this since you're
dereferencing it before calling this function?

...

> @@ -258,10 +536,46 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  }
>  
>  /**
> + * synps_edac_intr_handler - Interrupt Handler for ECC interrupts
> + * @irq:        irq number
> + * @dev_id:     device id pointer
> + *
> + * This is the ISR called by EDAC core interrupt thread.

There's an "EDAC core interrupt thread"?!? This is the first time I hear
of it.

Try again.

> + * This is used to check and post ECC errors.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
> + */
> +static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
> +	int status, regval;
> +
> +	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
> +	if (!(regval & ECC_CE_UE_INTR_MASK))
> +		return IRQ_NONE;
> +
> +	status = p_data->geterror_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	synps_edac_handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count ce %d ue %d\n",

"ce" and "ue" are also abbreviations and should be in caps.

...

> +static DEVICE_ATTR_RW(inject_data_error);
> +static DEVICE_ATTR_RW(inject_data_poison);
> +
> +static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +	int rc;
> +
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
> +	if (rc < 0)
> +		return rc;
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
> +}

I think I'm having a deja-vu:

Last time I said:

"More importantly, you need to put all that injection functionality
behind CONFIG_EDAC_DEBUG - you don't want to expose the injection
capabilities on a production machine."

and you said:

"I agree. I will update the same by keeping the above mentioned macro."

But maybe you've misunderstood me.

Grep the other EDAC drivers to find out how to hide the injection
functionality behind CONFIG_EDAC_DEBUG.

And maybe this patch is becoming huuge and too unwieldy to review
properly and for you to incorporate all the feedback.

Therefore, please split it in single patches, each of which is doing
different things:

1. fixup/change comments
2. add defines
3. add functionality X
4. add functionality Y
...
5. add injection
6. tie it all together

Apply some common sense and put yourself in the reviewer's shoes when
doing so.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
