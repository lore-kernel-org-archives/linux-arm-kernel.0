From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Mon, 28 Nov 2016 16:44:47 +0100
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: Add 88E6176 device tree support
In-Reply-To: <20161128131735.GA4379@lunn.ch>
References: <1480280279-9552-1-git-send-email-afaerber@suse.de>
 <1480280279-9552-2-git-send-email-afaerber@suse.de>
 <20161127212709.GD13318@lunn.ch>
 <9500470d-09c3-3ecb-994b-3d108bffc99e@suse.de>
 <20161127220846.GH13318@lunn.ch>
 <e5d45b55-a4c1-3b5e-0bdc-a5e340b072d0@suse.de>
 <20161127231009.GA17704@lunn.ch>
 <20161128080939.ippqlytvojitefkp@perseus.defre.kleine-koenig.org>
 <20161128131735.GA4379@lunn.ch>
Message-ID: <2c59cc79-b6dc-9920-1725-a7785ff3b6bf@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2016 02:17 PM, Andrew Lunn wrote:
>> I still wonder (and didn't get an answer back when I asked about this)
>> why a comment is preferred here. For other devices I know it's usual and
>> requested by the maintainers to use:
>>
>> 	compatible = "exact name", "earlyer device to match driver";
>>
>> . This is more robust, documents the situation more formally and makes
>> it better greppable. The price to pay is only a few bytes in the dtb
>> which IMO is ok.
> 
> We did discuss this a while back. The information is useless and
> should to be ignored if present.

Who is "we"?

> The switch has a register which contains its model and revision. Each
> port has a set of registers, and register 3 contains the
> model/version. For all devices compatible with the 6085, the port
> registers start at address 0x10. For the 6190, the port registers
> start at 0x0. So given one of these two compatible strings, we can
> find the model of the device, from something which is burned into the
> silicon.
> 
> Now, say we did add per device compatible strings. We look up the
> model burned into the silicon, find it is different to what the device
> tree is and do what? Fail the probe? Or just keep going using the

I'd say fail to probe is the right thing to do. Of course that doesn't
work for already supported models because it will break compatibility.

I'd value the advantages (i.e. easily find machines with a given
hardware) higher than making broken dtbs work, so being a bit silly is
fine for me.

> value in the silicon? It seems silly to fail the probe if the driver
> does support the model, but that means the device tree is never
> verified and hence probably wrong. Why have wrong information in the
> device tree, especially wrong information which we never use. It is
> better to not have that information in the device tree.

At least we'd have a canonical way to specify the type of switch. If
it's not verified it's as good and bad as a dts comment. But the latter
isn't available in the dtb, which I consider a small disadvantage.

Also it seems wrong to write "marvell,mv88e6085" (only) if I know the
hardware is really a "marvell,mv88e6176".

> Linus has said he does not like ARM devices because of all the busses
> which are not enumerable. Here we have a device which with a little
> bit of help we can enumerate. So we should. 

If you write

	compatible = "marvell,mv88e6176", "marvell,mv88e6085";

you can still enumerate in the same way as before.

There are several more instances where the device tree specifies
something that could be probed instead. Some examples:

	compatible = "ethernet-phy-id0141.0DD1", "ethernet-phy-ieee802.3-c22";
	compatible = "spansion,s25fl164k", "jedec,spi-nor";
	compatible = "fsl,imx25-flexcan", "fsl,p1010-flexcan";
	compatible = "arm,pl011", "arm,primecell";

So you think they are all doing it wrong?

Best regards
Uwe


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/42269bc2/attachment.sig>
