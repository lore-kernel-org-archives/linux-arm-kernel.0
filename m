From: robherring2@gmail.com (Rob Herring)
Date: Fri, 19 Apr 2013 16:32:40 -0500
Subject: [PATCH v3] ARM: default machine descriptor for multiplatform
In-Reply-To: <201304191640.32139.arnd@arndb.de>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <20130419132848.GO14496@n2100.arm.linux.org.uk>
 <201304191621.54681.arnd@arndb.de> <201304191640.32139.arnd@arndb.de>
Message-ID: <5171B7F8.4040601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 09:40 AM, Arnd Bergmann wrote:
> Since we now have default implementations for init_time and init_irq,
> the init_machine callback is the only one that is not yet optional,
> but since simple DT based platforms all have the same
> of_platform_populate function call in there, we can consolidate them
> as well, and then actually boot with a completely empty machine_desc.
> Unofortunately we cannot just default to an empty init_machine: We
> cannot call of_platform_populate before init_machine because that
> does not work in case of auxdata, and we cannot call it after
> init_machine either because the machine might need to run code
> after adding the devices.
> 
> To take the final step, this adds support for booting without defining
> any machine_desc whatsoever.
> 
> For the case that CONFIG_MULTIPLATFORM is enabled, it adds a
> global machine descriptor that never matches any machine but is
> used as a fallback if nothing else matches. We assume that without
> CONFIG_MULTIPLATFORM, we only want to boot on the systems that the kernel
> is built for, so we still retain the build-time warning for missing
> machine descriptors and the run-time warning when the platform does not
> match in that case.
> 
> In the case that we run on a multiplatform kernel and the machine
> provides a fully populated device tree, we attempt to keep booting,
> hoping that no machine specific callbacks are necessary.
> 
> Finally, this also removes the misguided "select ARCH_VEXPRESS" that
> was only added to avoid a build error for allnoconfig kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>

[...]

>  	if (machine_desc->init_machine)
>  		machine_desc->init_machine();
> +	else
> +		of_platform_populate(NULL, of_default_bus_match_table,

This will fail to build for !OF. of_platform.h needs this:

#define of_default_bus_match_table NULL

You may need some struct forward declarations, but this commit in my
tree for 3.10 should fix those:

commit d450f445f9a654080a6be4094376c2192d9a1f36
Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date:   Tue Feb 19 02:58:25 2013 +0300

    <linux/of_platform.h>: fix compilation warnings with DT disabled


Rob

> +					NULL, NULL);
>  	return 0;
>  }
>  arch_initcall(customize_machine);
> 
