From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 20 Nov 2013 19:22:49 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <528D28A1.2050307@wwwdotorg.org>
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
Message-ID: <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 1:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/20/2013 01:23 PM, Williams, Dan J wrote:
> ...
>> Why do the drivers that call dma_request_channel need to convert it to
>> an ERR value?  i.e. what's problematic about the below (not compile
>> tested)?
> ...
>> diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
> ...
>> @@ -22,16 +22,20 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
>>                               struct samsung_dma_req *param,
>>                               struct device *dev, char *ch_name)
> ...
>> +     if (dev->of_node) {
>> +             chan = dma_request_slave_channel(dev, ch_name);
>> +             return IS_ERR(chan) ? (unsigned) NULL : (unsigned) chan;
>> +     } else {
>>               return (unsigned)dma_request_channel(mask, pl330_filter,
>>                                                       (void *)dma_ch);
>> +     }
>
> The argument is that if a function returns errors encoded as an ERR
> pointer, then callers must assume that any non-IS_ERR value that the
> function returns is valid. NULL is one of those values. As such, callers
> can no longer check the value against NULL, but must use IS_ERR().
> Converting any IS_ERR() returns to NULL theoretically is the act of
> converting one valid return value to some other completely random return
> value.

You describe how IS_ERR() works, but you didn't address the patch.
There's nothing random about the changes to samsung_dmadev_request().
It still returns NULL or a valid channel just as before.

> The converse is true for functions that return errors encoded as NULL;
> callers must check those return results against NULL.
>
> There's no intersection between those two sets of legal tests.

I don't understand what you are trying to say.  I'm not proposing an
intersection.  I'm proposing that clients explicitly handle an updated
dma_request_slave_channel and we skip this interim
dma_request_slave_channel_no_err step.

Proliferating yet another *request_channel* api is worse than just
having clients understand that dma_request_slave_channel now encodes
errors while dma_request_slave_channel_compat and dma_request_channel
still just return NULL.
