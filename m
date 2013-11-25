From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 10:26:18 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <20131123003442.GH16735@n2100.arm.linux.org.uk>
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
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
Message-ID: <5293883A.8050808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2013 05:34 PM, Russell King - ARM Linux wrote:
[... various discussions re: IS_ERR, IS_ERR_OR_NULL, etc.]

Russell, so if we document dma_request_slave_channel() as follows:

> /*
>  * dma_request_slave_channel - try to allocate an exclusive slave channel
> ...
>  * Returns pointer to appropriate DMA channel on success or an error pointer.
>  * In order to ease compatibility with other DMA request APIs, this function
>  * guarantees NEVER to return NULL.
>  */

Are you then OK with clients doing either of e.g.:

chan = dma_request_slave_channel(...);
if (IS_ERR(chan))
	// This returns NULL or a valid handle/pointer
	chan = dma_request_channel()
if (!chan)
	Here, chan is invalid;
	return;
Here, chan is valid

or:

if (xxx) {
	chan = dma_request_slave_channel(...);
	// Convert to same error value as else{} block generates
	if (IS_ERR(chan))
		chan = NULL
} else {
	// This returns NULL or a valid handle/pointer
	chan = dma_request_channel()
}
if (!chan)
	Here, chan is invalid
	return;
Here, chan is valid
