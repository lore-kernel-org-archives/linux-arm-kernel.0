From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 15:14:04 +0200
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <531087C0.1090501@gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <531087C0.1090501@gmail.com>
Message-ID: <53108B9C.5000006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 14:57, Sebastian Hesselbarth wrote:

> Out of curiosity, will there be DT nodes for pull-up resistors soon,
> too? ;)

If they don't work automatically, yes, we need DT nodes and drivers for
them.

> Honestly, TPD12S015 is a level shifter, there is nothing in it that
> would justify a DT node nor a driver.

TPD requires a power. Who turns that on? It also has two GPIOs, LS_OE
and CT_CP_HPD, which need to be controlled based on what the user wants
and the state of the HPD line. Who controls those?

> Above you already note, that connector nodes should offer HPD in the
> future, but I guess the binding should represent that now already.

I think it can be added when somebody uses it. I don't see why that
would cause trouble later to those that don't use it.

> I will be a DT stub anyway, the corresponding video sink driver will
> have to look it up.

I'm not sure what you mean with that. Yes, it's not the most complex DT
nodes out there.

> Looking through the bindings for DVI and HDMI, I guess HPD gpio is
> better kept in those nodes. From the relevant (DT) properties DVI and
> HDMI connectors are in no way different.

Well, I think the HPD gpio should be where it's most logical to have it.

I mean, you could have a setup where you have the SoC HDMI encoder and
and the HDMI connector, and the HPD pin goes directly to the HDMI
encoder, which has HW support for it. In that case, the HDMI encoder
node should contain the HPD, and the HDMI encoder should handle it.

Or, your HDMI encoder could not have any kind of support for HPD. In
that case you could have the HDMI connector driver handle the hotplug
event. You could of course make the HDMI encoder driver handle the HPD
gpio, but I usually try to have the driver handle the hardware device in
question.

In OMAP's case, we have the TPD chip between the HDMI encoder and the
connector, and the logical place to handle HPD GPIO in that case is the
TPD driver, as that's where the HPD is connected to and the TPD needs to
be configured according to the state of the HPD.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/60e99aeb/attachment.sig>
