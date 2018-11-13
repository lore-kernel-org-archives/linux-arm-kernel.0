From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Nov 2018 17:29:50 +0000
Subject: [PATCH] arm64: dts: marvell: armada_8k: reserve memory for ATF
In-Reply-To: <20181113134807.53292-1-manu@freebsd.org>
References: <20181113134807.53292-1-manu@freebsd.org>
Message-ID: <20181113172950.GL30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 02:48:07PM +0100, Emmanuel Vadot wrote:
> Like 4436a371 for 37xx, reserve the PSCI area memory region so kernels
> can call the code there.
> Region address is taken from the ATF code [1] and is 2MiB aligned.
> 
> [1] plat/marvell/a8k/common/include/platform_def.h
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 073610ac0a53..d8a79bb69de1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -23,6 +23,21 @@
>  		spi0 = &spi0;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/*
> +		 * The PSCI firmware region depicted below is the default one
> +		 * and should be updated by the bootloader.
> +		 */
> +		psci-area at 4000000 {
> +			reg = <0 0x4000000 0 0x200000>;
> +			no-map;
> +		};
> +	};

Does this really apply to everything?  I'm not sure it does.
If I look at a memory dump from the Macchiatobin, I see:

 04000000  00000000 00000007 00000005 00000040
 04000010  00000001 00001000 00000007 00000001
 04000020  00000008 00000000 00000009 00000000
 04000030  0000000a 00000000 fff7ffff ffffffff
 04000040  fbf7dfc7 fffffdff f2fffffe fbfdfffb
 04000050  af7ffefb fbfff7ff efbfffe3 5efdbf4d
 04000060  ff7effff fdffedff ff9f8fff ef9ffffd
 04000070  bffcffff ff7fff7a eff7ff7d 7fffbfff
 04000080  ffefefff fedfff7f ffdfffff ffbdff7f
 04000090  f3ff7fdb ffff76ff ffeffefe ffffff7f
 040000a0  9fffffff fff7ffdf edffffff fcffdfff
 040000b0  fffbefff fefffffb ffeffff7 6fffffff
 040000c0  ffdffdfb fd7fff9e fbefefbf eeefdfeb
 040000d0  bbdfbda3 9dfdef92 7b6ffaee fffde3fc
 040000e0  ff9efffd ff79ffdb ffaef57f ffaec1fe
 040000f0  bff7ffff fffeffdb effffb3f eaedffee
 04000100  fffffffb ffffffdf ffdffebf bfefbff3
 04000110  ffffffff fffffeff f7ffffff ffeeefff
 04000120  f7ffff7f fedfffff fffffffe fffefefe
 04000130  fbffff7d fffdffff fdffffff b7ffffff
 04000140  6fffffff ffee7fed fffffeff fffbfe6d
 04000150  fd5ff7ff f7bfffdc fdfff3c7 f7ff6f1d

Doesn't look like firmware to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
