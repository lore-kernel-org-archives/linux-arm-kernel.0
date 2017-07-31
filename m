From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 31 Jul 2017 17:23:06 +0200
Subject: [PATCH] ARM: tegra: Register host1x node with iommu binding on
 tegra124
In-Reply-To: <1499786264.1520.22.camel@toradex.com>
References: <20170709163614.6746-1-contact@paulk.fr>
 <1499763009.1340.11.camel@paulk.fr>
 <1499784841.1520.20.camel@toradex.com>
 <1499785555.1340.15.camel@paulk.fr>
 <1499786264.1520.22.camel@toradex.com>
Message-ID: <20170731152306.GB27815@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 03:17:46PM +0000, Marcel Ziswiler wrote:
> On Tue, 2017-07-11 at 18:05 +0300, Paul Kocialkowski wrote:
> > On Tue, 2017-07-11 at 14:54 +0000, Marcel Ziswiler wrote:
> > > On Tue, 2017-07-11 at 11:50 +0300, Paul Kocialkowski wrote:
> > > > On Sun, 2017-07-09 at 19:36 +0300, Paul Kocialkowski wrote:
> > > > > This registers the host1x node with the SMMU (as HC swgroup) to
> > > > > allow
> > > > > the host1x code to attach to it. It avoid failing the probe
> > > > > sequence,
> > > > > which resulted in the tegra drm driver not probing and thus
> > > > > nothing
> > > > > being displayed on-screen.
> > > > 
> > > > Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")
> > > > 
> > > > > Signed-off-by: Paul Kocialkowski <contact-
> > > > > W9ppeneeCTY at public.gmane.org>
> > > 
> > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > Tested-on: Apalis TK1, Jetson-TK1
> > > 
> > > > > ---
> > > > > ?arch/arm/boot/dts/tegra124.dtsi | 1 +
> > > > > ?1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/tegra124.dtsi
> > > > > b/arch/arm/boot/dts/tegra124.dtsi
> > > > > index 187a36c6d0fc..b3b89befffeb 100644
> > > > > --- a/arch/arm/boot/dts/tegra124.dtsi
> > > > > +++ b/arch/arm/boot/dts/tegra124.dtsi
> > > > > @@ -85,6 +85,7 @@
> > > > > ?		clocks = <&tegra_car TEGRA124_CLK_HOST1X>;
> > > > > ?		resets = <&tegra_car 28>;
> > > > > ?		reset-names = "host1x";
> > > > > +		iommus = <&mc TEGRA_SWGROUP_HC>;
> > > > > ?
> > > > > ?		#address-cells = <2>;
> > > > > ?		#size-cells = <2>;
> > > 
> > > So I take it we still will need this one moving forward, correct?
> > 
> > Yes, this one actually enables the IOMMU while the other one handles
> > the
> > failure to attach the IOMMU without brinding the whole drm driver
> > down.
> > 
> > So it's best to actually make use of the feature!
> > 
> > > How about tegra30, I guess the same applies there, isn't it? Should
> > > I
> > > send a patch or are you guys doing that?
> > 
> > I don't have any tegra hardware aside of tegra124, so that's all I
> > can
> > contribute to. I don't know if others have looked into the same type
> > of
> > issue happening on either newer or older platforms.
> 
> OK, as we happen to still selling Apalis/Colibri T30 and me having
> Beaver as well as Cardhu available for testing I can cook something up,
> test and send it along. First tries indicate it working on 4.12 but
> somehow crashing during memory allocation on -next. We'll see.

I think we're going to need the same change on Tegra30 and Tegra114. And
Tegra132 and Tegra210 for that matter. With the gpu/host1x fix applied
things should keep working on all generations, but we need DT changes if
we want to make use of the SMMU.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/69c00fb8/attachment-0001.sig>
