From: jason@lakedaemon.net (Jason)
Date: Thu, 8 Mar 2012 16:55:50 -0500
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120308213139.GC16533@ponder.secretlab.ca>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <80fb8cef577eee14364e95009f7a590fd9056ee3.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
 <20120308213139.GC16533@ponder.secretlab.ca>
Message-ID: <20120308215550.GO5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:31:39PM -0700, Grant Likely wrote:
> On Wed, Mar 07, 2012 at 02:27:23PM -0500, Jason wrote:
> > On Wed, Mar 07, 2012 at 06:31:31PM +0000, Arnd Bergmann wrote:
> > > On Wednesday 07 March 2012, Jason Cooper wrote:
> > > > +       serial at f1012000 {
> > > > +               compatible = "ns16550a";
> > > > +               reg = <0xf1012000 0xff>;
> > > > +               reg-shift = <2>;
> > > > +               interrupts = <33>;
> > > > +               clock-frequency = <200000000>;
> > > > +       };
> > > 
> > > I just noticed that the length here should be inclusive, i.e. 0x100 not 0xff.
> > > This is different from the way we define resources in Linux.
> > 
> > Grrr.  Now I'm getting frustrated.  I'm trying to boot without
> > earlyprintk.  Evidently, something is wrong with the above, because the
> > device boots all the way up (blinky lights come on), but I get no
> > messages after the usual "Uncompressing Linux... done, booting the
> > kernel."
> > 
> > Here's my most recent attempt:
> > 
> 
> I see that you've resolved your problem, but some comments below on the
> device node:
> 
> >         serial at f1012000 {
> >                 device_type = "serial";
> 
> Never use device_type.  It should only ever appear in the memory node, and
> I plan to remove it from there too.
> 
> >                 compatible = "ns16550a";
> >                 reg = <0xf1012000 0x100>; /*phys addr*/
> >                 virt-reg = <0xfed12000>;  /*virt addr*/
> 
> Don't use virt-reg.  Nothing in the kernel uses it and the kernel will
> make it's own decision about virtual address mapping.
> 
> >                 reg-shift = <2>;
> >                 reg-io-width = <1>;
> 
> 1 is the default for reg-io-width.  No need to have this property.  It
> should only be used if the device requires 32 bit accesses.
> 
> >                 interrupts = <33>;
> >                 current-speed = <115200>;
> >                 interrupt-parent = <&intc>;
> >                 clock-frequency = <200000000>;
> >         };

Thanks, Grant.  I reverted all of those changes once I found the root of
my problem.

thx,

Jason.
