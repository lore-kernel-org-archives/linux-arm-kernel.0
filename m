From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 12:22:46 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	<1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>	<CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>	<1384766276.14845.155.camel@smile>	<528A5170.3090809@wwwdotorg.org>	<1384862421.14845.222.camel@smile>	<528B9CAE.3040600@wwwdotorg.org>	<CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>	<528BFDD0.3090503@wwwdotorg.org>	<CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>	<528CFE68.6060908@wwwdotorg.org>
 <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
Message-ID: <528D0C06.9080006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 12:15 PM, Dan Williams wrote:
> On Wed, Nov 20, 2013 at 10:24 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/19/2013 05:38 PM, Dan Williams wrote:
>>> On Tue, Nov 19, 2013 at 4:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> Deferred probe certainly isn't the only error that can be returned
>>>> though,
>>>
>>> Of course, but do any of those other ones matter?  Certainly not if
>>> they've all been hidden behind a NULL return from
>>> dma_request_slave_channel().
>>>
>>>> so I don't think "defer" in the name makes much sense. The
>>>> function as I wrote it returns a standard "error pointer" value.
>>>> Typically, callers would simply propagate *any* error code back to the
>>>> caller of probe() without even looking at it; it's the driver core that
>>>> checks for -EPROBE_DEFER vs. other error codes. In some cases, drivers
>>>> do check in order to avoid printing failure messages in the deferred
>>>> probe case, but again that's pretty standard, and not something specific
>>>> to this API.
>>>
>>> Right, but the only reason to introduce this API is to propagate
>>> EPROBE_DEFER, right?  It also serves to document drivers that are
>>> prepared for / depend on deferred probing support.
>>
>> Well, that's the reason I'm introducing the API, but it's not really
>> what the API actually does.
>>
> 
> True, this is quite a bit of back and forth for something that will be
> temporary.  How bad would it be to short-circuit this discussion and
> go straight to converting dma_request_slave_channel().  Leave
> dma_request_channel() as is and just convert the 20 or so users of
> dma_request_slave_channel() over?

I had thought about that, but there are drivers that use
dma_request_slave_channel(), but fall back to dma_request_channel() if
that fails. I think there were other cases where the two APIs were
mixed. Drivers would then have a value that sometimes IS_ERR() or is
valid, and other times ==NULL or is valid. So, the values would have to
be checked using IS_ERR_OR_NULL() which I believe is now deprecated  -
certainly Russell will shout at me if I start introducing more usage! So
that means converting dma_request_channel()'s return value too, and that
is a /lot/ more to convert. I suppose an alternative might be to have
the individual affected drivers convert a NULL return from
dma_request_channel() to an ERR value, but for some reason I forget now,
even that looked problematic.
