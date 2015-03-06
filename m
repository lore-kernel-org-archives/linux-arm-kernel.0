From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 7 Mar 2015 00:22:24 +0100
Subject: [PATCH 2/6] pm: at91: move the copying the sram function to the
 sram initializationi phase
In-Reply-To: <1423709209-8108-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
 <1423709209-8108-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150306232224.GA7475@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,


On Thu, Feb 12, 2015 at 10:46:49AM +0800, Wenyou Yang wrote:
> To decrease the suspend time, move copying the sram function to the sram
> initialization phase, instead of every time go to suspend.
> 
> In the meanwhile, substitute fncpy() for memcpy().
> 
> If there is no sram allocated for PM, the PM is not supported.

My board doesn't boot anymore with this change, I am not equipped enough 
to debug more, looks like fncpy() is writing the function on top of 
existing kernel code.

You said you had issues with fncpy(), I guess I am having the issue you 
had.


Moving the function copy from at91_pm_sram_init() to at91_pm_suspend() 
fixes the problem:

-------------------------8<-----------------------------------
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 9d74c85..31339b0 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -155,6 +155,10 @@ static void at91_pm_suspend(suspend_state_t state)
 	flush_cache_all();
 	outer_disable();
 
+	/* Copy the pm suspend handler to SRAM */
+	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
+			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
+
 	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
 				at91_ramc_base[1], pm_data);
 
@@ -305,10 +309,6 @@ static void __init at91_pm_sram_init(void)
 		pr_warn("SRAM: Could not map\n");
 		return;
 	}
-
-	/* Copy the pm suspend handler to SRAM */
-	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
-			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
 static void __init at91_pm_init(void)
-------------------------8<-----------------------------------


Or using memcpy() instead of fncpy() also fixes the problem:

-------------------------8<-----------------------------------
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 9d74c85..feab89a 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -307,8 +307,8 @@ static void __init at91_pm_sram_init(void)
 	}
 
 	/* Copy the pm suspend handler to SRAM */
-	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
-			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
+	memcpy(at91_suspend_sram_fn, at91_pm_suspend_in_sram,
+					at91_pm_suspend_in_sram_sz);
 }
 
 static void __init at91_pm_init(void)
-------------------------8<-----------------------------------


It works and fixes the hard fault, but I have no clue why :(


Sylvain
