From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 29 Jul 2015 15:38:12 +0100
Subject: [PATCH v2] dtb: Create a common home for cross-architecture
 dtsi files.
In-Reply-To: <20150729132758.GR15213@leverpostej>
References: <1437993343-9542-1-git-send-email-ian.campbell@citrix.com>
 <CAK7LNAQKswPzeFYdSVq3JDk2qawZ8e5ogBFMWdor-CibMovU3g@mail.gmail.com>
 <1438176174.11600.198.camel@citrix.com>
 <20150729132758.GR15213@leverpostej>
Message-ID: <1438180692.11600.206.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-07-29 at 14:27 +0100, Mark Rutland wrote:
> On Wed, Jul 29, 2015 at 02:22:54PM +0100, Ian Campbell wrote:
> > On Wed, 2015-07-29 at 20:07 +0900, Masahiro Yamada wrote:
> > > Hi Ian,
> > > 
> > > 
> > > 2015-07-27 19:35 GMT+09:00 Ian Campbell <ian.campbell@citrix.com>:
> > > > Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 
> > > > on
> > > > LogicTile Express 20MG" added a new dts file to arch/arm64 which
> > > > included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> > > > .dtsi supplied by arch/arm.
> > > > 
> > > > Unfortunately this causes some issues for the split device tree
> > > > repository[0], since things get moved around there. In that context
> > > > the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> > > > while the include is at src/arm/vexpress-v2m-rs1.dtsi.
> > > > 
> > > > The sharing of the .dtsi is legitimate since the baseboard is the 
> > > > same
> > > > for various vexpress systems whatever processor they use.
> > > > 
> > > > Rather than using ../../ tricks to pickup .dtsi files from another
> > > > arch this patch creates a new directory include/dt-dtsi as a
> > > > home for such cross-arch .dtsi files, arranges for it to be in the
> > > > include path when the .dts files are processed by cpp and switches 
> > > > the
> > > 
> > > 
> > > "include/dt-dtsi/"  can be referenced from normal C sources.
> > > 
> > > I think another possible home for cross-arch DTSI is "kernel/dts/".
> > > This directory can be hidden from C sources.
> > 
> > I suppose, I don't really mind and will follow the direction of the 
> > other
> > DTB maintainers. It doesn't seem like a big deal to me.
> 
> I don't really have a preference either way.

I'm inclined to leave it, "visible to C sources" doesn't seem like that
much of an issue and IMHO the cure (kernel/dts/...) is worse than the
disease.

@@ -223,7 +223,7 @@ Example of a VE tile description (simplified)
> > > >                 /* Active high IRQ 0 is connected to GIC's SPI0 */
> > > >                 interrupt-map = <0 0 0 &gic 0 0 4>;
> > > > 
> > > > -               /include/ "vexpress-v2m-rs1.dtsi"
> > > > +               #include <arm/vexpress-v2m-rs1.dtsi>
> > > >         };
> > > >  };
> > > 
> > > 
> > > 
> > > You do not have to replace /include/ with #include,
> > > if you add the include path for DTC.
> > 
> > Ah, I looked for this but -i is not documented in the man page.
> > 
> > Is there any reason to prefer one over the other?
> 
> #include allows you to use CPP in the file you're including, /include/
> does not.
> 
> I would imagine we have to use #include in case the dtsi itself has
> #include statements...

If it did, yes. I don't think vexpress-v2m-rs1.dtsi does, since it is using
/include/ today. I'm inclined to switch back to /include/ unless someone
objects.

> > > Please add include path for DTC too
> > > so that both /include/ and #include are available.
> 
> ... though that does not preclude adding it to the path for /include/.

Indeed, I've done that locally already.

Ian.
