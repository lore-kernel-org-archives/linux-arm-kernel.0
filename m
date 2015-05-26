From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 26 May 2015 14:33:41 +0200
Subject: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <1432620991.647.6.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFo5788uRqAaXUZ-OiS1XF8NPmg4tn2ipZNJdx4dci+KMQ@mail.gmail.com>
 <1432284000.23435.38.camel@mhfsdcap03>
 <CAPDyKFpWCvJXL-W5P83ucBM2-b5cDFEtSLnN6J6WLyR_9CuvWw@mail.gmail.com>
 <1432620991.647.6.camel@mhfsdcap03>
Message-ID: <CAPDyKFrNQ6E4cU1_gK56ZNYgb=9EzHoJ=vXyraYoKNnRL=Umyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> >> > +{
>> >> > +       unsigned long tmo = jiffies + msecs_to_jiffies(20);
>> >> > +
>> >> > +       while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
>> >> > +                       && time_before(jiffies, tmo))
>> >> > +               continue;
>> >> > +
>> >> > +       if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
>> >> > +               dev_err(host->dev, "CMD bus busy detected\n");
>> >> > +               host->error |= REQ_CMD_BUSY;
>> >> > +               msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
>> >> > +               return false;
>> >> > +       }
>> >> > +
>> >> > +       if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
>> >> > +               /* R1B or with data, should check SDCBUSY */
>> >> > +               while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
>> >> > +                       cpu_relax();
>> >> > +       }
>> >>
>> >> MSDC seems to be handling card busy detection in HW, right?
>> >>
>> > Do not have this ability, HW only know if CMD/DAT is low, but do not
>> > have any interrupt for it,
>>
>> I see, but doesn't the above polling mean that msdc will not propagate
>> the response until the card have stopped signal busy? That's what
>> MMC_CAP_WAIT_WHILE_BUSY shall be used for.
>>
> As you see, we only check the "busy state" BEFORE issue a R1B command or
> with data command, but do not check if AFTER the request was done, that
> would do not match the "MMC_CAP_WAIT_WHILE_BUSY"(eg. CMD5 to sleep)

Okay, fair enough. Still, I don't understand why you want to do that?

> In addition, about CMD5, I find that the suspend/resume flow of EMMC is
> stranger in new kernel version, when suspend, it may issue CMD5 to enter
> sleep mode, then power off MMC, but when resume, it will
> re-initialization, So that why need do the redundant CMD5 in suspend ?

Both CMD0 and CMD5 are valid as wakeup commands.

To be able to use CMD5, the VCCQ regulator must be kept enabled in the
sleep state. That's when it becomes a bit tricky, due to the range of
different host drivers and SoCs for how VCCQ is managed.

To be safe we have chosen to use CMD0, since it works for *all* cases
no matter if VCCQ get gated or not.

Moreover, using CMD5 as the wakeup command would require added
complexity in the code dealing with suspend/resume. I don't think the
effort is worth it, at least until someone has proven that the resume
time is greatly decreased by using CMD5.

>
>> Perhaps you should remove the above polling, and rely on the MMC core
>> to poll with CMD13 instead?
> before any read/write command, core will issue CMD13 to confirm card
> status, here is just only do double confirm to avoid HW issue.

What HW issue and why do you need to double confirm? It seems strange.

Kind regards
Uffe
