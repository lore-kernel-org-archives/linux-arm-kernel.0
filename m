From: michael@walle.cc (Michael Walle)
Date: Wed, 7 Mar 2012 22:47:09 +0100
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120307192723.GE5050@titan.lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
Message-ID: <201203072247.10065.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 07 M?rz 2012, 20:27:23 schrieb Jason:
> On Wed, Mar 07, 2012 at 06:31:31PM +0000, Arnd Bergmann wrote:
> > On Wednesday 07 March 2012, Jason Cooper wrote:
> > > +       serial at f1012000 {
> > > +               compatible = "ns16550a";
> > > +               reg = <0xf1012000 0xff>;
> > > +               reg-shift = <2>;
> > > +               interrupts = <33>;
> > > +               clock-frequency = <200000000>;
> > > +       };
> > 
> > I just noticed that the length here should be inclusive, i.e. 0x100 not
> > 0xff. This is different from the way we define resources in Linux.
> 
> Grrr.  Now I'm getting frustrated.  I'm trying to boot without
> earlyprintk.  Evidently, something is wrong with the above, because the
> device boots all the way up (blinky lights come on), but I get no
> messages after the usual "Uncompressing Linux... done, booting the
> kernel."
> 
> Here's my most recent attempt:
> 
>         serial at f1012000 {
>                 device_type = "serial";
>                 compatible = "ns16550a";
>                 reg = <0xf1012000 0x100>; /*phys addr*/
>                 virt-reg = <0xfed12000>;  /*virt addr*/
>                 reg-shift = <2>;
>                 reg-io-width = <1>;
>                 interrupts = <33>;
>                 current-speed = <115200>;
>                 interrupt-parent = <&intc>;
>                 clock-frequency = <200000000>;
>         };
> 
> I've looked at what is done in the powerpc dt's, but, no luck.  When
> earlyprintk is enabled, I see no error messages, just:
> 
> bootconsole [earlycon0] enabled
> debug: skip boot console de-registration.
> ...
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> 
> Any pointers?

dunno if that helps a lot but the following was working for me with my 
linkstation:

        serial0: serial at f1012000 {
                cell-index = <0>;
                device_type = "serial";
                compatible = "ns16550a";
                reg = <0xf1012000 0x20>;
                reg-shift = <2>;
                clock-frequency = <200000000>;
                interrupts = <33>;
        };

-- 
michael
