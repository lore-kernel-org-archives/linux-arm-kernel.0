From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:42:08 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <1384766276.14845.155.camel@smile>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>	
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile>
Message-ID: <528A5170.3090809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 02:18 AM, Shevchenko, Andriy wrote:
> On Fri, 2013-11-15 at 13:01 -0800, Dan Williams wrote:
>> On Fri, Nov 15, 2013 at 12:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>>> Eventually, all drivers should be converted to this new API, the old API
>>> removed, and the new API renamed to the more desirable name. 
> 
> I really would like to see more sensible and shorter names for the API
> functions.

I'm not sure if you're suggesting that you:

a) Really want to API renaming I mention above to happen at some time.

b) We need to pick a better name now, for the new API this patch
introduces. If so, do you have any better suggestion?

>>> --- a/drivers/dma/acpi-dma.c
>>> +++ b/drivers/dma/acpi-dma.c
>>> @@ -334,7 +334,7 @@ static int acpi_dma_parse_fixed_dma(struct acpi_resource *res, void *data)
>>>   * @dev:       struct device to get DMA request from
>>>   * @index:     index of FixedDMA descriptor for @dev
>>>   *
>>> - * Returns pointer to appropriate dma channel on success or NULL on error.
>>> + * Returns pointer to appropriate dma channel on success or an error pointer.
>>>   */
>>>  struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
>>>                 size_t index)
>>> @@ -349,10 +349,10 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
> 
> We use default value of chan if it's not found. Perhaps you have to
> change it as well to something like ERR_PTR(-ENOENT).

Ah yes. I think I'll keep the default value of chan = NULL, and just
change the return statement to something like:

return chan ? chan : ERR_PTR(-ENOENT);

That way, the fact that adma->acpi_dma_xlate() returns
NULL-or-valid-pointer and the check of chan against NULL inside the
list_for_each_entry() won't have to change.
