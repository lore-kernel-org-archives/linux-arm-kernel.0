From: jason@lakedaemon.net (Jason)
Date: Wed, 7 Mar 2012 14:27:23 -0500
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201203071831.31738.arnd@arndb.de>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <80fb8cef577eee14364e95009f7a590fd9056ee3.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
Message-ID: <20120307192723.GE5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 06:31:31PM +0000, Arnd Bergmann wrote:
> On Wednesday 07 March 2012, Jason Cooper wrote:
> > +       serial at f1012000 {
> > +               compatible = "ns16550a";
> > +               reg = <0xf1012000 0xff>;
> > +               reg-shift = <2>;
> > +               interrupts = <33>;
> > +               clock-frequency = <200000000>;
> > +       };
> 
> I just noticed that the length here should be inclusive, i.e. 0x100 not 0xff.
> This is different from the way we define resources in Linux.

Grrr.  Now I'm getting frustrated.  I'm trying to boot without
earlyprintk.  Evidently, something is wrong with the above, because the
device boots all the way up (blinky lights come on), but I get no
messages after the usual "Uncompressing Linux... done, booting the
kernel."

Here's my most recent attempt:

        serial at f1012000 {
                device_type = "serial";
                compatible = "ns16550a";
                reg = <0xf1012000 0x100>; /*phys addr*/
                virt-reg = <0xfed12000>;  /*virt addr*/
                reg-shift = <2>;
                reg-io-width = <1>;
                interrupts = <33>;
                current-speed = <115200>;
                interrupt-parent = <&intc>;
                clock-frequency = <200000000>;
        };

I've looked at what is done in the powerpc dt's, but, no luck.  When
earlyprintk is enabled, I see no error messages, just:

bootconsole [earlycon0] enabled
debug: skip boot console de-registration.
...
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled

Any pointers?

thx,

Jason.
