From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 26 Sep 2012 23:56:51 +0200
Subject: [RFC PATCH 1/3] ARM: move ICEDCC uncompress.h to common location
In-Reply-To: <1348613212-21897-2-git-send-email-swarren@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <1348613212-21897-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120926215651.GA20405@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 04:46:50PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Create a common location for uncompress.h, and select the included debug
> macro file using config option.
> 
> This does the same for uncompress.h as a recent patch for debug-macro.S,
> which was based on a suggestion by Russell King and implemented by Rob
> Herring.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/Kconfig.debug                     |   10 ++++
>  arch/arm/boot/compressed/misc.c            |   64 +---------------------------
>  arch/arm/include/debug/icedcc-uncompress.h |   61 ++++++++++++++++++++++++++
>  arch/arm/include/debug/none-uncompress.h   |    3 +
>  4 files changed, 75 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm/include/debug/icedcc-uncompress.h
>  create mode 100644 arch/arm/include/debug/none-uncompress.h
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b0f3857..0daec3d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -420,6 +420,16 @@ config DEBUG_LL_INCLUDE
>  		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
>  	default "mach/debug-macro.S"
>  
> +config UNCOMPRESS_INCLUDE
> +	string
> +	default "debug/icedcc-uncompress.h" if DEBUG_ICEDCC
> +	default "debug/none-uncompress.h" if ARCH_MULTIPLATFORM || \
> +		DEBUG_HIGHBANK_UART || DEBUG_MVEBU_UART || \
> +		DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
> +		DEBUG_VEXPRESS_UART0_DETECT || DEBUG_VEXPRESS_UART0_CA9 || \
> +		DEBUG_VEXPRESS_UART0_RS1

I would ask to add DEBUG_LL_UART_NONE to the or-ed list, which fixes the
build of platforms without mach/uncompress.h and mach/debug-macro.S in
case NONE is selected, but I'm not sure.

If I got the point of Russel right, uncompress.h is not a debug trace and
maybe should not depend on any DEBUG_LL* option?

Regards,
Domenico
