From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 17:15:06 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <1329169408-17253-14-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EFA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
> 
> Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
>
> Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
> platforms don't need mach/io.h, but ebsa110 does. Most PCI platforms need
> mach/io.h for now, but ks8695 doesn't which means it's broken? omap has a
> lot of other stuff in its io.h, so it also needs io.h until it is cleaned
> up.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

<snip>

> +#ifdef CONFIG_NEED_MACH_IO_H
>  #include <mach/io.h>
> +#else
> +#define __io(a)		({ (void)(a); __typesafe_io(0); })
> +#define __mem_pci(a)	(a)
> +#endif

Rob,

I compile and boot tested these patches on EP93xxbut did not check them
with sparse.

Most of the mach/io.h headers you remove in Patch 14/15 have the __io
macro defined like:

#define __io(a)		__typesafe_io(a)

Does your change above still keep the __io macro typesafe?

They don't appear equivalent to me...

Regards,
Hartley
