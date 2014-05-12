From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 May 2014 10:38:12 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140509155504.GE17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com> <536C8293.4070506@ti.com>
 <20140509155504.GE17814@atomide.com>
Message-ID: <53707A64.2060203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 18:55, Tony Lindgren wrote:

>> Although if the MO gpio is not controlled by the driver, we should tell
>> the driver whether that gpio is high or low.
> 
> What do you have in mind for telling that? We should also tell the
> orientation of the panel:
> 
> EVM	VGA	omapfb.rotate=3
> LDP	QVGA	omapfb.rotate=0
> 
> Do you have something in mind for that?

Hmm, right. I guess all we can do is have boolean flags in the .dts for
MO, LR and UD, which tells if the respective pins are hard-wires high or
low. And say in the documentation that you must either have a proper
GPIO, or use the flag, but not both.

The panel mounting orientation is a different matter. But I think it is
also something we should specify in the .dts. However, we don't have any
SW support to handle it, and it's a bit unclear to me how it should be
handled, so I think that has to be left for later.

>> At the moment our display drivers are OMAP specific, and for that reason
>> we should prefix the compatible strings with "omapdss,". For example,
>> drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:
>>
>> 	{ .compatible = "omapdss,panel-dsi-cm", },
>>
>> But we should still have the right compatible string in the .dts, so we
>> convert the compatible name in arch/arm/mach-omap2/display.c, with
>> 'dss_compat_conv_list' array, to which this panel's name should be added.
> 
> Oh so what do you want to have in the .dts file then?

The .dts should have the proper names. The idea of this hackery is that
in the .dts we can have the proper compatible string. So in the .dts, we
have, say:

"sony,panel-foobar"

Then, at boot time, omap's platform code changes that to:

"omapdss,sony,panel-foobar".

And our (omap specific) panel-foobar driver use that
"omapdss,sony,panel-foobar" string.

This way some other platform could do the same, and have their platform
specific drivers handle the panel.

At some point in the future we hopefully will have common panel drivers,
and at that point we can remove that hackery. The .dts files will
already be correct.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/25e424e0/attachment.sig>
