From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Mon, 13 Jan 2014 11:09:24 +0900
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <52CFFFDA.8050108@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
 <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com>
 <52CFFFDA.8050108@linaro.org>
Message-ID: <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, January 10, 2014, Zhangfei Gao wrote:
> On 01/10/2014 09:39 PM, Seungwon Jeon wrote:
> >> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >> +{
> >> +	struct dw_mci_k3_priv_data *priv = host->priv;
> >> +	u32 rate = priv->clk_table[ios->timing];
> >
> > First, sorry for quick review even though your effort.
> > But I still worry about this change.
> > Currently k3 host's clock table depends on value number of SD/MMC mode value.
> > It seems close to identifier for eachg mode. I think it's not good way to use as table's index.
> > Can you modify to mmc_clk_determine_rate() in your another patch-set?
> > I guess required actual target rate could be determined depending on ios->clock.
> >
> 
> No, it can not get input clock source rate simply from ios->clock, also
> requied info like which controller, which mode etc.
> Here is setting clock source rate, not the working clock rate.
> 
> For example, emmc init clock source rate is 13M, while sd init clock
> source is 25M, it can not simply get such info from ios->clock.
> And for HS200, emmc may have to set clock source rate to 104M since the
> controller limitation and can not work stable as 208M.

Yes, clock table is source clock rate, not actual working clock rate.
I was not saying that 'ios->clock' would be used for source clock directly.
I meant that you can adjust the source clock rate depending on 'ios->clock'.
You've already done with clock table similarly in mmc_clk_determine_rate().

For example, in case of HS200, 'ios->clock' will be passed with 200MHz.
And then, mmc_clk_determine_rate() can set the 'rate & best' to 100000000 and 720000000 respectively.
Also, 'ios->clock' with 400KHz or less may be passed for init clock.
If clock id is HI3620_SD_CIUCLK, 'rate & best' can be selected with 13000000 and 26000000.
If not and it's case of MMC,  'rate & best' can be selected with 25000000 and 180000000.
If it should be considered with other conditions, please let me know.

Thanks,
Seungwon Jeon
