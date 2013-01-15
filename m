From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Jan 2013 14:45:47 +0530
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
Message-ID: <50F51E43.2090605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/12/2013 7:56 AM, Tivy, Robert wrote:

>> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
>> Sent: Friday, January 11, 2013 4:26 AM

>> On Fri, Jan 11, 2013 at 2:23 AM, Robert Tivy <rtivy@ti.com> wrote:
>>> +static int davinci_rproc_probe(struct platform_device *pdev)
>>> +{
>>> +       struct da8xx_rproc_pdata *pdata = pdev->dev.platform_data;
>>> +       struct davinci_rproc *drproc;
>>> +       struct rproc *rproc;
>>> +       struct clk *dsp_clk;
>>> +       int ret;
>>> +
>>> +       if (!fw_name) {
>>> +               dev_err(&pdev->dev, "No firmware file specified\n");
>>> +
>>> +               return -EINVAL;
>>> +       }

>> There are a few issues with this fw_name module param:
>>
>> 1. Usually we don't rely on users providing the firmware file name for
>> drivers to work. Drivers should know the name beforehand, and if there
>> may be several different instances of firmwares (for different cores
>> you may have), then it's just better to get it from the platform data.
> 
> Is this suggesting that there be separate platform device instances for each different potential fw, and that each platform device instance hardcodes the fw filename?

I am not convinced firmware name should be in platform data (or DT)
since it is not hardware specific. User can choose multiple different
firmwares to load on the DSP depending the application he is running all
for the same platform (da850 evm).

> 
>>
>> 2. You may still want to have such a module param in order to be able
>> to override the default firmware name (for debugging purposes?), but
>> I'm not sure it should be davinci-specific. if we do want it to be
>> then please prefix the name with 'davinci'.
> 
> Sekhar asked that there not be a default fw name, so there's conflicting feedback on this point.  I prefer to have a default name plus the module parameter override (but don't have much opinion on whether it should be davinci-specific (and passed with davinci_remoteproc.ko) or general (and passed with remoteproc.ko), please advise).

Rob, I don't remember objecting to a default firmware name if module
parameter is not passed. On 29th November 2012 you wrote:

"
Sounds OK.  I propose then to have the above be the default firmware
name, along with a module parameter that will override if specified.
"

and I wrote back:

"
Sounds good.
"

As you can see, there was no objection from me.

> 
> Since the fw file (i.e., DSP program) is typically paired with a particular Linux app, I like the ability to specify the fw filename at runtime, depending on the Linux app I need to run.

Right, and platform data is not the way to achieve this.

Thanks,
Sekhar
