From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 11 Apr 2017 22:52:29 +0200
Subject: [PATCH v2 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <936a53ee-2ed8-11e4-a860-744256676af9@collabora.com>
References: <cover.1491118230.git.guillaume.tucker@collabora.com>
 <a01a50d3-bb1b-2c56-2a15-30651fa2fac9@baylibre.com>
 <936a53ee-2ed8-11e4-a860-744256676af9@collabora.com>
Message-ID: <8676554.1IW2xieEGM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guillaume,

Am Dienstag, 11. April 2017, 18:40:37 CEST schrieb Guillaume Tucker:
> On 03/04/17 09:12, Neil Armstrong wrote:
> > On 04/02/2017 09:59 AM, Guillaume Tucker wrote:
> >> +Optional:
> >> +
> >> +- clocks : Phandle to clock for the Mali Midgard device.
> >> +- clock-names : Shall be "clk_mali".
> >> +- mali-supply : Phandle to regulator for the Mali device. Refer to
> >> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> >> +- operating-points : Refer to
> >> Documentation/devicetree/bindings/power/opp.txt +  for details.
> > 
> > Please add :
> >    * Must be one of the following:
> >       "arm,mali-t820"
> >    
> >    * And, optionally, one of the vendor specific compatible:
> >       "amlogic,meson-gxm-mali"
> > 
> > with my Ack for the amlogic platform.
> 
> It seems to me that as long as the GPU architecture hasn't been
> modified (I don't think I've ever encountered such a case) then
> it has to be a standard ARM Mali type regardless of the SoC
> vendor.  So unless a Mali-T820 in the Amlogic S912 SoC is not the
> same as a T820 in a different SoC, please forgive me but I don't
> understand why a vendor compatible string is needed.  My main
> concern is that it's going to be very hard to keep that list
> up-to-date with all existing Midgard SoC variants.  If do we need
> to add vendor compatible strings to correctly describe the
> hardware then I'm happy to add the amlogic one in my patch v3; I
> would just like to understand why that's necessary.

SoC vendors in most cases hook ip blocks into their socs in different
and often strange ways. After all it's not some discrete ic you solder
onto a board, but instead a part of the soc itself.

So in most cases you will have some hooks outside the actual gpu iospace
that can be used to tune different things about how the gpu interacts with
the system. Which is probably also the reason the midgard kernel driver
has this ugly "platform" subdirectory for compile-time platform selection.

On my rk3288 for example we have [0] in the chromeos tree, that handles
the oddities of the midgard on the rk3288 used in a lot of Chromebooks.
There are soc-specific oddities of frequencies, frequency-scaling and
whatnot. And there are also more gpu-specific setting in syscon areas
of the soc (pmu and grf) that can also influence the gpus performance
and might need tweaking at some point.

That doesn't even take into account that there may even be differences
on how things are synthesized that we don't know about. See all the
variants of the dw_hdmi ip block (imx, rockchip, meson [more?]) .

So we really want to have the special compatibles in place, to be prepared
for the future per-soc oddities that always appear :-) .


Heiko

[0] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/gpu/arm/midgard/platform/rk/
