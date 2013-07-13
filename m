From: dsd@laptop.org (Daniel Drake)
Date: Sat, 13 Jul 2013 08:25:15 -0600
Subject: DT binding review for Armada display subsystem
In-Reply-To: <20130713103516.38a55b0b@armhf>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
 <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
 <20130713103516.38a55b0b@armhf>
Message-ID: <CAMLZHHSrX2T+pU3RosmjS3EggV3mX_J8D2OJD52sww_n6Y7B+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 13, 2013 at 2:35 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> I use my Cubox for daily jobs as a desktop computer. My kernel is a DT
> driven 3.10.0. The dove-drm, tda998x and si5351 (clock) are kernel
> modules. I set 3 clocks in the DT for the LCD0: lcdclk, axi and extclk0
> (si5351). Normally, the external clock is used, but, sometimes, the
> si5351 module is not yet initialized when the drm driver starts. So,
> for 1920x1080p, it uses the lcdclk which sets the LCD clock to 133333
> (400000/3) instead of 148500. As a result, display and sound still work
> correctly on my TV set thru HDMI.
>
> So, it would be nice to have 2 usable clocks per LCD, until we find a
> good way to initialize the modules in the right order at startup time.

Having multiple usable clocks is implemented in the patch I referred
you to. However it doesn't solve the "better clock turns up after
initializing the driver" problem, which seems like a tricky one.

Maybe the best solution is to defer probe until all DT-defined clocks
become available. That means that whoever compiles the kernel must
take care to not forget to build the clock drivers for all the clocks
referenced in this part of the DT, but perhaps that is a reasonable
thing to require.

On the other hand, this problem acts in support of a simpler approach
mentioned by Sebastian: developers figure out what the best clock is
for each CRTC on each board, and the DT only specifies that one clock.
The driver uses that clock if it is available and defers probe if it
is not.

> Back to the specific case of the Cubox with new ideas.
>
> The Cubox is based on the Armada 510 (Dove), so, all the hardware must
> be described in dove.dtsi. This includes the LCDs and DCON/IRE, the
> possible clocks and the (static) v4l2 links:

As a sidenote, I think we have concluded that we are not going to
interact with the armada 510 DCON in any way at the moment. The driver
will not have code that touches it, and the DT will not mention it.
The first person who actually needs to use the DCON will have the
responsibility for doing that work. Nevertheless it makes sense for us
to pick a DT design where we know that the DCON could be slotted in
later.

>         lcd0: lcd-controller at 820000 {
>                 compatible = "marvell,dove-lcd0";
>                 reg = <0x820000 0x1c8>;
>                 interrupts = <47>;
>                 clocks = <&core_clk 3>, <&lcdclk>;
>                 clock-names = "axi", "lcdclk";
>                 marvell-output = <&dcon 0>;
>                 status = "disabled";
>         };
>
>         lcd1: lcd-controller at 810000 {
>                 compatible = "marvell,dove-lcd1";
>                 reg = <0x810000 0x1c8>;
>                 interrupts = <46>;
>                 clocks = <&core_clk 3>, <&lcdclk>;
>                 clock-names = "axi", "lcdclk";
>                 marvell-output = <&dcon 1>;
>                 status = "disabled";
>         };
>
>         /* display controller and image rotation engine */
>         dcon: display-controller at 830000 {
>                 compatible = "marvell,dove-dcon";
>                 reg = <0x830000 0xc4>,                  /* DCON */
>                       <0x831000 0x8c>;                  /* IRE */
>                 interrupts = <45>;
>                 marvell-input = <&lcd0>, <&lcd1>;
>                 status = "disabled";
>         };

I guess the IRE falls into the same category as the DCON - we won't
implement it for now, but knowing where it might fit in is useful.

Why would you put it in the same node as the DCON though? It has its
own separate register space and additionally it is a component shared
with the MMP boards (whereas the DCON is not).

> The specific Cubox hardware (tda998x and si5351) is described in
> dove-cubox.dts, with the new clocks and the v4l2 link dcon0 <--> tda998x.
>
>         &i2c0 {
>                 si5351: clock-generator {
>                         ...
>                 };
>                 tda998x: hdmi-encoder {
>                         compatible = "nxp,tda998x";
>                         reg = <0x70>;
>                         interrupt-parent = <&gpio0>;
>                         interrupts = <27 2>;            /* falling edge */
>                         marvell-input = <&dcon 0>;
>                 };
>         };
>         &lcd0 {
>                 status = "okay";
>                 clocks = <&si5351 0>;
>                 clock-names = "extclk0";
>         };
>         &dcon {
>                 status = "okay";
>                 marvell-output = <&tda998x>, 0;         /* no connector on port B */
>         };

So now you are taking an approach equivalent to the v4l2 standard
"video interfaces" binding, which is the concept of representing a
connection graph via phandles. This means that our two proposals are
equivalent yet I proposed using a standard interface and you proposed
inventing your own, again without explaining why you don't like the
standard interface.

> Then, about the software, the drm driver may not need to know anything
> more (it scans the DT for the LCDs and gets all the subdevices thanks
> to the v4l2 links):
>
>         video {
>                 compatible = "marvell,armada-video";
>         };
>
> For some boards / other SoCs, there may be independant drm devices. In
> this case, there would be descriptions as:
>
>         video0 {
>                 compatible = "marvell,armada-video0";
>                 marvell,video-devices = <&lcd0>;
>         };
>         video1 {
>                 compatible = "marvell,armada-video1";
>                 marvell,video-devices = <&lcd1>;
>         };

This bit differs from my proposal, but I'm not sure what the benefit
of your design is. In my design, the two above use cases are
represented cleanly using the same DT abstraction (same compatible
string, same required properties, etc). In your design, the two use
cases call for something quite different as shown above.

Daniel
