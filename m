From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 4 Feb 2016 14:41:29 -0800
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160204224128.GG4215@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-02-04 at 20:20:17 +0200, Grygorii Strashko wrote:
> This patch intended to fix following cases: 
> - SoC-A has ARM GT, defines DT node for ARM GT and selects ARM_GLOBAL_TIMER
> statically in Kconfig file. SoC-B has ARM GT and defines DT node for ARM GT,
> but do not selects ARM_GLOBAL_TIMER statically in Kconfig file. In case of
> multiplatform build ARM GT will be implicitly enabled for SoC-B.
> 
> - There is no way to disable ARM GT without modifying Kconfig file,
> once ARM_GLOBAL_TIMER is selected statically in Kconfig file.
> 
> Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
> ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
> the usage configurable' section in kconfig-language.txt. All places in
> ARM folder where ARM_GLOBAL_TIMER was used now replaced on
> HAVE_ARM_GLOBAL_TIMER.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
[...]
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index fd0aeeb..3165720 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -5,7 +5,7 @@ config ARCH_ZYNQ
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_GIC
> -	select ARM_GLOBAL_TIMER if !CPU_FREQ
> +	select HAVE_ARM_GLOBAL_TIMER if !CPU_FREQ

We actually have this issue, as we don't want to use GT when CPU_FREQ is
enabled. But with this change the 'if !CPU_FREQ' becomes obsolete.

Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
