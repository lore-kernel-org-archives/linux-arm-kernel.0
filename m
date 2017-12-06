From: P.Bruenn@beckhoff.com (=?iso-8859-1?Q?Patrick_Br=FCnn?=)
Date: Wed, 6 Dec 2017 10:17:06 +0000
Subject: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
 <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531D9C@NT-Mail07.beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
>Sent: Mittwoch, 6. Dezember 2017 09:36
>On Tue, Dec 05, 2017 at 03:06:46PM +0100, linux-kernel-dev at beckhoff.com
>wrote:
>> +static int mxc_rtc_write_alarm_locked(struct mxc_rtc_data *const pdata,
>> +                                  struct rtc_time *alarm_tm)
>> +{
>> +    void __iomem *const ioaddr = pdata->ioaddr;
>> +    unsigned long time;
>> +
>> +    rtc_tm_to_time(alarm_tm, &time);
>> +
>> +    if (time > U32_MAX) {
>> +            pr_err("Hopefully I am out of service by then :-(\n");
>> +            return -EINVAL;
>> +    }
>
>This will never happen as on your target hardware unsigned long is a
>32bit type. Not sure what is best to do here. Maybe you should test
>the return value of rtc_tm_to_time. ATM it returns 0 unconditionally,
>but rtc_tm_to_time could detect when the input time doesn't fit into
>its return type and return an error in this case.
>Also I just realized that it's unsigned and only overflows in the year
>2106. I'm most likely dead then so I don't care that much ;)
>
please see my response to Alexandre's follow up

>> +/* This function is the RTC interrupt service routine. */
>> +static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
>> +{
>> +    struct platform_device *pdev = dev_id;
>> +    struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
>> +    void __iomem *ioaddr = pdata->ioaddr;
>> +    unsigned long flags;
>> +    u32 events = 0;
>> +    u32 lp_status;
>> +    u32 lp_cr;
>> +
>> +    spin_lock_irqsave(&pdata->lock, flags);
>> +    if (clk_prepare_enable(pdata->clk)) {
>> +            spin_unlock_irqrestore(&pdata->lock, flags);
>> +            return IRQ_NONE;
>> +    }
>
>You are not allowed to do a clk_prepare under a spinlock. That was the
>original reason to split enabling a clk into clk_prepare and clk_enable.
>Everything that can block is done in clk_prepare and only non blocking
>things are done in clk_enable.
>If you want to enable/disable the clock on demand you can clk_prepare()
>in probe and clk_enable when you actually need it.
>
Thanks for clarification. To be honest when I read Lothar's suggestion it was
the first time I thought about the idea of keeping the clk disabled most of
the time. I am not very experienced with this. But a rtctest loop run for
hours so I assume it would be okay to keep the clk disabled until hw access.
If there is no objection from somebody who knows the i.MX53 SRTC HW
better, I will stick to the clock on demand model and make sure I avoid
blocking.
>> +
>> +static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +    struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
>> +    time_t now;
>> +    int ret = mxc_rtc_lock(pdata);
>> +
>> +    if (ret)
>> +            return ret;
>> +
>> +    now = readl(pdata->ioaddr + SRTC_LPSCMR);
>> +    rtc_time_to_tm(now, tm);
>> +    ret = rtc_valid_tm(tm);
>> +    mxc_rtc_unlock(pdata);
>
>I don't think this needs to be locked.
I will change this to only enable the clock for the readl()

>> +static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +    struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
>> +    int ret = mxc_rtc_lock(pdata);
>> +
>> +    if (ret)
>> +            return ret;
>> +
>> +    ret = mxc_rtc_write_alarm_locked(pdata, &alrm->time);
>
>Is it worth it to make this a separate function?
Maybe not, I think it is an artifact from a refactoring. I will reconsider this
for the next version.
>
>> +    if (!ret) {
>> +            mxc_rtc_alarm_irq_enable_locked(pdata, alrm->enabled);
>> +            mxc_rtc_sync_lp_locked(pdata->ioaddr);
>> +    }
>> +    mxc_rtc_unlock(pdata);
>> +    return ret;
>> +}
>> +
>> +static const struct rtc_class_ops mxc_rtc_ops = {
>> +    .read_time = mxc_rtc_read_time,
>> +    .set_time = mxc_rtc_set_time,
>> +    .read_alarm = mxc_rtc_read_alarm,
>> +    .set_alarm = mxc_rtc_set_alarm,
>> +    .alarm_irq_enable = mxc_rtc_alarm_irq_enable,
>> +};
>> +
>> +static int mxc_rtc_wait_for_flag(void *__iomem ioaddr, int flag)
>> +{
>> +    unsigned int timeout = REG_READ_TIMEOUT;
>> +
>> +    while (!(readl(ioaddr) & flag)) {
>> +            if (!--timeout) {
>> +                    pr_err("Wait timeout for 0x%x@%p!\n", flag, ioaddr);
>
>Please use dev_* functions for printing. In this case the message should
>probably be printed from the caller.
Do you have a link at hand about dev_* vs. pr_*? I just choose pr_err here,
because I would have to change the functions signature to get a device.
However, I will drop the message and move it to the caller.

>> +    /* clear lp interrupt status */
>> +    writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
>> +
>> +    /* move out of init state */
>> +    writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
>> +    xc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_IES);
>
>If this can fail, shouldn't you test for an error?
very probably
>> +
>> +    /* move out of non-valid state */
>> +    writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
>> +            SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
>> +    mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_NVES);
>
>dito
sure

Thanks,
Patrick
---
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
