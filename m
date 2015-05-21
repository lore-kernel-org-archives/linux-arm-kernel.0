From: kwestfie@codeaurora.org (Kenneth Westfield)
Date: Thu, 21 May 2015 14:00:00 -0700
Subject: [PATCH] ASoC: qcom: remove incorrect dependencies
In-Reply-To: <2324031.cqS0mEEEhQ@wuerfel>
References: <2324031.cqS0mEEEhQ@wuerfel>
Message-ID: <20150521205952.GA31005@kwestfie-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 11:07:08AM +0200, Arnd Bergmann wrote:
> Compile-tests show a warning for the newly added SND_SOC_STORM
> symbol:
> 
> warning: (SND_SOC_STORM) selects SND_SOC_LPASS_CPU which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && SND_SOC_QCOM)
> 
> The problem is that it can be selected for COMPILE_TEST on non-QCOM
> builds, but the symbols it selects have a dependency.
> Dropping the dependencies makes it work without warnings and no
> other side-effects, because these are not user-visible.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: f380dd3f3cd ("ASoC: qcom: Add ability to build QCOM drivers")
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 5f58e4f1bca9..b07f183fc47f 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -6,12 +6,10 @@ config SND_SOC_QCOM
>  
>  config SND_SOC_LPASS_CPU
>  	tristate
> -	depends on SND_SOC_QCOM

Rather than remove the dependency (which I would like to keep), would
the following change work for SND_SOC_LPASS_CPU and
SND_SOC_LPASS_PLATFORM?
-	depends on SND_SOC_QCOM
+	depends on SND_SOC_QCOM || COMPILE_TEST

If so, I will submit a patch (I know this has been applied already) on
top of this one.

>  	select REGMAP_MMIO
>  
>  config SND_SOC_LPASS_PLATFORM
>  	tristate
> -	depends on SND_SOC_QCOM
>  	select REGMAP_MMIO
>  
>  config SND_SOC_STORM
> 

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
