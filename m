From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:24:38 +0000
Subject: [PATCH 02/41] ARM: restart: remove poodle restart handler
In-Reply-To: <E1RN6hx-0001Wh-C9@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6hx-0001Wh-C9@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117172438.GY9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:40:37PM +0000, Russell King - ARM Linux wrote:
> The poodle restart handler was added in 74617fb6b8 (3593/1: Add reboot
> and shutdown handlers for Zaurus handhelds), and at that time it was
> necessary to deal with the RCSR register.  This commit also forced all
> restarts to use the 'hard' restart method.
> 
> In dc38e2ad53 (pxa: Fix RCSR handling), the RCSR handling was removed,
> leaving just the forcing to use a 'hard' restart.  As hard restarts are
> the default (in the absense of a reboot= command line argument), this
> seems pointless.  In any case, Richard Purdie says:
> 
> > From what I remember that hardware either always reboots or always
> > halts. I think the option was therefore left hardcoded to make it clear
> > it wasn't expected to work. Later Zaurii models could do either but
> > required some manual poking of registers to make it happen iirc.
> >
> > Regardless, you can probably clean this up as you suggest now.
> 
> So, lets remove the unnecessary interception and rely on the default
> restart mode.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-pxa/poodle.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 948ce3e..1c597ad 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -419,17 +419,11 @@ static void poodle_poweroff(void)
>  	arm_machine_restart('h', NULL);
>  }
>  
> -static void poodle_restart(char mode, const char *cmd)
> -{
> -	arm_machine_restart('h', cmd);
> -}
> -
>  static void __init poodle_init(void)
>  {
>  	int ret = 0;
>  
>  	pm_power_off = poodle_poweroff;
> -	arm_pm_restart = poodle_restart;
>  
>  	PCFR |= PCFR_OPDE;
>  
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
