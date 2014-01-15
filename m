From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 15 Jan 2014 13:16:05 +0800
Subject: [PATCH 1/3] mmc: dw_mmc: use slot-gpio to handle cd pin
In-Reply-To: <52D5DFB5.7@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>	<1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>	<CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
 <CAOesGMi5bK6siLQ2dVkR7P30+5zQa8qsyxa3UsWj0Kw9OEXCPw@mail.gmail.com>
 <52D5DFB5.7@linaro.org>
Message-ID: <52D61995.5090003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kevin

On 01/15/2014 09:09 AM, zhangfei wrote:
>
>
> On 01/15/2014 01:23 AM, Olof Johansson wrote:
>> On Tue, Jan 14, 2014 at 7:58 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>> On Thu, Jan 9, 2014 at 6:35 AM, Zhangfei Gao
>>> <zhangfei.gao@linaro.org> wrote:
>>>> Suggested by Jaehoon: Use slot-gpio to handle cd-gpio
>>>> Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
>>>> mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>
>>> The Samsung Arndale board started failing boot from MMC root tests
>>> starting with next-20140113 and I bisected it down to this patch.
>>> Reverting this patch on top of next-20140114 gets Arndale booting
>>> again from MMC.  Is there some supporting DT data that's missing for
>>> Arndale?
>>
>> Rather, it looks like this patch changes behaviour and no longer uses
>> dw_mci_get_cd() to find out if there's a card attached -- it switches
>> to rely only on GPIO (see the last chunk in the patch). That seems
>> broken?
>>
> Oops,
> Change using dw_mci_get_cd set flag DW_MMC_CARD_PRESENT.
> And dw_mci_get_cd is called from mmc_rescan, a litter later than
> dw_mci_probe.
> Is that too late?

Should have found the issue, CDETECT is ignored since IS_ERR_VALUE does 
not workable to !mmc_gpio_get_cd(mmc), which used for adding debounce.
Sorry for that.

However, with this change the debounce seems not stable as before.
In the test of plug-in-out, sometimes sd detect will return timeout 
although present indicates as 1, while next time it can be detected again.
Still want to check more.


diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..f1683ba194ee 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1033,7 +1033,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
         int present;
         struct dw_mci_slot *slot = mmc_priv(mmc);
         struct dw_mci_board *brd = slot->host->pdata;
-       int gpio_cd = !mmc_gpio_get_cd(mmc);
+       int gpio_cd = mmc_gpio_get_cd(mmc);

         /* Use platform get_cd function, else try onboard card detect */
         if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
@@ -1041,7 +1041,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
         else if (brd->get_cd)
                 present = !brd->get_cd(slot->id);
         else if (!IS_ERR_VALUE(gpio_cd))
-               present = !!gpio_cd;
+               present = !gpio_cd;
         else
                 present = (mci_readl(slot->host, CDETECT) & (1 << 
slot->id))
                         == 0 ? 1 : 0;
