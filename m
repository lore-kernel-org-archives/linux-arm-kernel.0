From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Oct 2014 09:08:10 +0200
Subject: [PATCH 5/8] power: reset: at91-reset: use at91_ramc_shutdown
In-Reply-To: <1413928540-27099-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413928540-27099-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141022090810.167c470f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Tue, 21 Oct 2014 23:55:37 +0200, Alexandre Belloni wrote:

>  /*
>  * unless the SDRAM is cleanly shutdown before we hit the
>  * reset register it can be left driving the data bus and
>  * killing the chance of a subsequent boot from NAND
>  */
> -static void at91sam9260_restart(enum reboot_mode mode, const char *cmd)
> +static void at91_restart(enum reboot_mode mode, const char *cmd)
>  {
> -	asm volatile(
> -		/* Align to cache lines */
> -		".balign 32\n\t"
> -
> -		/* Disable SDRAM accesses */
> -		"str	%2, [%0, #" __stringify(AT91_SDRAMC_TR) "]\n\t"
> -
> -		/* Power down SDRAM */
> -		"str	%3, [%0, #" __stringify(AT91_SDRAMC_LPR) "]\n\t"
> +	if (at91_ramc_shutdown)
> +		at91_ramc_shutdown();
>  
> +	asm volatile(
>  		/* Reset CPU */
> -		"str	%4, [%1, #" __stringify(AT91_RSTC_CR) "]\n\t"
> +		"str	%1, [%0, #" __stringify(AT91_RSTC_CR) "]\n\t"
>  
>  		"b	.\n\t"

Are you sure this is working properly? There was a reason to have the
SDRAM controller shutdown right before resetting the CPU: the code was
ensuring that all those assembly instructions fitted in one cache line,
so that even if the SDRAM controller gets shutdown, the rest of the
code can properly execute until resetting the CPU. Now, the SDRAM
controller shutdown code and the code resetting the CPU are in
completely separate places, which break this assumption.

And also, you forgot to Cc: Maxime Ripard who did the initial work on
this at91-reset controller.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
