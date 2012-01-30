From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 17:42:12 +0000
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <1327513396.2355.28.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>
 <4F181BD9.20401@gmail.com>
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>
 <4F182248.7070209@gmail.com>
 <1326984672.32197.68.camel@hornet.cambridge.arm.com>
 <4F184C48.2050505@citrix.com>
 <1327513396.2355.28.camel@hornet.cambridge.arm.com>
Message-ID: <20120130174212.GH2248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 05:43:16PM +0000, Pawel Moll wrote:
> On Thu, 2012-01-19 at 17:00 +0000, David Vrabel wrote:
> > > Ok, /include/ "skeleton.dtsi" is gone then :-)
> > 
> > The problem wasn't with including skeleton.dtsi.  With
> > CONFIG_ARM_ATAG_DTB_COMPAT the zImage decompressor modifies the appended
> > DTB using information from the ATAGs (see atags_to_fdt()).
> > 
> > If there's an ATAG giving the amount of RAM the DTB's "memory" node is
> > replaced with a new one.  Since the vexpress DTBs don't have a "memory"
> > node it's added and the DTB ends up with two nodes describing memory.
> 
> As it turned out it was just the "skeleton.dtsi" problem after all - I
> mean the fact that there where two device_type="memory" nodes in the
> tree.
> 
> The decompressor's setprop()
> (arch/arm/boot/compressed/atags_to_fdt.c:12) uses libfdt's
> fdt_setprop(), which correctly ignores the "@00000000" component of the
> node name and sets the reg property as expected. So as long as there is
> exactly one "memory[@address]" node in the tree,
> CONFIG_ARM_ATAG_DTB_COMPAT is happy.
> 
> I will remove the /include/ from the dts files for VE (see below) in the
> v3.3-rc1 based series.
> 
> Thanks for spotting this!
> 
> Pawe??

This carries a significant risk of unintended fragmentation and buggy
maintenance.  This patch is a good example of the kind of change which
could easily go wrong.  (I'm not saying that it is wrong -- just using
it as an example.)

Since we will end up with a significantly large number of device trees
for vexpress, I can foresee that we'll end up with a highly reduncant
set of .dts{,i} files (each of which is often rather internally redundant
too).

Does anyone have a view on whether it's acceptable to generate device
tree sources from another form, instead of having them verbatim in the
kernel tree?  This could involve a preprocessor, or something more
heavyweight.

The dts /include/ mechanism solves this problem only for the simplest
of cases.

Cheers
---Dave

> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> index 02cada5..2a690f2 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -9,13 +9,15 @@
>  
>  /dts-v1/;
>  
> -/include/ "skeleton.dtsi"
> -
>  / {
>  	model = "V2P-CA15";
>  	arm,hbi = <0x237>;
>  	compatible = "arm,vexpress,v2p-ca15,tc1", "arm,vexpress,v2p-ca15", "arm,vexpress";
>  	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen { };
>  
>  	aliases {
>  		serial0 = &v2m_serial0;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> index da26a13..d4c5322 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -9,13 +9,15 @@
>  
>  /dts-v1/;
>  
> -/include/ "skeleton.dtsi"
> -
>  / {
>  	model = "V2P-CA5s";
>  	arm,hbi = <0x225>;
>  	compatible = "arm,vexpress,v2p-ca5s", "arm,vexpress";
>  	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen { };
>  
>  	aliases {
>  		serial0 = &v2m_serial0;
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 84542e7..5d90ce5 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -9,13 +9,15 @@
>  
>  /dts-v1/;
>  
> -/include/ "skeleton.dtsi"
> -
>  / {
>  	model = "V2P-CA9";
>  	arm,hbi = <0x191>;
>  	compatible = "arm,vexpress,v2p-ca9", "arm,vexpress";
>  	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen { };
>  
>  	aliases {
>  		serial0 = &v2m_serial0;
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
