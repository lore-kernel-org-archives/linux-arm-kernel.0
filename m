From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 12 Nov 2015 18:54:41 +0100
Subject: [PATCH v2 3/3] ARM: BCM5301X: remove workaround imprecise abort
 fault handler
In-Reply-To: <1447335439.3101.8.camel@pengutronix.de>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-4-git-send-email-l.stach@pengutronix.de>
 <1447335439.3101.8.camel@pengutronix.de>
Message-ID: <5644D261.2090605@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

can you please take this patch for 4.4.

I do not have an own tree, Florian takes the patches for BCM5301X

Hauke

On 11/12/2015 02:37 PM, Lucas Stach wrote:
> Hauke,
> 
> can you please take this patch through your tree for 4.4? The first
> patch in this series went in through Russells tree, so the below code
> now has the possibility to hide a real abort later during boot.
> 
> Regards,
> Lucas
> 
> Am Donnerstag, den 15.10.2015, 12:32 +0200 schrieb Lucas Stach:
>> This is not needed anymore. Handling a potentially pending imprecise external
>> abort left behind by the bootloader is now done in a slightly safer way inside
>> the common ARM startup code.
>>
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/arm/mach-bcm/bcm_5301x.c | 35 -----------------------------------
>>  1 file changed, 35 deletions(-)
>>
>> diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
>> index 5478fe6bcce6..c8830a2b0d60 100644
>> --- a/arch/arm/mach-bcm/bcm_5301x.c
>> +++ b/arch/arm/mach-bcm/bcm_5301x.c
>> @@ -9,40 +9,6 @@
>>  #include <asm/hardware/cache-l2x0.h>
>>  
>>  #include <asm/mach/arch.h>
>> -#include <asm/siginfo.h>
>> -#include <asm/signal.h>
>> -
>> -
>> -static bool first_fault = true;
>> -
>> -static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
>> -				 struct pt_regs *regs)
>> -{
>> -	if ((fsr == 0x1406 || fsr == 0x1c06) && first_fault) {
>> -		first_fault = false;
>> -
>> -		/*
>> -		 * These faults with codes 0x1406 (BCM4709) or 0x1c06 happens
>> -		 * for no good reason, possibly left over from the CFE boot
>> -		 * loader.
>> -		 */
>> -		pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
>> -			addr, fsr);
>> -
>> -		/* Returning non-zero causes fault display and panic */
>> -		return 0;
>> -	}
>> -
>> -	/* Others should cause a fault */
>> -	return 1;
>> -}
>> -
>> -static void __init bcm5301x_init_early(void)
>> -{
>> -	/* Install our hook */
>> -	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, BUS_OBJERR,
>> -			"imprecise external abort");
>> -}
>>  
>>  static const char *const bcm5301x_dt_compat[] __initconst = {
>>  	"brcm,bcm4708",
>> @@ -52,6 +18,5 @@ static const char *const bcm5301x_dt_compat[] __initconst = {
>>  DT_MACHINE_START(BCM5301X, "BCM5301X")
>>  	.l2c_aux_val	= 0,
>>  	.l2c_aux_mask	= ~0,
>> -	.init_early	= bcm5301x_init_early,
>>  	.dt_compat	= bcm5301x_dt_compat,
>>  MACHINE_END
> 
