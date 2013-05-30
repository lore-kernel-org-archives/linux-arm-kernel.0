From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 30 May 2013 07:33:49 +0200 (CEST)
Subject: [PATCH 05/11] ARM: shmobile: APE6EVM LAN9220 support
In-Reply-To: <CAOesGMjLiNTR7cqjSmyy2Ux1srgkC5cPO+D8UsRcgHbW8GQ26Q@mail.gmail.com>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
 <1364954906-16014-6-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1305171458550.31481@axis700.grange>
 <20130522143204.GE32012@verge.net.au>
 <Pine.LNX.4.64.1305221911380.12715@axis700.grange>
 <20130528024540.GC13532@quad.lixom.net>
 <Pine.LNX.4.64.1305290819190.14157@axis700.grange>
 <CAOesGMjLiNTR7cqjSmyy2Ux1srgkC5cPO+D8UsRcgHbW8GQ26Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1305300700150.24272@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Olof Johansson wrote:

> On Tue, May 28, 2013 at 11:26 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Hi Olof
> >
> > On Mon, 27 May 2013, Olof Johansson wrote:
> >
> >> Hi,
> >>
> >> Sorry, a bit behind on email and just discovered this.
> >>
> >> On Wed, May 22, 2013 at 07:22:59PM +0200, Guennadi Liakhovetski wrote:
> >>
> >> > > > The above didn't work in my tests without this:
> >> > > >
> >> > > > diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> >> > > > b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> >> > > > index f603c69..4fb0102 100644
> >> > > > --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> >> > > > +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> >> > > > @@ -33,8 +33,10 @@
> >> > > >         };
> >> > > >
> >> > > >         lbsc {
> >> > > > +               compatible = "simple-bus";
> >> > > >                 #address-cells = <1>;
> >> > > >                 #size-cells = <1>;
> >> > > > +               ranges = <0 0 0 0x80000000>;
> >> > > >
> >> > > >                 ethernet at 8000000 {
> >> > > >                         compatible = "smsc,lan9118", "smsc,lan9115";
> >> > > >
> >> > >
> >> > > Could you please post this as a formal patch and indicate
> >> > > if you would like it included as a fix in v3.10 or not?
> >> >
> >> > Can do that, sure, just thought maybe it would be better to fix the
> >> > original patch. Besides, I wasn't sure what the correct values for
> >> > "ranges" are, I just picked up something, that would be sufficient for
> >> > ethernet. But if more devices are added to it in the future, maybe
> >> > different ranges values would be needed. I think actually, lbsc should map
> >> > the 3 BSC areas, so, the correct property would be
> >> >
> >> > +           ranges = <0 0 0 0x14000000>;
> >> >
> >> > > Also, I am curious to know what your tests are.
> >> >
> >> > Just booting with NFS root. I think, anything involving ethernet. Without
> >> > the "simple-bus" property the lbsc node doesn't get scanned, so, no device
> >> > is added. Without "ranges" addresses cannot be mapped correctly.
> >>
> >> Since it's a flat mapping you can just specify an empty "ranges" property, no
> >> need to actually define contents.
> >
> > Yes, I knew about that, but does this also hold for busses with different
> > #address-cells properties, i.e. between 64- and 32-bit busses?
> 
> Oh, good question -- I don't think it does. But why go down, you might
> as well use 2 cells in that part of the tree too?

Ok, I didn't write the original implementation of that bus and, therefore, 
didn't decide how many address cells it shall use. My task was to fix it. 
And yes, I agree, that there are 2 ways to fix the memory mapping: either 
define ranges to map from 64-bits to 32-bits, or to change all devices on 
the bus (currently there's only 1) to use 64-bit "reg" property and use 
"ranges" with no arguments. Since that bus is clearly within a 32-bit 
area, I would prefer the former solution not to have to drag 64 bits 
around an make device nodes simpler. Can we keep this approach or are you 
strongly against it?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
