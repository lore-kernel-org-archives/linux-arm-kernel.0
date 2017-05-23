From: jacopo@jmondi.org (jmondi)
Date: Tue, 23 May 2017 20:49:09 +0200
Subject: [PATCH] arm: dts: r7s72100: Add support for GR-Peach
In-Reply-To: <CAMuHMdUR0Djqi-7DWAHpN_F6xt-WcYzT4H2+mLCjHE9T+7UuJg@mail.gmail.com>
References: <1495532834-25670-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUR0Djqi-7DWAHpN_F6xt-WcYzT4H2+mLCjHE9T+7UuJg@mail.gmail.com>
Message-ID: <20170523184909.GD13664@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, May 23, 2017 at 12:08:30PM +0200, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Tue, May 23, 2017 at 11:47 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add device tree source for Renesas GR-Peach board.
> > GR-Peach is an RZ/A1H based board with 10MB of on-chip SRAM and 8MB
> > QSPI flash storage.
> > Add support for the board, and create a 2MB partition to use as rootfs.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -51,6 +51,8 @@ Boards:
> >      compatible = "renesas,bockw", "renesas,r8a7778"
> >    - Genmai (RTK772100BC00000BR)
> >      compatible = "renesas,genmai", "renesas,r7s72100"
> > +  - GR-Peach (RTK772100BC00000BR)
>
> That part number is Genmai?

Oh, I thought that was the SoC part number, and being both based on
RZ/A1H, I used the same.

Where can I find the correct part number?

>
> > +    compatible = "renesas,grpeach", "renesas,r7s72100"
>
> "renesas,gr-peach"?

Let's use gr-peach in place of grpeach everywhere then.

>
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -716,6 +716,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
> >  dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
> >         emev2-kzm9d.dtb \
> >         r7s72100-genmai.dtb \
> > +       r7s72100-grpeach.dtb \
>
> r7s72100-gr-peach.dtb?
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r7s72100-grpeach.dts
>
> r7s72100-gr-peach.dts
>
> > @@ -0,0 +1,65 @@
> > +/*
> > + * Device Tree Source for the GRPEACH board
>
> GR-PEACH
>
> > +/ {
> > +       model = "GRPEACH";
>
> GR-PEACH
>
> > +       compatible = "renesas,grpeach", "renesas,r7s72100";
>
> renesas,gr-peach
>
> > +
> > +       aliases {
> > +               serial2 = &scif2;
>
> The first serial port is supposed to be called serial0, unless labeled
> otherwise.

I assumed it had to match the SCIF number. Will change.

>
> > +       };
> > +
> > +       chosen {
> > +               bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/mtdblock0";
>
> bootargs = "ignore_loglevel rw root=/dev/mtdblock0";
> stdout-path = "serial0:115200n8";
>
> > +       memory {
>
> memory at 20000000
>
> (please run "make dtbs W=1")
>
> > +               device_type = "memory";
> > +               reg = <0x20000000 0x00A00000>;  /* 10Mb @ 0x20000000 */
>
> reg = <0x20000000 0x00a00000>;
>
> No need for the comment, esp. since it says 10 megabits instead of
> 10 mebibyte ;-)

Was I the only one that had to go on Wikipedia to find out what a
mebibyte is :p ?

I'll drop comments here and in the rest of the patch.

>
> > +       qspi at 18000000 {
>
> flash at 18000000?
>
> > +               compatible = "mtd-rom";
> > +               probe-type = "map_rom";
> > +               reg = <0x18000000 0x00800000>;   /* 8 MB*/
>
> No need for the comment (megabyte vs. mebibyte)
>
> > +               bank-width = <4>;
> > +               device-width = <1>;
> > +
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +
> > +               rootfs at 18600000 {
>
> rootfs at 600000?
>
> > +                       label = "rootfs";
> > +                       reg = <0x00600000 0x00200000>; /* 2MB @ 0x18600000 */
>
> Do we need the comment?
>
> > +&extal_clk {
> > +       clock-frequency = <13330000>;
>
> My schematics have one more digit of precision: <13333000>

Thanks, I'll change this.

Do we need to change that on Genmai as well while at there?
Some parts of its documentation report a frequency of 13.33Mhz, but X1
is listed in the BOM as

X1 XIN oscillator (socket mounted) SG-8002DC-13.3333MHz (Epson)

Thanks
   j
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
