From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 21 Nov 2013 22:54:26 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <528E4F55.9070204@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile> <528A5170.3090809@wwwdotorg.org>
 <1384862421.14845.222.camel@smile> <528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
 <528BFDD0.3090503@wwwdotorg.org>
 <CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>
 <528CFE68.6060908@wwwdotorg.org>
 <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
Message-ID: <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:22 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/20/2013 08:22 PM, Dan Williams wrote:
>> On Wed, Nov 20, 2013 at 1:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 11/20/2013 01:23 PM, Williams, Dan J wrote:
>>> ...
>>>> Why do the drivers that call dma_request_channel need to convert it to
>>>> an ERR value?  i.e. what's problematic about the below (not compile
>>>> tested)?
>>> ...
>>>> diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
>>> ...
>>>> @@ -22,16 +22,20 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
>>>>                               struct samsung_dma_req *param,
>>>>                               struct device *dev, char *ch_name)
>>> ...
>>>> +     if (dev->of_node) {
>>>> +             chan = dma_request_slave_channel(dev, ch_name);
>>>> +             return IS_ERR(chan) ? (unsigned) NULL : (unsigned) chan;
>>>> +     } else {
>>>>               return (unsigned)dma_request_channel(mask, pl330_filter,
>>>>                                                       (void *)dma_ch);
>>>> +     }
>>>
>>> The argument is that if a function returns errors encoded as an ERR
>>> pointer, then callers must assume that any non-IS_ERR value that the
>>> function returns is valid. NULL is one of those values. As such, callers
>>> can no longer check the value against NULL, but must use IS_ERR().
>>> Converting any IS_ERR() returns to NULL theoretically is the act of
>>> converting one valid return value to some other completely random return
>>> value.
>>
>> You describe how IS_ERR() works, but you didn't address the patch.
>> There's nothing random about the changes to samsung_dmadev_request().
>> It still returns NULL or a valid channel just as before.
>
> I was addressing the patch. I guess I should have explained as follows.
>
> First, the following code is technically buggy:

No, it's not, but I think we have different implementations in mind.

>
> +             chan = dma_request_slave_channel(dev, ch_name);
> +             return IS_ERR(chan) ? (unsigned) NULL : (unsigned) chan;
>
> ... since it assumes that dma_request_slave_channel() never returns NULL
> as a valid non-error value. This is specifically prohibited by the fact
> that dma_request_slave_channel() returns either an ERR value or a valid
> value; in that case, NULL is not an ERR value, and hence must be
> considered valid.

Let's stop there and be clear we are talking about the same proposal.

The proposal is dma_request_slave_channel only returns errors or valid
pointers, never NULL.

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9162ac80c18f..64c163664b9d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,15 +593,20 @@ EXPORT_SYMBOL_GPL(__dma_request_channel);
  */
 struct dma_chan *dma_request_slave_channel(struct device *dev, const
char *name)
 {
+       struct dma_chan *chan = ERR_PTR(-ENODEV);
+
        /* If device-tree is present get slave info from here */
        if (dev->of_node)
                return of_dma_request_slave_channel(dev->of_node, name);

        /* If device was enumerated by ACPI get slave info from here */
-       if (ACPI_HANDLE(dev))
-               return acpi_dma_request_slave_chan_by_name(dev, name);
+       if (ACPI_HANDLE(dev)) {
+               chan = acpi_dma_request_slave_chan_by_name(dev, name);
+               if (!chan)
+                       chan = ERR_PTR(-ENODEV);
+       }

-       return NULL;
+       return chan;
 }

In the above the assumption is that of_dma_request_slave_channel() is
modified to guarantee it only returns ERR_PTRs or valid pointers never
NULL.  acpi_dma_request_slave_chan_by_name() can continue returning
NULL and dma_request_slave_channel will translate it to an ERR_PTR, or
you can convert it as you do in your patch.  Not much value in
converting acpi_dma_request_slave_chan_by_name as it does not return
EPROBE_DEFER and nothing currently cares about the other error values.
