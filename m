From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 09 Feb 2015 14:17:17 +0100
Subject: [PATCH] ARM: dts: exynos5420: Add maudio power domain
In-Reply-To: <54D8AEE5.1090308@collabora.co.uk>
References: <1423485695-22568-1-git-send-email-k.kozlowski@samsung.com>
 <54D8AEE5.1090308@collabora.co.uk>
Message-ID: <1423487837.23462.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2015-02-09 at 13:58 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 02/09/2015 01:41 PM, Krzysztof Kozlowski wrote:
> > Add maudio power domain to Exynos 5420 DTSI file so its state could be
> > tracked. This actually won't power down this domain because the pl330
> > dmaengine driver (for adma channel) uses IRQ safe runtime PM. Thus the
> > patch should not introduce any functional change except of visibility of
> > this domain to the system.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> 
> Your patch looks good to me, I just have two small comments below. With
> those changes, feel free to add:
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks!

> 
> >  arch/arm/boot/dts/exynos5420.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> > index 6d38f8bfd0e6..2e99a39f7250 100644
> > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > @@ -270,6 +270,11 @@
> >  		reg = <0x10044120 0x20>;
> >  	};
> >  
> > +	mau_pd: power-domain at 100440E0 {
> > +		compatible = "samsung,exynos4210-pd";
> > +		reg = <0x100440E0 0x20>;
> 
> You also need to add #power-domain-cells = <0> here since "power-domain-cells"
> is a required property now that the Exynos PD code has been converted to use
> the generic power domains lookup.

Okay

> 
> > +	};
> > +
> >  	pinctrl_0: pinctrl at 13400000 {
> >  		compatible = "samsung,exynos5420-pinctrl";
> >  		reg = <0x13400000 0x1000>;
> > @@ -328,6 +333,7 @@
> >  			#dma-cells = <1>;
> >  			#dma-channels = <6>;
> >  			#dma-requests = <16>;
> > +			samsung,power-domain = <&mau_pd>;
> 
> Same here. Even though "samsung,power-domain" is kept as backward compatible,
> "power-domains" should be used instead. In fact Marek sent a patch [0] to get
> rid of all the current "samsung,power-domain" properties so it would be good
> if you can base on top of that one.

Right, I rebased this on mid-January next which did not include Marek's
work yet.

Best regards,
Krzysztof

> 
> Best regards,
> Javier
> 
> [0]: http://www.spinics.net/lists/linux-samsung-soc/msg40584.html
