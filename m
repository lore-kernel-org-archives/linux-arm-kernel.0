From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 10 Jun 2014 11:47:00 +0100
Subject: [PATCH] ARM: debug: fix broken DEBUG_LL_INCLUDE for multi platform
In-Reply-To: <20140610101021.GX23430@n2100.arm.linux.org.uk>
References: <1402394236-14778-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20140610101021.GX23430@n2100.arm.linux.org.uk>
Message-ID: <5396E224.1070806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/06/14 11:10, Russell King - ARM Linux wrote:
> On Tue, Jun 10, 2014 at 10:57:16AM +0100, Srinivas Kandagatla wrote:
>> On multi_v7_defconfig using def_bool in Kconfig can override the selection
>> made as part of DEBUG_LL. This is because def_bool will set the config to true
>> if the expression evaluates to true, which is what was happening in
>> multi_v7_defconfig. ARCH_SPEAR13XX selects DEBUG_UART_PL01X overiding any
>> previous DEBUG_LL selections.
>>
>> Making the def_bool to bool and depends made sense in this case, and
>> fixes the issue too.
>
> NAK.
>
> 1. you haven't tested this - if you select DEBUG_BCM2835 in the choice,
>     it will select DEBUG_UART_PL01X, which, with your patch, will not
>     have its new dependencies satisfied.

I see your point.
>
> 2. there is nothing to select this debug option on the platforms which
>     you make it depend upon.

>
> The real solution here is to convert these (and the other) remaining
> platforms to the choice mechanism.  Same for the 8250 one.
>
Yes, I can see the mess here,

Choice menu already provides options for selecting pl01x and 8250 via 
DEBUG_LL_UART_PL01X and DEBUG_LL_UART_8250 options. so I don't see point 
of having dependencies or def_bool options for PL01X and 8250. Other 
then getting them selected automatically and overriding DEBUG_LL selections.

This new patch removes those dependencies or default selections and 
forces the platforms to go via choice mechanism.

What do you think?

Subject: [PATCH v2] ARM: debug: fix broken DEBUG_LL_INCLUDE for multi 
platform

On multi_v7_defconfig using def_bool in Kconfig can override the selection
made as part of DEBUG_LL. This is because def_bool will set the config 
to true
if the expression evaluates to true, which is what was happening in
multi_v7_defconfig. ARCH_SPEAR13XX selects DEBUG_UART_PL01X overiding any
previous DEBUG_LL selections.

Making the def_bool to bool made sense in this case, and fixes the issue 
too.
This means that the platforms should go via DEBUG_LL choice mechanism to
select PL01X or 8250 debug uart.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  arch/arm/Kconfig.debug | 17 +++--------------
  1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 40ee328..ce676bb 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -962,22 +962,11 @@ config DEBUG_LL_INCLUDE
  	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
  	default "mach/debug-macro.S"

-# Compatibility options for PL01x
  config DEBUG_UART_PL01X
-	def_bool ARCH_EP93XX || \
-		ARCH_INTEGRATOR || \
-		ARCH_SPEAR3XX || \
-		ARCH_SPEAR6XX || \
-		ARCH_SPEAR13XX || \
-		ARCH_VERSATILE
-
-# Compatibility options for 8250
+	bool
+
  config DEBUG_UART_8250
-	def_bool ARCH_DOVE || ARCH_EBSA110 || \
-		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
-		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
-		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+	bool

  config DEBUG_UART_PHYS
  	hex "Physical base address of debug UART"
-- 

--srini
