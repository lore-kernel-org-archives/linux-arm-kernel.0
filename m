From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 09:46:36 +0100
Subject: [PATCH 1/6] ARM: sunxi: DT: Convert to device tree includes
In-Reply-To: <1992510.V86iv1hrWK@wuerfel>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
 <2559984.DiBeGaGfHy@wuerfel> <20141217213358.GR4337@lukather>
 <1992510.V86iv1hrWK@wuerfel>
Message-ID: <20141219084636.GC4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 11:33:27PM +0100, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 22:33:58 Maxime Ripard wrote:
> > Hi Arnd,
> > 
> > On Wed, Dec 17, 2014 at 08:32:01AM +0100, Arnd Bergmann wrote:
> > > On Tuesday 16 December 2014 22:59:54 Maxime Ripard wrote:
> > > > Prepare the device trees to use the C preprocessor.
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > 
> > > Hi Maxime,
> > > 
> > > Since you are doing a number of changes to all the sunxi files, I have
> > > one more request for something that has been bugging me a while:
> > > 
> > > In your .dtsi files, you define devices like this:
> > > 
> > >                 uart0: serial at 01c28000 {
> > >                         compatible = "snps,dw-apb-uart";
> > >                         reg = <0x01c28000 0x400>;
> > >                         interrupts = <0 1 4>;
> > >                         reg-shift = <2>;
> > >                         reg-io-width = <4>;
> > >                         clocks = <&apb1_gates 16>;
> > >                         status = "disabled";
> > >                 };
> > > 
> > > and in the .dts files, you extend them like this:
> > > 
> > >                 uart0: serial at 01c28000 {
> > >                         pinctrl-names = "default";
> > >                         pinctrl-0 = <&uart0_pins_a>;
> > >                         status = "okay";
> > >                 };
> > > 
> > > 
> > > which duplicates both the node names with their full path, and
> > > the labels. Please use one or the other, but not both. I don't mind
> > > you having the full path to each device in the dts files, just drop
> > > all the labels in that case.
> > 
> > I don't know, maybe it's just a matter of personnal taste, but I do
> > find convenient to have the labels in the DTS as well, so that
> > whenever you need to use a label (for a phandle for example), you
> > don't have to lookup in the DTSI if you have the node in the DTS.
> 
> But the redundancy seems overly redundant and unnecessary ;-)
> 
> What you describe will only work for nodes you already list in the
> dts file, not for those that are left untouched.
> 
> As far as I can tell, almost all phandle references you have are either
> pointing to devices you never define in a dts file, or those you never
> define in a dtsi file:
> 
> git grep \& arch/arm/boot/dts/sun*.dts | cut -f 2 -d\& | cut -f 1 -d\  | cut -f 1 -d \> | sort -u | while read i ; do echo  ` git grep -w $i: arch/arm/boot/dts/sun*.dts  | wc -l` ` git grep -w $i: arch/arm/boot/dts/sun*.dtsi  | wc -l` $i ; done

Indeed, there's some minor exceptions, mostly for the pinctrl nodes
when we want to change the drive strength or pullup/pulldown
configuration of a pinctrl node already defined in the DTSI. IR and
MMC pins are in this case.


> > > Most other maintainers these days just use the labels like this in
> > > the dts files however:
> > > 
> > > &uart0 {
> > > 	status = "okay";
> > > };
> > > 
> > > which also seems completely fine.
> > 
> > If that's the current trend, I'll add that to my todo-list, but I
> > believe it's orthogonal to these patches.
> 
> It's orthogonal, I'm just mentioning it because it makes me cringe
> whenever I look at these files, and because you already touch
> almost every device in your dts files, so you will have to deal with
> merge conflicts already, and it's better to do it all at once.

Okay, I'll come up with a patch to modify that then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/72fd2e78/attachment-0001.sig>
