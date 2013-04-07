From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 07 Apr 2013 21:55:08 +0400
Subject: [PATCH v9 4/6] ARM: davinci: Add a remoteproc driver
 implementation for OMAP-L13x DSP
In-Reply-To: <CAK=WgbZme2UkMeP-JB2h3xnmcpzAaYeOcy7gxh60muJ8KZbr_A@mail.gmail.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-5-git-send-email-rtivy@ti.com>
 <CAK=WgbZme2UkMeP-JB2h3xnmcpzAaYeOcy7gxh60muJ8KZbr_A@mail.gmail.com>
Message-ID: <5161B2FC.2090605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/07/2013 05:02 PM, Ohad Ben-Cohen wrote:

>
>> +static int da8xx_rproc_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct da8xx_rproc *drproc;
>> +       struct rproc *rproc;
>> +       struct irq_data *irq_data;
>> +       struct resource *bootreg_res;
>> +       struct resource *chipsig_res;
>> +       struct clk *dsp_clk;
>> +       void __iomem *chipsig;
>> +       void __iomem *bootreg;
>> +       int irq;
>> +       int ret;
>> +
[...]
>> +       bootreg = devm_request_and_ioremap(dev, bootreg_res);
>> +       if (!bootreg) {
>> +               dev_err(dev, "unable to map boot register\n");
>> +               return -EADDRNOTAVAIL;
>> +       }
>> +
>> +       chipsig = devm_request_and_ioremap(dev, chipsig_res);

    I suggest that you use more modern (yes, already a newer interface :-)
devm_ioremap_resource() instead -- it returns the error code (as a pointer)
in case of error, and it certainly doesn't require you to print error 
messages.

>> +       if (!chipsig) {
>> +               dev_err(dev, "unable to map CHIPSIG register\n");
>> +               return -EADDRNOTAVAIL;
>> +       }
>>

WBR, Sergei
