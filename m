From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 23:33:27 +0100
Subject: [PATCH 1/6] ARM: sunxi: DT: Convert to device tree includes
In-Reply-To: <20141217213358.GR4337@lukather>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
 <2559984.DiBeGaGfHy@wuerfel> <20141217213358.GR4337@lukather>
Message-ID: <1992510.V86iv1hrWK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 22:33:58 Maxime Ripard wrote:
> Hi Arnd,
> 
> On Wed, Dec 17, 2014 at 08:32:01AM +0100, Arnd Bergmann wrote:
> > On Tuesday 16 December 2014 22:59:54 Maxime Ripard wrote:
> > > Prepare the device trees to use the C preprocessor.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > Hi Maxime,
> > 
> > Since you are doing a number of changes to all the sunxi files, I have
> > one more request for something that has been bugging me a while:
> > 
> > In your .dtsi files, you define devices like this:
> > 
> >                 uart0: serial at 01c28000 {
> >                         compatible = "snps,dw-apb-uart";
> >                         reg = <0x01c28000 0x400>;
> >                         interrupts = <0 1 4>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> >                         clocks = <&apb1_gates 16>;
> >                         status = "disabled";
> >                 };
> > 
> > and in the .dts files, you extend them like this:
> > 
> >                 uart0: serial at 01c28000 {
> >                         pinctrl-names = "default";
> >                         pinctrl-0 = <&uart0_pins_a>;
> >                         status = "okay";
> >                 };
> > 
> > 
> > which duplicates both the node names with their full path, and
> > the labels. Please use one or the other, but not both. I don't mind
> > you having the full path to each device in the dts files, just drop
> > all the labels in that case.
> 
> I don't know, maybe it's just a matter of personnal taste, but I do
> find convenient to have the labels in the DTS as well, so that
> whenever you need to use a label (for a phandle for example), you
> don't have to lookup in the DTSI if you have the node in the DTS.

But the redundancy seems overly redundant and unnecessary ;-)

What you describe will only work for nodes you already list in the
dts file, not for those that are left untouched.

As far as I can tell, almost all phandle references you have are either
pointing to devices you never define in a dts file, or those you never
define in a dtsi file:

git grep \& arch/arm/boot/dts/sun*.dts | cut -f 2 -d\& | cut -f 1 -d\  | cut -f 1 -d \> | sort -u | while read i ; do echo  ` git grep -w $i: arch/arm/boot/dts/sun*.dts  | wc -l` ` git grep -w $i: arch/arm/boot/dts/sun*.dtsi  | wc -l` $i ; done

> > Most other maintainers these days just use the labels like this in
> > the dts files however:
> > 
> > &uart0 {
> > 	status = "okay";
> > };
> > 
> > which also seems completely fine.
> 
> If that's the current trend, I'll add that to my todo-list, but I
> believe it's orthogonal to these patches.

It's orthogonal, I'm just mentioning it because it makes me cringe
whenever I look at these files, and because you already touch
almost every device in your dts files, so you will have to deal with
merge conflicts already, and it's better to do it all at once.

> > I'm also a bit puzzled by all the pinctrl references you add in the .dts
> > files, but it's possible I'm missing something there. Why can't you move
> > these to the .dtsi files and avoid duplicating the pinctrl-0 and
> > pinctrl-names properties for every .dts file? I would assume that they
> > are not referenced for disabled devices.
> 
> The pinctrl nodes we reference are in the DTS. However, each pin of
> each controller is most of the time available on several pins of the
> package, so we don't have any way to enforce a default at the SoC
> level.

Ah, makes sense.

	Arnd
