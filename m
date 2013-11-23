From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Nov 2013 00:34:42 +0000
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <528F9DF9.6080706@wwwdotorg.org>
References: <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
Message-ID: <20131123003442.GH16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:10:01AM -0700, Stephen Warren wrote:
> On 11/22/2013 11:04 AM, Dan Williams wrote:
> > I made that assumption because that is what your original patch proposed:
> > 
> > +/**
> > + * dma_request_slave_channel_or_err - try to allocate an exclusive
> > slave channel
> > + * @dev:       pointer to client device structure
> > + * @name:      slave channel name
> > + *
> > + * Returns pointer to appropriate dma channel on success or an error pointer.
> > + */
> > 
> > What's the benefit of leaking NULL values to callers?  If they already
> > need to check for err, why force them to check for NULL too?
> 
> "Returns pointer to appropriate dma channel on success or an error
> pointer." means that callers only have to check for an ERR value. If the
> function returns NULL, then other DMA-related functions must treat that
> as a valid channel ID. This is case (a) in my previous email.

Stephen, Dan,

My point (which you quoted) is a fine one - read the definition above.

"Returns pointer to appropriate DMA channel on success or an error pointer."

This defines the range of values which are considered successful, and
those which are considered to be errors.  Error pointers are defined
by IS_ERR(ptr) being true (not by IS_ERR_OR_NULL(ptr) being true.
Conversely, it defines what are considered to be non-errors.

Therefore, users of such a function _must_ check the return value using
IS_ERR() and not the IS_ERR_OR_NULL() abomination.

The question about NULL is unanswered, but with nothing specified, users
must assume that if a subsystem returns NULL, it's fine to pass that back
to the subsystem.  If the subsystem didn't intend for NULL to be valid,
it shouldn't be returning NULL from such a defined function.

It's not up to the user of the interface to dream up an error code if
the subsystem happens to return NULL, or do other crap stuff like this:

	if (IS_ERR_OR_NULL(ptr))
		return PTR_ERR(ptr);

which we already see cropping up from time to time.

So, my argument is that if you define an API to be "pointers on success,
or error pointers" then your API better handle any cookie you return
which satisfies IS_ERR(ptr) = false - which by definition includes NULL.
