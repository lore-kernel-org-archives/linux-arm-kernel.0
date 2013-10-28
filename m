From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Oct 2013 15:32:21 +0200
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
 <20130708093410.GT5523@atomide.com>
 <20130708142103.GX21614@n2100.arm.linux.org.uk> <51ECFDFD.60102@ti.com>
 <CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
Message-ID: <526E6765.3030403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/10/13 15:26, Javier Martinez Canillas wrote:

> When booting with DT the omapfb's probe is deferred several times but
> it always fails on dpi_connect() due not being able to get the
> VDDS_DSI regulator:

The problem with DT boot is that the VDDS_DSI is not linked to the DPI
device. For omap4, we have a few hacks to go around this (see dsi.c,
dsi_regulator_init()).

> So I tried adding this to my DT with no luck.
> 
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
> b/arch/arm/boot/dts/omap3-igep0020.dts
> index 17a6fc1..eaae935 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -256,3 +256,8 @@
>  &usbhsehci {
>         phys = <&hsusb1_phy>;
>  };
> +
> +&vpll2 {
> +        supply-dev = "omapdss_dpi.0";
> +        supply = "vdds_dsi";
> +};

I didn't see "supply-dev" defined in dt bindings documentation, is that
supposed to work? If it should work, then the problem could be solved
with the above. Otherwise I guess we must add more hacks to omapdss
driver, to all places where it uses regulator_get...

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/a76b34f1/attachment.sig>
