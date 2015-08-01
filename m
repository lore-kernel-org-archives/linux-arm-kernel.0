From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Aug 2015 01:13:08 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
In-Reply-To: <4605286.lfFsCUY5jc@diego>
References: <15143985.aGzb1oeyb9@diego>
 <CAD=FV=W2LSQh4e9+=ooTf34VzM_yPZn497DqSVEdb1kehZbqQQ@mail.gmail.com>
 <4605286.lfFsCUY5jc@diego>
Message-ID: <1634487.FDgX1HIOR2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 2. August 2015, 00:52:44 schrieb Heiko St?bner:
> Hi Doug,
> 
> Am Samstag, 1. August 2015, 14:32:32 schrieb Doug Anderson:
> > On Sat, Aug 1, 2015 at 5:35 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > > The rk3288 has problems accessing the memory region
> > > 0xfe000000~0xff000000.
> > > So block off the affected region to prevent its use.
> > > 
> > > Tested on 4GB Veyron Minnie and 2GB Veyron Jerry devices.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > 
> > >  arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/rk3288.dtsi
> > > b/arch/arm/boot/dts/rk3288.dtsi
> > > index 2db91c9..19766af 100644
> > > --- a/arch/arm/boot/dts/rk3288.dtsi
> > > +++ b/arch/arm/boot/dts/rk3288.dtsi
> > > @@ -169,6 +169,16 @@
> > > 
> > >                 };
> > >         
> > >         };
> > > 
> > > +       reserved-memory {
> > > +               #address-cells = <1>;
> > > +               #size-cells = <1>;
> > > +               ranges;
> > > +
> > > +               unusable at fe000000 {
> > > +                       reg = <0xfe000000 0x1000000>;
> > > +               };
> > > +       };
> > > +
> > 
> > I don't object to just reserving this memory, but I do object a little
> > to this implementation.
> > 
> > It's 16 MB we're talking about here, which is pretty small compared to
> > the 4G of memory that you must have when this is a problem.  However,
> > at some point we might want to try to actually use this 16 MB.
> > 
> > The memory is actually _not_ unusable, it's only unusable for DMA.  In
> > theory the kernel is supposed to have a way to mark memory as unusable
> > for DMA which would then allow us to use this memory for non-DMA
> > purposes...
> 
> Ok, the patch message in the chromeos-patch didn't mention dma, but I
> could've thought of that myself, sorry.
> 
> > Nobody ever managed to figure this out in the Chrome OS tree (it was
> > 16 megs so we just reserved it and never got back around to it), but
> > when folks were looking at it they looked at things like ZONE_DMA,
> > dma_set_mask_and_coherent, etc.
> > 
> > In any case, to leave the door open for people to fix this in the
> > future, it seems prudent to fix this in code like
> > <https://chromium-review.googlesource.com/#/c/245107/> rather than to
> > put the limit in DTS.
> 
> The dt code when creating the platform-devices assumes a 32bit dma mask and
> expects the drivers to set the correct dma_masks (in of_dma_configure). But
> from the original description this looks more like a limitation of the
> rk3288, not the individual dwmmc, dwc2, etc.
> 
> So from my cursory glance, ZONE_DMA seems to be the best solution. As you
> said that this was investigated too, do you know if they encountered any
> obstacles that resulted in not adjusting the dma zone?
> 
> 
> @Jeffy: do you know how widespread this is? I.e. are socs like the rk3128 or
> possibly more importantly the rk3368 also affected by this in 4GB
> configurations?
> 
> 
> If the rk3368 does it too, this might get "interesting". In one of the mails
> about ZONE_DMA from september 2014, Arnd mentioned that there was a patch
> about getting the zone size from devicetree floating around, but it doesn't
> look like this landed.

actually the "dma-ranges" property also looks promising (through 
of_dma_get_range() called fromof_dma_configure() )
