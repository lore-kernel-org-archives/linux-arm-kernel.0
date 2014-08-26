From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 17:52:37 +0900
Subject: [PATCH] ARM: shmobile: lager: correct memory map
In-Reply-To: <CAMuHMdVqZ29-jaS+kLwdVycLOMSbz9H7oJGuq3dLH2y-81mVcQ@mail.gmail.com>
References: <1409021623-10633-1-git-send-email-horms+renesas@verge.net.au>
 <CAOesGMieRk4Dvg=gxTgcVssARkK6DeoaVyK8619B2N5=wwo=Uw@mail.gmail.com>
 <20140826042055.GA12108@verge.net.au>
 <CAMuHMdVqZ29-jaS+kLwdVycLOMSbz9H7oJGuq3dLH2y-81mVcQ@mail.gmail.com>
Message-ID: <20140826085234.GA29667@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 09:52:10AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 26, 2014 at 6:20 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> >> > index 0118cbf..84dcafa 100644
> >> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> >> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> >> > @@ -32,7 +32,7 @@
> >> >                 reg = <0 0x40000000 0 0x40000000>;
> >> >         };
> >> >
> >> > -       memory at 180000000 {
> >> > +       memory at 140000000 {
> >>
> >> That should even be "memory at 1,40000000".
> >
> > Two comma-separated 32bit values in the case
> > where a memory range starts above 4Gb?
> 
> Yes. As #address-cells is 2, there should be two values after the "@"
> (the first one may be optional if it's zero, I don't know for sure?)
> 
> > If so it looks like this will be the first user of that syntax
> > (I don't see any in linux-next today).
> 
> No, "git grep '@.*,' -- arch/arm/boot/dts" shows several users.
> Not all of them are 64-bit memory addresses, but some are.

Thanks, I like your grep better than mine.

> > I do however see several users of memrory at 64bit_value.
> > Mostly other renesas fds files; ecx-2000.dts being the exception.
> > Should they be fixed too?
> >
> > $ find -name "*.dts" | xargs grep memory@[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
> > ./arch/arm/boot/dts/r8a7791-henninger.dts:      memory at 200000000 {
> > ./arch/arm/boot/dts/r8a7791-koelsch.dts:        memory at 200000000 {
> > ./arch/arm/boot/dts/ecx-2000.dts:       memory at 200000000 {
> > ./arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts:      memory at 200000000 {
> > ./arch/arm/boot/dts/r8a7790-lager.dts:  memory at 180000000 {
> > ./arch/arm/boot/dts/r8a73a4-ape6evm.dts:        memory at 200000000 {
> 
> Yes, these should be fixed, too.
> 
> It's a pity dtc doesn't complain about this.

Indeed.
