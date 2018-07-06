From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jul 2018 14:00:55 +0100
Subject: [PATCH] ARM: module: fix modsign build error
In-Reply-To: <20180706124900.3294525-1-arnd@arndb.de>
References: <20180706124900.3294525-1-arnd@arndb.de>
Message-ID: <20180706130055.GY17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 02:48:47PM +0200, Arnd Bergmann wrote:
> The asm/module.h header file can not be included standalone, which
> breaks the module signing code after a recent change:
> 
> In file included from kernel/module-internal.h:13,
>                  from kernel/module_signing.c:17:
> arch/arm/include/asm/module.h:37:27: error: 'struct module' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
> 
> This adds a forward declaration of struct module to make it all work.
> 
> Fixes: f314dfea16a0 ("modsign: log module name in the event of an error")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We used to have a general rule that where an asm/foo.h header and
linux/foo.h header exists, and the linux/foo.h includes the asm/foo.h,
then the linux/foo.h header will be used for including in .c files
rather than the asm/ version of the same.  Is there a reason why
that can't be done here?

That said, adding this is no bad thing.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
> I guess it would be useful if Jessica can pick this change up
> in her tree that introduced the warning.
> ---
>  arch/arm/include/asm/module.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 89ad0596033a..9e81b7c498d8 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -34,6 +34,7 @@ struct mod_arch_specific {
>  #endif
>  };
>  
> +struct module;
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
>  
>  /*
> -- 
> 2.9.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
