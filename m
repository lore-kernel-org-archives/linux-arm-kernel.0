From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Nov 2013 12:53:16 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4ig3TWAYWsw5_-MWfKABma9-JCF=Gh-inuxeJF6su-NVw@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	<1384766276.14845.155.camel@smile>	<528A5170.3090809@wwwdotorg.org>	<1384862421.14845.222.camel@smile>	<528B9CAE.3040600@wwwdotorg.org>	<CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>	<528BFDD0.3090503@wwwdotorg.org>	<CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>	<528CFE68.6060908@wwwdotorg.org>	<CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>	<528D0C06.9080006@wwwdotorg.org>	<1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>	<528D28A1.2050307@wwwdotorg.org>	<CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>	<528E4F55.9070204@wwwdotorg.org>	<CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>	<528F95A9.2050305@wwwdotorg.org>	<CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>	<528F9DF9.6080706@wwwdotorg.org>
 <CAPcyv4ig3TWAYWsw5_-MWfKABma9-JCF=Gh-inuxeJF6su-NVw@mail.gmail.com>
Message-ID: <528FB62C.2060607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 12:49 PM, Dan Williams wrote:
> On Fri, Nov 22, 2013 at 10:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>> The proposal is dma_request_slave_channel only returns errors or valid
>>>>> pointers, never NULL.
>>>>
>>>> OK, so if you make that assumption, I guess it's safe.
>>>
>>> I made that assumption because that is what your original patch proposed:
>>>
>>> +/**
>>> + * dma_request_slave_channel_or_err - try to allocate an exclusive
>>> slave channel
>>> + * @dev:       pointer to client device structure
>>> + * @name:      slave channel name
>>> + *
>>> + * Returns pointer to appropriate dma channel on success or an error pointer.
>>> + */
>>>
>>> What's the benefit of leaking NULL values to callers?  If they already
>>> need to check for err, why force them to check for NULL too?
>>
>> "Returns pointer to appropriate dma channel on success or an error
>> pointer." means that callers only have to check for an ERR value. If the
>> function returns NULL, then other DMA-related functions must treat that
>> as a valid channel ID. This is case (a) in my previous email.
> 
> How can a channel be "valid" and NULL at the same time?  Without the
> guarantee that dma_request_channel always returns a non-null-channel
> pointer or an error pointer you're forcing clients to use or open-code
> IS_ERR_OR_NULL.

No, callers should just follow the documentation. If all error cases are
indicated by an ERR pointer, then there is no need to check for NULL. In
fact, client must not check anything beyond whether the value is an ERR
value or not. So, there's no need to use IS_ERR_OR_NULL.

It's up to the API to make sure that it returns values that are valid
for other calls to related APIs. If that doesn't include NULL, it won't
return NULL. If it does, it might. But, that's an internal
implementation detail of the API (and associated APIs), not something
that clients should know about.

One situation where a NULL might be valid is where the return value
isn't really a pointer, but an integer index or ID cast to a pointer.
