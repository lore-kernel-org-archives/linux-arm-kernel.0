From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 17:09:52 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	<1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>	<CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>	<1384766276.14845.155.camel@smile>	<528A5170.3090809@wwwdotorg.org>	<1384862421.14845.222.camel@smile>	<528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
Message-ID: <528BFDD0.3090503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 04:37 PM, Dan Williams wrote:
> On Tue, Nov 19, 2013 at 9:15 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/19/2013 05:00 AM, Andy Shevchenko wrote:
>>> On Mon, 2013-11-18 at 10:42 -0700, Stephen Warren wrote:
>>>> On 11/18/2013 02:18 AM, Shevchenko, Andriy wrote:
>>>>> On Fri, 2013-11-15 at 13:01 -0800, Dan Williams wrote:
>>>>>> On Fri, Nov 15, 2013 at 12:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>>
>>>>>>> Eventually, all drivers should be converted to this new API, the old API
>>>>>>> removed, and the new API renamed to the more desirable name.
>>>>>
>>>>> I really would like to see more sensible and shorter names for the API
>>>>> functions.
>>>>
>>>> I'm not sure if you're suggesting that you:
>>>>
>>>> a) Really want to API renaming I mention above to happen at some time.
>>>>
>>>> b) We need to pick a better name now, for the new API this patch
>>>> introduces. If so, do you have any better suggestion?
>>>
>>> Sooner better, I think.
>>>
>>> Now only what I can propose is to change
>>> dma_slave_request_channel_or_err() to dma_slave_request_chan().
>>
>> The one downside I see with the name dma_slave_request_chan() is that
>> it's very similar to the existing dma_request_slave_channel(); driver
>> authors may well be confused which is which, and end up using the wrong
>> one. That's why I added an explicit "_or_err" to the function name.
>> Still, I can go for dma_slave_request_chan() if the dmaengine
>> maintainers think it's the right choice; just let me know.
> 
> I think the problem with dma_slave_request_channel_or_err() is that it
> does not tell you what the function does or how it's different from
> the existing one.  I think dma_slave_request_channel_defer() with a
> comment about what error value callers should be expecting to
> delineate a permanent error vs "try again later".

Deferred probe certainly isn't the only error that can be returned
though, so I don't think "defer" in the name makes much sense. The
function as I wrote it returns a standard "error pointer" value.
Typically, callers would simply propagate *any* error code back to the
caller of probe() without even looking at it; it's the driver core that
checks for -EPROBE_DEFER vs. other error codes. In some cases, drivers
do check in order to avoid printing failure messages in the deferred
probe case, but again that's pretty standard, and not something specific
to this API.
