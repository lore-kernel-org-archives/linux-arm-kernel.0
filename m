From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 May 2013 18:09:48 +0800
Subject: [PATCH 1/6] ARM: tegra: add an assembly marco to check Tegra
 SoC ID
In-Reply-To: <51940FA4.6050609@wwwdotorg.org>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-2-git-send-email-josephl@nvidia.com>
 <51940FA4.6050609@wwwdotorg.org>
Message-ID: <1368698988.7403.25.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-16 at 06:43 +0800, Stephen Warren wrote:
> On 05/15/2013 04:27 AM, Joseph Lo wrote:
> > There are some Tegra SoC ID checking code around the low level assembly
> > code. Adding a marco to replace them. For the single image to support all
> > the Tegra series, we may also need the marco in other common code. So we
> > make it become a marco for the usage.
> 
> I'm not sure this patch doesn't obfuscate the code too much. The big
> issue I see is:
> 
> > @@ -115,13 +112,9 @@ ENTRY(__tegra_cpu_reset_handler)
> >  
> >  	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
> >  
> > -	mov32	r6, TEGRA_APB_MISC_BASE
> > -	ldr	r6, [r6, #APB_MISC_GP_HIDREV]
> > -	and	r6, r6, #0xff00
> > -#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> > -t20_check:
> > -	cmp	r6, #(0x20 << 8)
> > +	tegra_check_soc_id TEGRA20, TEGRA_APB_MISC_BASE, r6, r5
> 
> Here, we replace all the code with the new macro, ...
> 
> >  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
> >  	/* Are we on Tegra20? */
> > -	cmp	r6, #(0x20 << 8)
> > +	cmp	r6, #(TEGRA20 << 8)
> 
> But here we still have to write out the cmp instructions.
> 
The marco did "cmp" once and move the soc_id into r6. But the flags may
be changed after running some other codes, we need to "cmp" again to get
the correct flag.

> It may be reasonable to create a macro to read/mask/shift the SoC ID,
> similar to the existing cpu_id macro, i.e. roughly:
> 
> /* Macro to check Tegra revision */
> +#define APB_MISC_GP_HIDREV	0x804
> +.macro tegra_soc_id base, tmp1, tmp2
> +	mov32	\tmp2, \base
> +	ldr	\tmp1, [\tmp2, #APB_MISC_GP_HIDREV]
> +	and	\tmp1, \tmp1, #0xff00
> +.endm
> 
> Also, I wonder:
> 
> (a) why the need to pass TEGRA_APB_MISC_BASE into the macro; can't the
> macro just hard-code that value since it's always the same?
> 
Because this marco will be used in virtual address space too, I need to
pass different base addr here.

> (b) Why need two registers passed to the macro. At least one of the code
> segments you've replaced with the macro uses a single register instead:
> 
> -	mov32	r6, TEGRA_APB_MISC_BASE
> -	ldr	r6, [r6, #APB_MISC_GP_HIDREV]
> -	and	r6, r6, #0xff00
> 
> Wouldn't that be a better implementation of the macro? I don't think
> relying on \tmp2 containing "base" after the macro invocation would be a
> good idea, since that's rather like looking inside the black box.

OK. I can remove one tmp register here.
