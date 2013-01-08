From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 08 Jan 2013 19:01:19 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
 <201211062114.49933.arnd@arndb.de>
 <alpine.LFD.2.02.1211061802240.21033@xanadu.home>
Message-ID: <50EC6CFF.5070309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 06/11/12 23:14, Nicolas Pitre wrote:
> On Tue, 6 Nov 2012, Arnd Bergmann wrote:
>
>> On Tuesday 06 November 2012, Nicolas Pitre wrote:
>
>> The two options are either to make
>> vexpress be single-platform when building for !MMU, or to allow multiplatform
>> kernels to be built without MMU support in principle. I think the second
>> option is more logical and avoids complex Kconfig constructs.
>
> Well, I'd rather prefer to think that the first option is the most
> logical between those 2 options, regardless of Kconfig complexity
> issues.
>
> I didn't look, but just making MULTIPLATFORM depend on !MMU, and
> VEXPRESS depend on MULTIPLATFORM || MMU should be close to what is
> needed, no?
>

I've spent a little bit of time trying this, as both Arnd and you seemed 
to be happy with a solution along these lines.

However, I can't seem to make it fall out quite so trivially so I wonder 
if you'd mind clarifying what you were expecting:

The problem that I see when I try to do this is that ARCH_VEXPRESS no 
longer exists in the 'choice' for "ARM system type" in arch/arm/Kconfig. 
A solution that allows selection of VEXPRESS as a single platform (!MMU) 
and multi-platform (MMU) appears to need an entry in that 'choice' for 
the single platform case, and a config option in 
arch/arm/mach-vexpress/Kconfig for the multiplatform one.

So it seems to me we need a shim in one of those two locations...

As Will suggested a while back, the shim in arch/arm/Kconfig could look 
like:

---8<---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 335e220..0561d87 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -305,6 +305,11 @@ config ARCH_REALVIEW
         help
           This enables support for ARM Ltd RealView boards.

+config ARCH_VEXPRESS_NOMMU
+       bool "ARM Ltd. Versatile Express family (nommu)"
+       depends on !MMU
+       select ARCH_VEXPRESS
+
  config ARCH_VERSATILE
         bool "ARM Ltd. Versatile family"
         select ARCH_WANT_OPTIONAL_GPIOLIB
---->8----

With the other perhaps being to merge the ARCH_VEXPRESS option back in 
to the 'choice' and create a ARCH_VEXPRESS_MULTI elsewhere...

Is that the sort of thing you had in mind, or is there another way 
around that I'm missing?

Thanks,

Jonny
