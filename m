From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 22 Aug 2012 11:23:23 -0400 (EDT)
Subject: [PATCH 0/4] [RFC] ARM: multiplatform: rename all mach headers
In-Reply-To: <201208221253.07278.arnd@arndb.de>
References: <201208221253.07278.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1208221106010.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2012, Arnd Bergmann wrote:

> I've created this series some time ago, and updated it now to
> v3.6-rc1. The idea is to get us a big step closer to the
> single zImage kernel across multiple ARM platforms by
> untangling the duplicate header file names.

Thanks for picking up this task.

> There are two branches available in the arm-soc tree:
> 
> 1. This series,
>    http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/testing/mach-headers
>    This just moves header files around and changes most of the
>    files including them. There are a few remaining drivers
>    and platform files that keep including a generic file name
>    like <mach/uncompress.h>. It remains possible to do that,
>    and I've run extensive tests to ensure I did not break
>    anything with this. However, each of these instances means
>    that there is something that stops working when you get to
>    the real multiplatform kernel and we still need to deal
>    with them one by one.

The content of <mach/uncompress.h> is fundamentally machine or SOC 
specific.  We already know it is generally incompatible with a multi 
platform kernel.  So the best way to deal with this at the moment is 
probably to just provide a dummy uncompress.h with empty stubs whenever 
CONFIG_ARCH_MULTIPLATFORM is selected.  The effect from this is that 
there wouldn't be any "Uncompressing the kernel... Done" output anymore, 
which should be an acceptable compromise until a better solution is 
found.

One problem is that some (very few) machines define a method in that 
file to keep a hardware watchdog alive.  This might not be the case for 
all the intended targets to gather in a single kernel binary image 
though.

Another issue is the fact that some platforms do very ugly 
layer-violating hacks where the decompressor selects a serial port for 
early output and then store that selection in some arbitrary memory 
location for the main kernel to blindly use, making the decompressor 
mandatory.  OMAP and Davinci are prime example of such "abuse" which 
would need to be fixed.


Nicolas
