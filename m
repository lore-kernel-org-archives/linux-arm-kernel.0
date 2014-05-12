From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 12 May 2014 13:20:56 +0200
Subject: [PATCH v12 1/6] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <CAPDyKFrYeBdB20qhmkcUf5ykw=SbBo6VUPXd=By9dNOvTnvFww@mail.gmail.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>	<1399794417-9291-2-git-send-email-hdegoede@redhat.com>
 <CAPDyKFrYeBdB20qhmkcUf5ykw=SbBo6VUPXd=By9dNOvTnvFww@mail.gmail.com>
Message-ID: <5370AE98.9050808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/12/2014 11:15 AM, Ulf Hansson wrote:
> On 11 May 2014 09:46, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
>>
>> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
>> designware idmac controller, which is identical to the one found in the mmc-dw
>> hosts. However the rest of the host is not identical to mmc-dw, it deals with
>> sending stop commands in hardware which makes it significantly different
>> from the mmc-dw devices.
>>
>> HdG: Various cleanups and fixes.
>>
>> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> [snip]
> 
>> +
>> +static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>> +                                 struct mmc_ios *ios)
>> +{
>> +       u32 rate, oclk_dly, rval, sclk_dly, src_clk;
>> +       struct clk_hw *hw = __clk_get_hw(host->clk_mmc);
> 
> Hi Hans,
> 
> This seems like the wrong approach. But I guess it's related to the
> "clock phase control" API you have been discussing with the clk
> maintainer, Mike Turquette!?

Yes, this is meant as a temporary solution until we get a proper
"clock phase control" API.

> 
> __clk_get_hw is supposed to be used by clk providers, not clk consumers.
> 
>> +       int ret;
>> +
>> +       rate = clk_round_rate(host->clk_mmc, ios->clock);
>> +       dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
>> +               ios->clock, rate);
>> +
>> +       /* setting clock rate */
>> +       ret = clk_set_rate(host->clk_mmc, rate);
>> +       if (ret) {
>> +               dev_err(mmc_dev(host->mmc), "error setting clk to %d: %d\n",
>> +                       rate, ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = sunxi_mmc_oclk_onoff(host, 0);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* clear internal divider */
>> +       rval = mmc_readl(host, REG_CLKCR);
>> +       rval &= ~0xff;
>> +       mmc_writel(host, REG_CLKCR, rval);
>> +
>> +       /* determine delays */
>> +       if (rate <= 400000) {
>> +               oclk_dly = 0;
>> +               sclk_dly = 7;
>> +       } else if (rate <= 25000000) {
>> +               oclk_dly = 0;
>> +               sclk_dly = 5;
>> +       } else if (rate <= 50000000) {
>> +               if (ios->timing == MMC_TIMING_UHS_DDR50) {
>> +                       oclk_dly = 2;
>> +                       sclk_dly = 4;
>> +               } else {
>> +                       oclk_dly = 3;
>> +                       sclk_dly = 5;
>> +               }
>> +       } else {
>> +               /* rate > 50000000 */
>> +               oclk_dly = 2;
>> +               sclk_dly = 4;
>> +       }
>> +
>> +       src_clk = clk_get_rate(clk_get_parent(host->clk_mmc));
>> +       if (src_clk >= 300000000 && src_clk <= 400000000) {
>> +               if (oclk_dly)
>> +                       oclk_dly--;
>> +               if (sclk_dly)
>> +                       sclk_dly--;
>> +       }
>> +
>> +       clk_sunxi_mmc_phase_control(hw, sclk_dly, oclk_dly);
>> +
>> +       return sunxi_mmc_oclk_onoff(host, 1);
>> +}
>> +
> 
> [snip]
> 
> Besides the above, I think this looks good!

Thanks!

Since Mike Turquette has already merged clk_sunxi_mmc_phase_control
I would like to keep this as is, as I already promised Mike, I can
safely promise you too: I promise clean this up as soon as the
"clock phase control" API has been worked out.

Regards,

Hans
