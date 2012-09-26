From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Sep 2012 11:48:25 -0700
Subject: [PATCH 01/10] usb: otg: msm: Convert to clk_prepare/unprepare
In-Reply-To: <CADTbHxoFeYWPJpYTN85kBeF=kv2v1yDioJW-upzn1RcwVT_sKw@mail.gmail.com>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-2-git-send-email-sboyd@codeaurora.org>
 <CADTbHxoFeYWPJpYTN85kBeF=kv2v1yDioJW-upzn1RcwVT_sKw@mail.gmail.com>
Message-ID: <50634DF9.5010608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/12 09:58, Pankaj Jangra wrote:
> On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> diff --git a/drivers/usb/otg/msm_otg.c b/drivers/usb/otg/msm_otg.c
>> index 9f5fc90..2ae0639 100644
>> --- a/drivers/usb/otg/msm_otg.c
>> +++ b/drivers/usb/otg/msm_otg.c
>> @@ -514,13 +514,13 @@ static int msm_otg_suspend(struct msm_otg *motg)
>>                         motg->pdata->otg_control == OTG_PMIC_CONTROL)
>>                 writel(readl(USB_PHY_CTRL) | PHY_RETEN, USB_PHY_CTRL);
>>
>> -       clk_disable(motg->pclk);
>> -       clk_disable(motg->clk);
>> +       clk_disable_unprepare(motg->pclk);
>> +       clk_disable_unprepare(motg->clk);
>>         if (motg->core_clk)
>> -               clk_disable(motg->core_clk);
>> +               clk_disable_unprepare(motg->core_clk);
>>
> I was under assumption that system suspend/resume might be called from
> the interrupt context. If that is case then its not appropriate to
> call clk_prepare/unprepare here right? or my understanding is not correct????

Well we call disable_irq() at the top of this suspend function so I
suspect your understanding is incorrect. disable_irq() can call
schedule(). There are also a bunch of regulator calls in
msm_hsusb_ldo_set_mode() that this suspend function calls (almost all
regulator calls grab a mutex).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
