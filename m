From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 26 Apr 2015 21:10:22 +0200
Subject: [PATCH v5 1/3] ARM: pxa: pxa_cplds: add lubbock and mainstone IO
In-Reply-To: <1429996403-13644-2-git-send-email-robert.jarzmik@free.fr>
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
 <1429996403-13644-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1430075422.2927.131.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-04-25 at 23:13 +0200, Robert Jarzmik wrote:
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
 
> +config PXA_SYSTEMS_CPLDS
> +	bool "Motherboard cplds"
> +	def_bool ARCH_LUBBOCK || MACH_MAINSTONE

Just
	default ARCH_LUBBOCK || MACH_MAINSTONE

should be enough.

> +	select MFD_CORE
> +	help
> +	  This driver supports the Lubbock and Mainstone multifunction chip
> +	  found on the pxa25x development platform system (Lubbock) and pxa27x
> +	  development platform system (Mainstone). This IO board supports the
> +	  interrupts handling, ethernet controller, flash chips, etc ...

> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
 
> +obj-$(CONFIG_PXA_SYSTEMS_CPLDS)	+= pxa_cplds_irqs.o

PXA_SYSTEMS_CPLDS is a bool symbol, so pxa_cplds_irqs.o will never be
part of a module, correct?

> --- /dev/null
> +++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c

> +#include <linux/module.h>

Since this is built-in only code this include is probably unneeded.

> +MODULE_DEVICE_TABLE(of, cplds_id_table);

MODULE_DEVICE_TABLE() will be preprocessed away for built-in only code.

> +module_platform_driver(cplds_driver);

Speaking from memory: for built-in only code this is equivalent to
having a wrapper that only calls
	platform_driver_register(&cplds_driver);

and have that wrapper marked as
	device_initcall()

> +MODULE_DESCRIPTION("PXA Cplds interrupts driver");
> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
> +MODULE_LICENSE("GPL");

These three macros will effectively be preprocessed away for built-in
only code.

Thanks,


Paul Bolle
