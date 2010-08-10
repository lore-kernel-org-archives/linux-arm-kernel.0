From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 00:21:30 +0300
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <alpine.LFD.2.00.1007061316010.6020@xanadu.home>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
	<4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
	<AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com>
	<alpine.LFD.2.00.1007061316010.6020@xanadu.home>
Message-ID: <AANLkTincjpb4_c13AAx-HoZ5xsdunRGkVeO1P5EJegX1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 6, 2010 at 8:42 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Another function pair would be needed instead, which would do almost
> like the suspend/resume code is already doing. ?Something like:
>
> /*
> ?* Indicate to the core SDIO layer that we're not requiring that the
> ?* function remain powered. ?If all functions for the card are in the
> ?* same "no power" state, then the host controller can remove power from
> ?* the card. ?Note: the function driver must preserve hardware states if
> ?* necessary.
> ?*/
> int sdio_release_power(struct sdio_func *func);
>
> /*
> ?* Indicate to the core SDIO layer that we want power back for this
> ?* SDIO function. ?The power may or may not actually have been removed
> ?* since last call to sdio_release_power(), so the function driver must
> ?* not assume any preserved state at the hardware level and re-perform
> ?* all the necessary hardware config. ?This function returns 0 when
> ?* power is actually restored, or some error code if this cannot be
> ?* achieved. ?One error reason might be that the card is no longer
> ?* available on the bus (was removed while powered down and card
> ?* detection didn't trigger yet).
> ?*/
> int sdio_claim_power(struct sdio_func *func);
>
> That's it. ?When the network interface is down and the hardware is not
> needed, you call sdio_release_power(). ?When the request to activate the
> network interface is received, you call sdio_claim_power() and configure
> the hardware appropriately. ?If sdio_claim_power() returns an error,
> then you just return an error to the network request, and eventually the
> driver's remove method will be called if this is indeed because the card
> was removed.
>

After playing with this a little, I am getting convinced that the way
to go here is to add runtime pm support to MMC/SDIO.

It just fits perfectly into this model:

Runtime PM already takes care of usage count per device (so it would
tell if an SDIO function is idle), takes into account parent-child
relationships (so if all SDIO functions are idle, it would
automatically send an idle request to the card device), doesn't break
existing drivers (drivers needs to explicitly enable it), play along
nicely with the system suspend/resume, etc..

I'm going to split the patches to two:
- first half would be basic wl1271 support for omap/zoom. it's pretty
straight forward and can probably already go thru.
- second half would be adding runtime PM to SDIO/MMC. I'll post some
initial patches to set off a discussion.

Thanks,
Ohad.
