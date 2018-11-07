From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Wed, 7 Nov 2018 18:07:42 +0100
Subject: sama5d: using the ebi interface from another driver
In-Reply-To: <3857132.MlRd14rs7I@ada>
References: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
 <3857132.MlRd14rs7I@ada>
Message-ID: <CAL8zT=hWY2FbFbmDm8wAoWO7pCqBiwboULE4-VVJ2m=5n2AaVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there !

Le mar. 6 nov. 2018 ? 10:57, Alexander Dahl <ada@thorsis.com> a ?crit :
>
> Hei hei,
>
> Am Freitag, 2. November 2018, 14:35:26 CET schrieb Jean-Michel Hautbois:
> > Then, after looking into deeper details in the datasheet I understand
> > it is connected through EBI and it sounds not so easy :D.
>
> Did you read docs on that? You'll find the binding docs here:
>
> Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
>
> > I would appreciate some help/pointers on this, as there is (at least,
> > I could find) few documentation on how to use it except for NAND
> > cases.
>
> I use EBI with at91sam9g20 and custom FPGA on CS5 (0x6000000) and CS7
> (0x8000000).
>
> > I have something like that in my DTS, but not sure this is the correct
> > way to do it :
> >
> >         ebi: ebi at 10000000 {
> >             pinctrl-0 = <&pinctrl_ebi_nand_addr>;
> >             pinctrl-names = "default";
> >             status = "okay";
> >
> >             dsp0: pef24628 at 1 {
> >                 status = "okay";
> >                 compatible = "intel,pef24628";
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 reg = <0x1 0x0 0x8000>;
> >                 pinctrl-0 = <&pinctrl_dsp_cs1>;
> >             };
> >
> >             dsp1: pef24628 at 2 {
> >                 status = "okay";
> >                 compatible = "intel,pef24628";
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 reg = <0x2 0x0 0x8000>;
> >                 pinctrl-0 = <&pinctrl_dsp_cs2>;
> >             };
>
> I'm not sure about those 'reg' settings. IIRC the first should correspond to
> the CS line, on at91sam9g20 the 0x40000000 would be CS3 (which is used by
> NAND, like in the dts snippet you posted) and 0x50000000 would be CS4. Are CS1
> (which is used by SD-RAM) and CS2 free to use on sama5d3?
>
> Maybe that's different on sama5d3? I would check it again.

Well, yes, I am using CS1 and 2, and right now, I can confirm the reg
settings are ok as the platform_get_resource returns the correct
values :) !

> > The pinctrl for ebi should probably be changed however, I am wondering
> > how the (platform ?) driver can access the adress ? Should it parse
> > itself the parent, and find range, etc. Or is there an accessor for it
> > ?
>
> Probably. This is what I have for the at91sam9g20:
>
>             pinctrl at fffff400 {
>                 ebi {
>                     pinctrl_ebi_cs5: ebi-cs5-0 {
>                         atmel,pins =
>                             <AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
>                     };
>
>                     pinctrl_ebi_cs7: ebi-cs7-0 {
>                         atmel,pins =
>                             <AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
>                     };
>
>                     pinctrl_ebi_nwait: ebi-nwait-0 {
>                         atmel,pins =
>                             <AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
>                     };
>                 };
>             };
>
> > Maybe can I just manually toggle the CS GPIO, and don't try to make
> > anything more complex than what it should be ? The driver should not
> > be atmel dependant...
>
> As Ludovic said, you should check the settings and timings for the external
> memory interface. This could look more or less similar to that:
>
>             foo_bar: foo-bar at 5,0 {
>                 status = "okay";
>                 pinctrl-0 = <&pinctrl_ebi_cs5>;
>                 pinctrl-names = "default";
>                 reg = <0x5 0x0 0x80000>;
>
>                 atmel,smc-bus-width = <8>;
>                 atmel,smc-read-mode = "nrd";
>                 atmel,smc-write-mode = "nwe";
>                 atmel,smc-exnw-mode = "ready";
>
>                 atmel,smc-ncs-rd-setup-ns = <7>;
>                 atmel,smc-nrd-setup-ns = <7>;
>                 atmel,smc-ncs-wr-setup-ns = <7>;
>                 atmel,smc-nwe-setup-ns = <7>;
>
>                 atmel,smc-ncs-rd-pulse-ns = <56>;
>                 atmel,smc-nrd-pulse-ns = <56>;
>                 atmel,smc-ncs-wr-pulse-ns = <56>;
>                 atmel,smc-nwe-pulse-ns = <56>;
>
>                 atmel,smc-nwe-cycle-ns = <77>;
>                 atmel,smc-nrd-cycle-ns = <77>;
>
>                 atmel,smc-tdf-ns = <0>;
>             };
>
> As you can see, quite a lot of settings are made, all depending on how the
> memory access is supposed to be configured. You should look out for details in
> the hardware manuals of the SoC and the devices you want to connect.

Yes, this is the last part I need to get information about, but this
is datasheet reading basically, so not a big deal :).
Thanks to both of you, Alexander and Ludovic, I have now something
really better ;).

JM
