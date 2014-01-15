From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Wed, 15 Jan 2014 23:38:06 +0900
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <52D6938A.9050806@linaro.org>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <1389780469-32633-1-git-send-email-zhangfei.gao@linaro.org>
 <001701cf11e9$25b5fe50$7121faf0$%jun@samsung.com>
 <52D67A9B.4090607@linaro.org>
 <001c01cf11ed$039b6270$0ad22750$%jun@samsung.com>
 <52D6938A.9050806@linaro.org>
Message-ID: <002c01cf11ff$6790a8a0$36b1f9e0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, January 15, 2014, Zhangfei wrote:
> On 01/15/2014 08:26 PM, Seungwon Jeon wrote:
> 
> >>>> @@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
> >>>>    	int present;
> >>>>    	struct dw_mci_slot *slot = mmc_priv(mmc);
> >>>>    	struct dw_mci_board *brd = slot->host->pdata;
> >>>> -	int gpio_cd = !mmc_gpio_get_cd(mmc);
> >>>> +	struct dw_mci *host = slot->host;
> >>>> +	int gpio_cd = mmc_gpio_get_cd(mmc);
> >>>>
> >>>>    	/* Use platform get_cd function, else try onboard card detect */
> >>>>    	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> >>>> @@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
> >>>>    	else if (brd->get_cd)
> >>>>    		present = !brd->get_cd(slot->id);
> >>>>    	else if (!IS_ERR_VALUE(gpio_cd))
> >>>> -		present = !!gpio_cd;
> >>>> +		present = !gpio_cd;
> >>> !!gpio_cd or gpio_cd is correct, isn't it?
> >>>
> >>
> >> No, mmc_gpio_get_cd(mmc) has to revert.
> > I'm missing something?
> > If card is detected, mmc_gpio_get_cd() returns non-zero, right?
> > I guess gpio_cd should be kept.
> >
> 
> Hmm, looks you are right.
> Though not see clearly mmc_gpio_get_cd declaratoin, other drivers
> directly set get_cd as mmc_gpio_get_cd.
> .get_cd	= mmc_gpio_get_cd
> 
> However, in our board cd =0 when card is deteced while cd=1 when card is
> removed.
> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> set, as well as new property "caps2-mmc-cd-active-low".

Ok, you could do more.
mmc_gpio_get_cd() is expected to return non-zero if card is detection.

> 
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -73,6 +73,8 @@ Optional properties:
> +* caps2-mmc-cd-active-low: cd pin is low when card active
> +
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
> +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> +
> 
> But it looks strange "cd-active-low" describing "CD_ACTIVE_HIGH" flag.
> When card active, cd = 0, and ACTIVE_HIGH is required to make
> mmc_gpio_get_cd return 1.

I think your board seems not to use pull-up on GPIO line for card detection.
So, MMC_CAP2_CD_ACTIVE_HIGH would be needed.

Thanks,
Seungwon Jeon

> int mmc_gpio_get_cd(struct mmc_host *host)
> {
>         return !gpio_get_value_cansleep(ctx->cd_gpio) ^
>                 !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> }
> 
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
