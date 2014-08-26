From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Aug 2014 13:20:58 +0900
Subject: [PATCH] ARM: shmobile: lager: correct memory map
In-Reply-To: <CAOesGMieRk4Dvg=gxTgcVssARkK6DeoaVyK8619B2N5=wwo=Uw@mail.gmail.com>
References: <1409021623-10633-1-git-send-email-horms+renesas@verge.net.au>
 <CAOesGMieRk4Dvg=gxTgcVssARkK6DeoaVyK8619B2N5=wwo=Uw@mail.gmail.com>
Message-ID: <20140826042055.GA12108@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 08:04:49PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, Aug 25, 2014 at 7:53 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The base address of the second memory region on the lager
> > board is 0x140000000. Update the tag used in the dts file accordingly.
> >
> > This is a documentation fix and should have no run-time affect.
> >
> > This problem was introduced when the second memory region
> > was added to the lager dts file by 62bc32a2573c4219
> > ("ARM: shmobile: Include all 4 GiB of memory on Lager)"
> > in v3.14.
> >
> > Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > index 0118cbf..84dcafa 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -32,7 +32,7 @@
> >                 reg = <0 0x40000000 0 0x40000000>;
> >         };
> >
> > -       memory at 180000000 {
> > +       memory at 140000000 {
> 
> That should even be "memory at 1,40000000".

Two comma-separated 32bit values in the case
where a memory range starts above 4Gb?

If so it looks like this will be the first user of that syntax
(I don't see any in linux-next today).

I do however see several users of memrory at 64bit_value.
Mostly other renesas fds files; ecx-2000.dts being the exception.
Should they be fixed too?

$ find -name "*.dts" | xargs grep memory@[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
./arch/arm/boot/dts/r8a7791-henninger.dts:	memory at 200000000 {
./arch/arm/boot/dts/r8a7791-koelsch.dts:	memory at 200000000 {
./arch/arm/boot/dts/ecx-2000.dts:	memory at 200000000 {
./arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts:	memory at 200000000 {
./arch/arm/boot/dts/r8a7790-lager.dts:	memory at 180000000 {
./arch/arm/boot/dts/r8a73a4-ape6evm.dts:	memory at 200000000 {
