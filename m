From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Jul 2016 09:18:44 +0200
Subject: [PATCH 13/15] ARM: dts: sun8i: Add dt node for rtl8703as wifi
 chip on ga10h
In-Reply-To: <f5f0a0d0-96a8-e9ad-7b4d-b8f19999f0e9@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
 <1467993956-19535-14-git-send-email-hdegoede@redhat.com>
 <20160711063909.GA4589@lukather>
 <f5f0a0d0-96a8-e9ad-7b4d-b8f19999f0e9@redhat.com>
Message-ID: <20160713071844.GB4761@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 02:36:43PM +0200, Hans de Goede wrote:
> >>+&mmc1 {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&mmc1_pins_a>;
> >>+	vmmc-supply = <&reg_dldo1>;
> >>+	bus-width = <4>;
> >>+	non-removable;
> >>+	status = "okay";
> >>+
> >>+	rtl8703as: sdio_wifi at 1 {
> >
> >Shouldn't that need a compatible ?
> 
> There is no upstream driver yet, so no devicetree binding for the specific
> wifi chip used. But all we really need is to follow generic sdio / network
> bindings:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/mmc-card.txt
> 
> Describes how to create a mmc-host child-node describing an (e)mmc-card or
> sdio-function, in this case we are adding a node for sdio-function 1,
> hence the reg = <1>; in the child-node.

Both that file and
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/mmc.txt
list the compatible property as mandatory.

> 
> Linux implementation wise, this will make the mmc core set the dev->of_node
> ptr to this node for the struct device it passes into the sdio-drivers
> probe function.
> 
> And u-boot will add a local-mac-address property as documented here:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet.txt
> 
> to the node pointed to by ethernet%d aliases.
> 
> To actually make use of this I've modified the out of tree driver to check
> for the "local-mac-address" property:
> 
> https://github.com/jwrdegoede/rtl8723bs/commit/be5e87ea71677120ede457213208902ed9942653
> 
> So that each device actually gets a unique address rather then the
> (stupid) behavior of the out of tree driver to set the same fixes
> mac address on every device which does not have a mac address in
> eeprom / nvram.
> 
> Since this follows the existing ethernet bindings standard I
> believe the dts bits can go upstream as is, but since there
> is no upstream-able driver yet, I do not believe that making up
> a compatible string to add to the child-node is a good idea.
> 
> More-over on q8 tablets we will want to do the same (again for
> eeprom / nvram less boards) but without pinning ourselves to
> a specific sdio-wifi module / compatible, instead relying on
> sdio enumeration to figure out which sdio-wifi module is present.

Feel free to raise that issue to the DT maintainers. But this patch
breaks the existing bindings, so it cannot be merged as is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160713/b9fe20fb/attachment.sig>
