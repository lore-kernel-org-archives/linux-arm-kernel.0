From: prakity@marvell.com (Philip Rakity)
Date: Fri, 25 Nov 2011 10:53:04 -0800
Subject: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
In-Reply-To: <CAMj5Bki3Ev8K63538-dNbyijUw1oNTLChADLd4=Ef-LeCkoacw@mail.gmail.com>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849609-3013-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <CAMj5Bki3Ev8K63538-dNbyijUw1oNTLChADLd4=Ef-LeCkoacw@mail.gmail.com>
Message-ID: <2E59C2F0-403B-4F61-971D-14C17FEDF96A@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Nov 25, 2011, at 4:47 AM, zhangfei gao wrote:

> 
> 
> On Mon, Nov 21, 2011 at 12:26 PM, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> wrote:
> PXA16x devices uses SDHCI controller v1. As it's not much different
> than v2 controller, v1 driver is merged with sdhci-pxav2 driver
> 
> v2 - instead of having separate file sdhci-pxav1, merge code with
>     sdhci-pxav2 driver code as suggested by Chris Ball
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
> +/*
> + * we cannot talk to controller for 8 bus cycles according to sdio spec
> + * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
> + * which is quite a LONG TIME on a fast cpu -- so delay if needed
> + */
> 
> Would you mind provide more info, still not understand.
> What sdio spec 12.1 says cards shall switch speed mode within 8 clocks after the end bit of the corresponding response.
> 


The pxa168 h/w controller is broken.  It does NOT wait  for the 8 clocks.


> +static void platform_specific_completion(struct sdhci_host *host)
> +{
> +       struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +       struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +
> +       if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
> +               mdelay(pdata->delay_in_ms);
> +}
> +
> 
