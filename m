From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Nov 2013 00:40:05 +0000
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <CAPcyv4ig3TWAYWsw5_-MWfKABma9-JCF=Gh-inuxeJF6su-NVw@mail.gmail.com>
References: <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <CAPcyv4ig3TWAYWsw5_-MWfKABma9-JCF=Gh-inuxeJF6su-NVw@mail.gmail.com>
Message-ID: <20131123004005.GI16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:49:55AM -0800, Dan Williams wrote:
> On Fri, Nov 22, 2013 at 10:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >>>> The proposal is dma_request_slave_channel only returns errors or valid
> >>>> pointers, never NULL.
> >>>
> >>> OK, so if you make that assumption, I guess it's safe.
> >>
> >> I made that assumption because that is what your original patch proposed:
> >>
> >> +/**
> >> + * dma_request_slave_channel_or_err - try to allocate an exclusive
> >> slave channel
> >> + * @dev:       pointer to client device structure
> >> + * @name:      slave channel name
> >> + *
> >> + * Returns pointer to appropriate dma channel on success or an error pointer.
> >> + */
> >>
> >> What's the benefit of leaking NULL values to callers?  If they already
> >> need to check for err, why force them to check for NULL too?
> >
> > "Returns pointer to appropriate dma channel on success or an error
> > pointer." means that callers only have to check for an ERR value. If the
> > function returns NULL, then other DMA-related functions must treat that
> > as a valid channel ID. This is case (a) in my previous email.
> 
> How can a channel be "valid" and NULL at the same time?  Without the
> guarantee that dma_request_channel always returns a non-null-channel
> pointer or an error pointer you're forcing clients to use or open-code
> IS_ERR_OR_NULL.  Make the caller's life easier and just turn success
> or failure like before.

It's absolutely fine for an API to return "valid pointers or an error
pointer" and not have to care about the NULL condition.  Really.

Think about it.

	chan = dma_request_blah();
	if (IS_ERR(chan))
		return PTR_ERR(chan);

	dma_do_something(chan);

Now, if the API is defined to be "valid pointers or error pointers" the
above code is quite sane.  The user is doing everything required to use
the API safely.

However, if dma_request_blah() happens to return NULL, that's a failure
of dma_request_blah() - not of the user to check for it.  If
dma_request_blah() is never supposed to return NULL, then there won't be
any checks done to handle a NULL pointer into dma_do_something(), and we
get to find out about this failure by a kernel NULL pointer deref oops.

That's a good thing.  We have a condition which can be debugged and the
bug which caused the NULL pointer to be returned can be found and fixed.
