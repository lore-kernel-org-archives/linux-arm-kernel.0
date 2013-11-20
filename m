From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 19 Nov 2013 16:38:29 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <528BFDD0.3090503@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile> <528A5170.3090809@wwwdotorg.org>
 <1384862421.14845.222.camel@smile> <528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
 <528BFDD0.3090503@wwwdotorg.org>
Message-ID: <CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 4:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Deferred probe certainly isn't the only error that can be returned
> though,

Of course, but do any of those other ones matter?  Certainly not if
they've all been hidden behind a NULL return from
dma_request_slave_channel().

> so I don't think "defer" in the name makes much sense. The
> function as I wrote it returns a standard "error pointer" value.
> Typically, callers would simply propagate *any* error code back to the
> caller of probe() without even looking at it; it's the driver core that
> checks for -EPROBE_DEFER vs. other error codes. In some cases, drivers
> do check in order to avoid printing failure messages in the deferred
> probe case, but again that's pretty standard, and not something specific
> to this API.

Right, but the only reason to introduce this API is to propagate
EPROBE_DEFER, right?  It also serves to document drivers that are
prepared for / depend on deferred probing support.

Good old bike shedding... I only jumped in because I think changing it
to dma_slave_request_chan() would indeed be confusing .
