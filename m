From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 22 Nov 2013 15:45:06 -0800
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
Message-ID: <CAPcyv4gmo0k3n8==0oEs4NMKbEH4F9xHutRTURE7sVe=M7xwRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:22 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/20/2013 08:22 PM, Dan Williams wrote:
> 2)
>
>         /* These first 3 lines are part of your patch */
>         chan = dma_request_slave_channel(dev, ch_name);
>         if (IS_ERR(chan)
>                 chan = NULL;
>         if (!chan) // This test and the above are IS_ERR_OR_NULL
>                 attempt allocation some other way;

No it isn't.  IS_ERR_OR_NULL means the api returns 3 states (channel,
null, error-pointer).  The client converting error-pointer to NULL
after the fact is explicit way to say that the client does not care
about the error value.  The client is simply throwing away the error
code and converting the result back into a pass fail.

>         /*
>          * This is code elsewhere in a driver where DMA is optional;
>          * that code must act differently based on whether a DMA
>          * channel was acquired or not. So, it tests chan against
>          * NULL.
>          */
>         if (!chan) // This test and the above IS_ERR are IS_ERR_OR_NULL
>                 return -ESOMETHING;

It's not, because at this point chan will never be an error pointer.
Sure you could do follow on cleanups to allow this driver to propagate
the dma_request_slave_channel error code up and change this to if
(IS_ERR(chan)) return PTR_ERR(chan), but that's incremental to the
initial conversion.

> In case (2) above, if the driver /only/ calls a modified
> dma_request_slave_channel(), all the checks could just be if
> (IS_ERR(chan)) instead - then problem solved.

It's not solved, you would need to audit the rest of the driver to
make sure that everywhere it checks a channel is NULL it checks for
IS_ERR instead.  That's a deeper / unnecessary rework for driver's
that don't care about the reason they did not get a channel.

> However, if the driver
> mixes the new dma_request_slave_channel() and the unconverted
> dma_request_channel(), it has to either (a) convert an ERR return from
> dma_request_slave_channel() to match dma_request_channel()'s NULL error

Yes, better to live with this situation and convert existing drivers
vs have a subset of drivers call a new
dma_request_slave_channel_or_err() API and then *still* need to
convert it to NULL.

> return, or (b) convert a NULL return from dma_request_channel() to match
> dma_request_slave_channel()'s ERR return. Without the conversion, all
> tests would have to use the deprecated IS_ERR_OR_NULL. Either of those
> conversion options converts an error value from 1 API into a
> theoretically valid return value from the other API, which is a bug.

Getting an error from dma_request_slave_channel() and converting that
value to NULL is a bug because dma_request_channel() would also return
NULL if it did not get a channel?  That's normalization, not a bug.
