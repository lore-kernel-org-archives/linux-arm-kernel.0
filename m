From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Jul 2013 09:45:20 -0600
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130719032328.GB20889@S2101-09.ap.freescale.net>
References: <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org> <20130717213836.GA13324@amd.pavel.ucw.cz>
 <51E719A6.6070105@wwwdotorg.org> <20130718112555.GB1021@amd.pavel.ucw.cz>
 <CAOesGMgi0j_mPyeBLVHb_QW+DwtAPoFY697eQO3-yp9tnP1vmA@mail.gmail.com>
 <20130719032328.GB20889@S2101-09.ap.freescale.net>
Message-ID: <51E95F10.5070006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2013 09:23 PM, Shawn Guo wrote:
> On Thu, Jul 18, 2013 at 11:45:29AM -0700, Olof Johansson wrote:
...
>> You're spending an awful lot of energy arguing over this, but nobody
>> has actually shown data of how much deferral is happening -- and that
>> it's a real problem. Until someone does so there's no reason to change
>> it from the default module init level at all, I'd say.
> 
> On imx6qdl-sabreauto board, there are 3 MAX7310 units as IO expanders to
> output 3 x 8 = 24 GPIOs.  18 of them are used for resets, enables and
> pin steering for various peripherals on the board.
> 
>   BACKLITE_ON
>   SAT_SHUTDN_B
>   CPU_PER_RST_B
>   MAIN_PER_RST_B
>   IPOD_RST_B
>   MLB_RST_B
>   SSI_STEERING
>   GPS_RST_B
>   
>   GPS_PWREN
>   VIDEO_ADC_PWRDN_B
>   ENET_CAN1_STEER
>   EIMD30_BTUART3_STEER
>   CAN_STBY
>   CAN_EN
>   USB_H1_PWR
>   
>   USB_OTG_PWR_ON
>   SAT_RST_B
>   NAND_BT_WIFI_STEER
> 
> Most of these GPIOs need to set up properly at client device driver's
> probe stage - module_init() time.  So if we have all these service
> providers resets/enables/steering API registered at module_init() too,
> the probes of all these client device drivers stand a good chance to be
> deferred.

That sounds like it /could/ well be an issue. Do you have all that
actually hooked up through device tree so you can demonstrate the amount
of deferred probing that /actually/ happens though?

In order to push the probe order in the right direction, I would
personally prefer to see some kind of explicit hinting or outright
representation of probe order in the DT.

If we fiddle with initcall levels to do this, (a) it won't always work;
what may be optimal for one board/SoC may not be optimal for another,
and with multi-platform kernels, we have to take a broader view, (b) the
only beneficiary is Linux; if we add information to DT for this, every
OS could benefit in the same way.

My view is that when one HW object depends on another (e.g. it's reset
by some other module, sends an interrupt to another module, is affected
by a pin controller module, etc.), that really is a HW issue, and hence
is appropriate to represent in device tree.

In fact, we already do represent the dependencies in device tree; e.g. a
foo-gpios/foo-reset/... property already indicates this. The issue is
that there's no standard naming/structure across all types of DT binding
(GPIO, reset, ...), and hence the only way to parse these dependencies
is to do exactly what deferred probe is doing; try probing each driver,
which then encompasses all device-specific and subsystem-specific naming
and DT structure in its actions, and if it fails, then defer probe.

If we had some explicit information re: dependencies in the DT, in an
entirely standard format, perhaps the device core or similar could parse
this and not even attempt probe until the relevant devices had completed
probe. If the information turned out to be bogus (e.g. loops, missing
drivers), we could always fall back to pure deferred probe later in the
boot sequence.

Or perhaps we should revisit whether DT node order should be defined as
having a guaranteed influence on probe order. We could enforce that the
source order has no influence, but then run a post-processing tool that
finds all the dependencies from the phandles in the DT, and then
re-sorts the DTB to get the probing order right? That would probably
require every single driver to be module_initcall, or to ignore driver
registration order and only probe devices in the order they appear in DT.
