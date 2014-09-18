From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Sep 2014 23:46:25 +0100
Subject: [PATCH 2/3] ARM: vfp: fix VFPv3 hwcap detection on non-ARM vfp
 implementations
In-Reply-To: <1411076592-6157-3-git-send-email-sboyd@codeaurora.org>
References: <1411076592-6157-1-git-send-email-sboyd@codeaurora.org>
 <1411076592-6157-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140918224625.GF5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:43:11PM -0700, Stephen Boyd wrote:
> diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
> index f4ab34fd4f72..76d3f6907cce 100644
> --- a/arch/arm/include/asm/vfp.h
> +++ b/arch/arm/include/asm/vfp.h
> @@ -21,7 +21,7 @@
>  #define FPSID_FORMAT_MASK	(0x3  << FPSID_FORMAT_BIT)
>  #define FPSID_NODOUBLE		(1<<20)
>  #define FPSID_ARCH_BIT		(16)
> -#define FPSID_ARCH_MASK		(0xF  << FPSID_ARCH_BIT)
> +#define FPSID_ARCH_MASK		(0x7F  << FPSID_ARCH_BIT)

This is incorrect.  On VFPv2, the architecture field is four bits long.
As you can see from the above, bit 20 indicates that there are no
double operations provided, and the next two bits indicate the FSTMX/
FLDMX format.

I know that you're changing this to conform with the ARM ARM, but we
have to consider that before VFP was subsumed into the ARM ARM, this
register had the format described as per this file, and these other
bits may be set for an ARM part.  Including these bits in the mask
means that we will mis-identify these older parts as VFPv3.

Welcome to the lack of standardisation!

-- 
FTTC broadband for 0.8mile line: currently@9.5Mbps down 400kbps up
according to speedtest.net.
