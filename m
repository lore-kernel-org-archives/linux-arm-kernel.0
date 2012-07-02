From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 02 Jul 2012 15:26:43 +0530
Subject: [PATCH v2 3/3] ARM: omap: clk: Remove all direct dereferencing
 of struct clk
In-Reply-To: <alpine.DEB.2.00.1206291422050.2338@utopia.booyaka.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com>
 <1340786915-29507-4-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206291422050.2338@utopia.booyaka.com>
Message-ID: <4FF1705B.6070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 June 2012 01:53 AM, Paul Walmsley wrote:
> Hi
>
> On Wed, 27 Jun 2012, Rajendra Nayak wrote:
>
>> While we move to Common Clk Framework (CCF), direct deferencing of struct
>> clk wouldn't be possible anymore. Hence get rid of all such instances
>> in the current clock code and use macros/helpers similar to the ones that
>> are provided by CCF.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> This patch generates checkpatch warnings.  Here's a sample:
>
> WARNING: quoted string split across lines
> #479: FILE: arch/arm/mach-omap2/clock.c:109:
>   		pr_debug("clock: could not associate clk %s to "
> +			 "clkdm %s\n", clk_name, clk->clkdm_name);
>
> CHECK: Alignment should match open parenthesis
> #594: FILE: arch/arm/mach-omap2/dpll3xxx.c:455:
> +	if (__clk_get_rate(dd->clk_bypass) == rate&&
>   	(clk->dpll_data->modes&  (1<<  DPLL_LOW_POWER_BYPASS))) {
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #706: FILE: arch/arm/plat-omap/include/plat/clock.h:22:
> +#define __clk_get_name(clk) clk->name
>
> In the case of the quoted string warnings, please go ahead and
> concatenate those strings while you are there.  That needs to be done
> anyway.

Ok, will do. I was able to fix all but one hard to fix CHECK for this
patch..

---
CHECK: Alignment should match open parenthesis
#608: FILE: arch/arm/mach-omap2/dpll3xxx.c:455:
+	if (__clk_get_rate(dd->clk_bypass) == rate &&
  	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {

total: 0 errors, 0 warnings, 1 checks, 608 lines checked

0003-ARM-omap-clk-Remove-all-direct-dereferencing-of-stru.patch has 
style problems, please review.

If any of these errors are false positives, please report
---

I could not find anything wrong with the alignment, but checkpatch
keeps complaining. It complains for the original code too.
Might be a checkpatch bug? Or do you really see anything wrong in
the alignment?

>
>
> - Paul
