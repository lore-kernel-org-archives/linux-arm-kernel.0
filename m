From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Nov 2016 14:17:35 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <20161128080939.ippqlytvojitefkp@perseus.defre.kleine-koenig.org>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
 <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
 <20161127220846.GH13318@lunn.ch>
 <e5d45b55-a4c1-3b5e-0bdc-a5e340b072d0@suse.de>
 <20161127231009.GA17704@lunn.ch>
 <20161128080939.ippqlytvojitefkp@perseus.defre.kleine-koenig.org>
Message-ID: <20161128131735.GA4379@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I still wonder (and didn't get an answer back when I asked about this)
> why a comment is preferred here. For other devices I know it's usual and
> requested by the maintainers to use:
> 
> 	compatible = "exact name", "earlyer device to match driver";
> 
> . This is more robust, documents the situation more formally and makes
> it better greppable. The price to pay is only a few bytes in the dtb
> which IMO is ok.

We did discuss this a while back. The information is useless and
should to be ignored if present.

The switch has a register which contains its model and revision. Each
port has a set of registers, and register 3 contains the
model/version. For all devices compatible with the 6085, the port
registers start at address 0x10. For the 6190, the port registers
start at 0x0. So given one of these two compatible strings, we can
find the model of the device, from something which is burned into the
silicon.

Now, say we did add per device compatible strings. We look up the
model burned into the silicon, find it is different to what the device
tree is and do what? Fail the probe? Or just keep going using the
value in the silicon? It seems silly to fail the probe if the driver
does support the model, but that means the device tree is never
verified and hence probably wrong. Why have wrong information in the
device tree, especially wrong information which we never use. It is
better to not have that information in the device tree.

Linus has said he does not like ARM devices because of all the busses
which are not enumerable. Here we have a device which with a little
bit of help we can enumerate. So we should. 

    Andrew
