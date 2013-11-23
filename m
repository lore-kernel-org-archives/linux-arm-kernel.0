From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Nov 2013 17:17:06 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAPcyv4gmo0k3n8==0oEs4NMKbEH4F9xHutRTURE7sVe=M7xwRg@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>	<1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>	<CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>	<1384766276.14845.155.camel@smile>	<528A5170.3090809@wwwdotorg.org>	<1384862421.14845.222.camel@smile>	<528B9CAE.3040600@wwwdotorg.org>	<CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>	<528BFDD0.3090503@wwwdotorg.org>	<CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>	<528CFE68.6060908@wwwdotorg.org>	<CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>	<528D0C06.9080006@wwwdotorg.org>	<1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>	<528D28A1.2050307@wwwdotorg.org>	<CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>	<528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4gmo0k3n8==0oEs4NMKbEH4F9xHutRTURE7sVe=M7xwRg@mail.gmail.com>
Message-ID: <528FF402.6000503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 04:45 PM, Dan Williams wrote:
> On Thu, Nov 21, 2013 at 10:22 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/20/2013 08:22 PM, Dan Williams wrote:
>> 2)
>>
>>         /* These first 3 lines are part of your patch */
>>         chan = dma_request_slave_channel(dev, ch_name);
>>         if (IS_ERR(chan)
>>                 chan = NULL;
>>         if (!chan) // This test and the above are IS_ERR_OR_NULL
>>                 attempt allocation some other way;
> 
> No it isn't.  IS_ERR_OR_NULL means the api returns 3 states (channel,
> null, error-pointer).  The client converting error-pointer to NULL
> after the fact is explicit way to say that the client does not care
> about the error value.  The client is simply throwing away the error
> code and converting the result back into a pass fail.

The client can only translate an ERR value to NULL if it knows that the
API will never return NULL. If the API could return NULL, then this
translation uses a valid return value to represent the error case.
Functions that return an ERR value or a valid value do NOT in general
say anything either way about a return value of NULL.

While this translation isn't *exactly* the same as an API returning 3
states, it is almost identical; the translation is only possible if the
set of numerically possible return values from the function are
segmented into 3 sets:

a) Valid
b) An ERR value
c) NULL (which is never returned)

I believe the important point in Russell's argument against
IS_ERR_OR_NULL is that the segmentation should be limited to two sets
(a, b) or (a, c) and not 3. I don't /think/ it was relevant whether the
function segmented the return values into 3 sets just so it could
guarantee that it didn't return one of those sets.

If that's not the case, the following would indeed solve the problem easily:

> /**
>  * dma_request_slave_channel - try to allocate an exclusive slave channel
...
>  * Returns pointer to appropriate DMA channel on success or an error pointer.
>  * In order to ease compatibility with other DMA request APIs, this function
>  * guarantees NEVER to return NULL.
>  */

>>         /*
>>          * This is code elsewhere in a driver where DMA is optional;
>>          * that code must act differently based on whether a DMA
>>          * channel was acquired or not. So, it tests chan against
>>          * NULL.
>>          */
>>         if (!chan) // This test and the above IS_ERR are IS_ERR_OR_NULL
>>                 return -ESOMETHING;
> 
> It's not, because at this point chan will never be an error pointer.

It's the combination of the two. IS_ERR_OR_NULL is two separate tests in
one macro. Simply separating the two tests into separate lines of code
doesn't change what the code is doing.

> Sure you could do follow on cleanups to allow this driver to propagate
> the dma_request_slave_channel error code up and change this to if
> (IS_ERR(chan)) return PTR_ERR(chan), but that's incremental to the
> initial conversion.
> 
>> In case (2) above, if the driver /only/ calls a modified
>> dma_request_slave_channel(), all the checks could just be if
>> (IS_ERR(chan)) instead - then problem solved.
> 
> It's not solved, you would need to audit the rest of the driver to
> make sure that everywhere it checks a channel is NULL it checks for
> IS_ERR instead.  That's a deeper / unnecessary rework for driver's
> that don't care about the reason they did not get a channel.

I was of course assuming that the auditing would be done, and indeed
when I first started work on this conversion, it's exactly what I was
doing. That's why I said *all* checks, not just "the first check".

>> However, if the driver
>> mixes the new dma_request_slave_channel() and the unconverted
>> dma_request_channel(), it has to either (a) convert an ERR return from
>> dma_request_slave_channel() to match dma_request_channel()'s NULL error
> 
> Yes, better to live with this situation and convert existing drivers
> vs have a subset of drivers call a new
> dma_request_slave_channel_or_err() API and then *still* need to
> convert it to NULL.
> 
>> return, or (b) convert a NULL return from dma_request_channel() to match
>> dma_request_slave_channel()'s ERR return. Without the conversion, all
>> tests would have to use the deprecated IS_ERR_OR_NULL. Either of those
>> conversion options converts an error value from 1 API into a
>> theoretically valid return value from the other API, which is a bug.
> 
> Getting an error from dma_request_slave_channel() and converting that
> value to NULL is a bug because dma_request_channel() would also return
> NULL if it did not get a channel?  That's normalization, not a bug.

No, it's a bug because if dma_request_slave_channel() is documented to
return valid-or-ERR, then assuming that it can never return NULL is
inconsistent with that. The translation is only possible if it's
documented to return valid-or-ERR-but-never-NULL.
