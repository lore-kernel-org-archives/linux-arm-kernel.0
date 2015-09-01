From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 01 Sep 2015 09:36:04 +0300
Subject: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
In-Reply-To: <1441073073.12012.3.camel@ingics.com>
References: <1441073073.12012.3.camel@ingics.com>
Message-ID: <55E54754.1060002@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Adding linux-spi and Mark Brown.

On 09/01/2015 05:04 AM, Axel Lin wrote:
>    CC [M]  arch/arm/plat-pxa/ssp.o
> arch/arm/plat-pxa/ssp.c:110:52: error: 'LPSS_SSP' undeclared here (not in a function)
> scripts/Makefile.build:264: recipe for target 'arch/arm/plat-pxa/ssp.o' failed
> make[1]: *** [arch/arm/plat-pxa/ssp.o] Error 1
> Makefile:965: recipe for target 'arch/arm/plat-pxa' failed
> make: *** [arch/arm/plat-pxa] Error 2
>
>
> The build error is introduced by:
> commit 03fbf488cece461468d3abb795f5e5f055e00040
> Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Date:   Thu Jun 4 16:55:10 2015 +0300
>
>      spi: pxa2xx: Differentiate Intel LPSS types
>
I obviously didn't do tree wide grep for LPSS_SSP and pxa3xx_defconfig 
don't reveal it without setting CONFIG_USE_OF. Sorry about that.

No I'm pondering how to fix this. I see these bindings are added by the 
commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") but some of the 
types are not used anywhere. For instance PXA168_SSP or PXA910_SSP. Then 
PXA3xx_SSP is used in sound/soc/pxa/pxa-ssp.c and CE4100_SSP in 
drivers/spi/spi-pxa2xx.c (where LPSS_SSP was used too before 
differentiating it).

What I'm wondering is this binding below correct in 
arch/arm/plat-pxa/ssp.c? LPSS_SSP was meant to be for Intel Intel Low 
Power Subsystem SPI.

"{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"

Mika, Daniel: do you know is there any change there is a Marvell PXA 
platform compatible with Intel LPSS or is above binding bogus?

-- 
Jarkko
