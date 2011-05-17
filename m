From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:41:57 -0400
Subject: [PATCH 1/9] davinci: pm: fix compiler errors and kernel panics from
	sram consolidation
In-Reply-To: <cover.1305668470.git.bengardiner@nanometrics.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
Message-ID: <467c7cc853555213b2560ebe1f188c09440284c1.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nori, Sekhar <nsekhar@ti.com>

Hi Russell,

On Thu, May 12, 2011 at 23:15:46, Russell King - ARM Linux wrote:

> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 1bd73a0..c2f9767 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c

[...]

> @@ -123,14 +118,14 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>
> -	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
> -	if (!davinci_sram_suspend) {
> +	davinci_sram_suspend_mem = pv_pool_alloc(davinci_pv_pool,
> +				davinci_cpu_suspend_sz, NULL);
> +	if (!davinci_sram_suspend_mem) {
>  		dev_err(&pdev->dev, "cannot allocate SRAM memory\n");
>  		return -ENOMEM;
>  	}
> -
> -	davinci_sram_push(davinci_sram_suspend, davinci_cpu_suspend,
> -						davinci_cpu_suspend_sz);
> +	davinci_sram_suspend = fncpy(davinci_sram_suspend_mem,
> +				davinci_cpu_suspend, davinci_cpu_suspend_sz);

This gave these build errors:

arch/arm/mach-davinci/pm.c: In function 'davinci_pm_probe':
arch/arm/mach-davinci/pm.c:127: error: lvalue required in asm statement
arch/arm/mach-davinci/pm.c:127: error: invalid lvalue in asm output 0
make[1]: *** [arch/arm/mach-davinci/pm.o] Error 1

Replacing davinci_cpu_suspend with &davinci_cpu_suspend fixed the issue.

With that change done, tested suspend-to-RAM on DA850 platform.
Also tested audio driver on DM365 platform with IRAM buffers enabled.

Can you also fold the following patch in? Without this the
kernel panics when suspend-to-RAM is enabled.

Thanks,
Sekhar
---
 arch/arm/mach-davinci/pm.c    |    2 +-
 arch/arm/mach-davinci/sleep.S |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index c2f9767..5255223 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -125,7 +125,7 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	davinci_sram_suspend = fncpy(davinci_sram_suspend_mem,
-				davinci_cpu_suspend, davinci_cpu_suspend_sz);
+				&davinci_cpu_suspend, davinci_cpu_suspend_sz);
 
 	suspend_set_ops(&davinci_pm_ops);
 
diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index fb5e72b..2cef533 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -37,6 +37,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.align 3
 /*
  * Move DaVinci into deep sleep state
  *
-- 
1.7.4.1
