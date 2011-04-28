From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 15:18:18 +0100
Subject: [PATCH 4/4] omap: musb: introduce default baord config
In-Reply-To: <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il>
	<c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
	<FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
Message-ID: <20110428141818.GE19709@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 12:23:18AM -0400, Oleg Drokin wrote:
> Hello!
> 
> On Apr 24, 2011, at 6:09 PM, Mike Rapoport wrote:
> > -void __init usb_musb_init(struct omap_musb_board_data *board_data)
> > +static struct omap_musb_board_data musb_default_board_data = {
> > +	.interface_type		= MUSB_INTERFACE_ULPI,
> > +	.mode			= MUSB_OTG,
> 
> In fact can you make it more generic with ifdefs like this?
> (since there are tons of boards taht are client only or would like to be compiled in some other way):
> 
> +#ifdef CONFIG_USB_MUSB_OTG
> +       .mode                   = MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> +       .mode                   = MUSB_HOST,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> +       .mode                   = MUSB_PERIPHERAL,
> +#endif

If this is something that's desired, then it should not be done via ifdefs
but by platforms passing the mode argument into an initialization function.
Eventually, when we switch to some DT like system, this is the kind of
information that would be obtained from DT, and identifying this stuff
now will help when DT stuff comes along.
