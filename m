From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Nov 2012 18:45:03 +0000 (UTC)
Subject: [PATCH] Remove inline from clock framework function definitions
 to build the kernel with GCC 4.7
In-Reply-To: <50A53368.6090306@ti.com>
References: <50A52134.2010502@gmail.com> <50A53368.6090306@ti.com>
Message-ID: <alpine.DEB.2.00.1211151842450.18192@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2012, Jon Hunter wrote:

> 
> On 11/15/2012 11:07 AM, Igor Mazanov wrote:
> >  Remove inline from clock framework function definitions to
> >  build the kernel with GCC 4.7
> 
> Adding Mike to the party ...
> 
> May be good to add some details about the exact problem seen.
> 
> I am seeing the same problem today with GCC 4.7 and Tony's master
> branch. For a bit of background it seems that for 4.7 not having
> the body of the inlined function available in the header is
> causing this error. Another example here [1].
> 
> The actual compiler error seen for OMAP is ...
> 
> In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> arch/arm/mach-omap2/clockdomain.c: In function ?clkdm_clk_disable?:
> include/linux/clk-provider.h:338:12: error: inlining failed in call to always_inline ?__clk_get_enable_count?: function body not available
> arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

Yep this one is for Mike to fix in the main CCF code; it's not an 
OMAP-specific issue.  sparse warns about this too, so it's not just a gcc 
4.7 problem.

> Do we also need to remove the inline from the functions declared in
> drivers/clk/clk.c too?

It's usually best to just let the compiler decide whether to inline 
functions.  For example, Documentation/CodingStyle Chapter 15.


- Paul
