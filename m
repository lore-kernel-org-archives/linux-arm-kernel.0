From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:44:19 +0000
Subject: [PATCH 022/493] ARM: remove CONFIG_HOTPLUG ifdefs
In-Reply-To: <1353349642-3677-22-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-22-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121114419.GB3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:19:31PM -0500, Bill Pemberton wrote:
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 9b72261..f136307 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -361,9 +361,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
>  		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
>  }
> -#ifdef CONFIG_HOTPLUG
> +
>  EXPORT_SYMBOL(pcibios_fixup_bus);
> -#endif
> +

This looks fine.

> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b9f38e3..38279fe 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -66,10 +66,8 @@ SECTIONS
>  		ARM_EXIT_DISCARD(EXIT_TEXT)
>  		ARM_EXIT_DISCARD(EXIT_DATA)
>  		EXIT_CALL
> -#ifndef CONFIG_HOTPLUG
>  		*(.ARM.exidx.devexit.text)
>  		*(.ARM.extab.devexit.text)
> -#endif

This to me looks wrong.  Do we want to unconditionally discard devexit
debugging?

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d1ea7ce..856b58d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -74,13 +74,8 @@
>   * are handled as text/data or they can be discarded (which
>   * often happens at runtime)
>   */
> -#ifdef CONFIG_HOTPLUG
>  #define DEV_KEEP(sec)    *(.dev##sec)
>  #define DEV_DISCARD(sec)

I hope there will be a follow-on patch to remove the DEV_KEEP() and
DEV_DISCARD() stuff entirely?
