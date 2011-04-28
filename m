From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 22:54:28 +0100
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <4DB9DD54.8080306@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
	<20110428091517.GP17290@n2100.arm.linux.org.uk>
	<4DB9DD54.8080306@bluewatersys.com>
Message-ID: <20110428215428.GR17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 09:34:12AM +1200, Ryan Mallon wrote:
> On 04/28/2011 09:15 PM, Russell King - ARM Linux wrote:
> > On Thu, Apr 21, 2011 at 06:19:37PM -0500, H Hartley Sweeten wrote:
> >> +static struct platform_device at91_eth_device = {
> >> +	.name		= "macb",
> >> +	.id		= -1,
> >> +	.dev		= {
> >> +		.dma_mask		= &at91_eth_device.dev.coherent_dma_mask,
> >> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> >>
> >> That will get rid of the static u64 variable used for every dma
> >> capable device.
> > 
> > I've never really liked that, because coherent_dma_mask is never changed,
> > but the value pointed to be dma_mask can be by drivers.  See dma_set_mask().
> > 
> > So, calling dma_set_mask() on any device which does the above will also
> > (unexpectedly?) change the coherent mask too.
> > 
> > It's a minor point as we don't have many platform drivers using
> > dma_set_mask().
> 
> I've got a couple of other minor changes, but will aim to push out an
> updated version of the series today. Russell, are you happy for me to
> leave the dma_mask stuff as is in the series?

Yes, I think as it is in your series is better than pointing it at
coherent_dma_mask, which makes stuff more representative of what
other subsystems have traditionally done (kept the two separate.)
