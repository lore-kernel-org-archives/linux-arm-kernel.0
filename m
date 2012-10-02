From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Oct 2012 14:12:23 -0600
Subject: [PATCH 1/3] ARM: tegra: simplify DEBUG_LL UART selection options
In-Reply-To: <20121002200130.GA31363@avionic-0098.mockup.avionic-design.de>
References: <1349204866-21810-1-git-send-email-swarren@wwwdotorg.org>
 <20121002200130.GA31363@avionic-0098.mockup.avionic-design.de>
Message-ID: <506B4AA7.60609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 02:01 PM, Thierry Reding wrote:
> On Tue, Oct 02, 2012 at 01:07:44PM -0600, Stephen Warren wrote: 
> [...]
>> choice -        prompt "Default low-level debug console UART" -
>> default TEGRA_DEBUG_UART_NONE +        prompt "Low-level debug
>> console UART" +        default TEGRA_DEBUG_UART_AUTO_ODMDATA
>> 
>> -config TEGRA_DEBUG_UART_NONE -        bool "None" +config
>> TEGRA_DEBUG_UART_AUTO_ODMDATA
> 
> The first item in a list of choices is automatically selected as
> the default, so technically the default is redundant here. I
> suppose it doesn't hurt to be explicit.
> 
>> diff --git a/arch/arm/mach-tegra/common.c
>> b/arch/arm/mach-tegra/common.c index 0b0a5f5..0913d1f 100644 ---
>> a/arch/arm/mach-tegra/common.c +++
>> b/arch/arm/mach-tegra/common.c @@ -44,14 +44,13 @@ * kernel is
>> loaded. The data is declared here rather than debug-macro.S so *
>> that multiple inclusions of debug-macro.S point at the same
>> data. */ -#define TEGRA_DEBUG_UART_OFFSET (TEGRA_DEBUG_UART_BASE
>> & 0xFFFF) u32 tegra_uart_config[3] = { /* Debug UART
>> initialization required */ 1, /* Debug UART physical address */ -
>> (u32)(IO_APB_PHYS + TEGRA_DEBUG_UART_OFFSET), +	0, /* Debug UART
>> virtual address */ -	(u32)(IO_APB_VIRT +
>> TEGRA_DEBUG_UART_OFFSET), +	0, };
> 
> I don't quite see how this is supposed to work now. Won't the
> debug.S code fail if these fields are set to 0?

If those fields remain set to 0, then there will be no DEBUG_LL output.

However, assuming use of a compressed zImage rather than an
uncompressed Image then at this stage in the series, uncompress.h
writes the UART selection and a cookie to Tegra's IRAM, and
debug-macro.S reads that selection, and re-initializes those fields to
whatever uncompress.h chose.

In patch 2 in the series, the coupling between uncompress.h and
debug-macro.S is entirely removed, and instead, debug-macro.S
initializes those values the first time a character is printed.

The values aren't hard-coded there since they are now (after patch 2)
always over-written. Even when a single static UART is selected, we
can't hard-code the address since debug-macro.S validates that the
clock and reset bits to the UART are correctly set before using it,
hence we might end up not using the UART anyway.
