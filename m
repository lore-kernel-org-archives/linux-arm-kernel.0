From: leoli@freescale.com (Li Yang)
Date: Tue, 8 Mar 2016 13:52:29 -0600
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <CADRPPNRH28W6u8adSb9Ja0JSJvFgcKF+2jYa3GSKBcGVsZcdLQ@mail.gmail.com>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <56CADCE9.9090305@linaro.org> <20160222220750.GI21240@tuxbot>
 <CADRPPNRH28W6u8adSb9Ja0JSJvFgcKF+2jYa3GSKBcGVsZcdLQ@mail.gmail.com>
Message-ID: <CADRPPNS0q3Q9j4AYvqRfcSaQ6BzLiL6zM5tn7MwJ613iNA1iPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 4:59 PM, Li Yang <leoli@freescale.com> wrote:
> On Mon, Feb 22, 2016 at 4:07 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>> On Mon 22 Feb 02:03 PST 2016, Srinivas Kandagatla wrote:
>>
>>>
>>>
>>> On 22/02/16 05:32, Bjorn Andersson wrote:
>>> >On certain platforms (e.g. ARM64) the dma_ops needs to be explicitly set
>>> >to be able to do DMA allocations, so use the of_dma_configure() helper
>>> >to populate the dma properties and assign an appropriate dma_ops.
>
> We also hit the same issue with the dwc3 driver.
>
>>> >
>>> >Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> >---
>>> >  drivers/usb/chipidea/core.c | 4 ++++
>>> >  1 file changed, 4 insertions(+)
>>> >
>>> >diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>>> >index 7404064b9bbc..047b9d4e67aa 100644
>>> >--- a/drivers/usb/chipidea/core.c
>>> >+++ b/drivers/usb/chipidea/core.c
>>> >@@ -62,6 +62,7 @@
>>> >  #include <linux/usb/chipidea.h>
>>> >  #include <linux/usb/of.h>
>>> >  #include <linux/of.h>
>>> >+#include <linux/of_device.h>
>>> >  #include <linux/phy.h>
>>> >  #include <linux/regulator/consumer.h>
>>> >  #include <linux/usb/ehci_def.h>
>>> >@@ -834,6 +835,9 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>>> >     pdev->dev.dma_parms = dev->dma_parms;
>>> >     dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
>>> >
>>> >+    if (IS_ENABLED(CONFIG_OF) && dev->of_node)
>>> >+            of_dma_configure(&pdev->dev, dev->of_node);
>>> >+
>>> Would we hit the same issue if we are on non Device tree platforms like ACPI
>>> or platform device style itself?
>>>
>>
>> As far as I can see, yes.
>>
>>>
>>> >     ret = platform_device_add_resources(pdev, res, nres);
>>> >     if (ret)
>>> >             goto err;
>>> >
>>>
>>> I think this is the side effect of commit
>>> 1dccb598df549d892b6450c261da54cdd7af44b4(arm64: simplify dma_get_ops)
>>>
>>
>> I agree, before that we would have hit:
>>
>> __generic_dma_ops() {
>> ..
>>        else if (acpi_disabled)
>>                return dma_ops;
>> ...
>> }
>>
>> with dma_ops being swiotlb_dma_ops from arm64_dma_init().
>>
>>
>> But this would not have saved us in the ACPI case, i.e. the result would
>> have been as with my suggested patch. Poking Arnd here to see if he has
>> any input.
>>
>>> None of the drivers call of_dma_configure() explicitly, which makes me feel
>>> that we are doing something wrong. TBH, this should be handled in more
>>> generic way rather than driver like this having an explicit call to
>>> of_dma_configure().
>>>
>>
>> I agree, trying to figure out if it should be inherited or something.
>
> I also agree.  We need address it in a more generic way.  I did a
> search for platform_device_add()/platform_device_register() in the
> kernel source code.  I found a lot of them and many could be also
> doing DMA.  Looks like it is still too early to assume every device is
> already getting dma_ops set through bus probe.  Otherwise, many
> drivers are potentially broken by this assumption.

Any further comment on this topic?  I added the linux-arm mailing list
which was missing from previous discussion.

Regards,
Leo
