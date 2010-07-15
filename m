From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 15 Jul 2010 13:02:14 -0700
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <4C3C72C6.4000005@canonical.com>
References: <4C3C72C6.4000005@canonical.com>
Message-ID: <20100715130214.4c9303b2.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc linux-arm-kernel)

On Tue, 13 Jul 2010 15:05:58 +0100
Lee Jones <lee.jones@canonical.com> wrote:

> >From 219005d9522043bc42ddb51d59688959eed0d443 Mon Sep 17 00:00:00 2001
> From: Lee Jones <lee.jones@canonical.com>
> Date: Tue, 13 Jul 2010 15:02:17 +0100
> Subject: [PATCH] UBUNTU: [Upstream] Stop ARM boards crashing when CUPS is loaded
> 
> BugLink: http://bugs.launchpad.net/bugs/601226
> 
> When CUPS loads, it tries to load several drivers that it may need.
> When one of these drivers, specifically parport_pc is loaded on ARM
> based systems, it causes a segmentation fault as the ISA addresses
> which are attempted are not writable on non-PC based architectures.
> This code prevents ISA addresses from being attempted except on x86.
> 

That sounds like a pretty serious problem.  But presumably it isn't -
otherwise it would have been fixed earlier!

So what actions are required to trigger this bug and why aren't others
seeing it?

>  arch/arm/include/asm/parport.h |    7 +++++--

This should probably go via the arm tree.

> 
> diff --git a/arch/arm/include/asm/parport.h b/arch/arm/include/asm/parport.h
> index 26e94b0..a1874f8 100644
> --- a/arch/arm/include/asm/parport.h
> +++ b/arch/arm/include/asm/parport.h
> @@ -9,10 +9,13 @@
>  #ifndef __ASMARM_PARPORT_H
>  #define __ASMARM_PARPORT_H
>  
> -static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
>  static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)

It's strange that this function isn't marked inline.  It's in a .h
file.  But many arch/*/include/asm/parport.h's do it this way.  They're
probably broken.  It adds a risk that unneeded code will be generated
into each compilation unit which includes these headers, although gcc
can probably fix that, depending on the version.  Plus it's plain odd.

>  {
> -	return parport_pc_find_isa_ports (autoirq, autodma);
> +/* parport_pc_find_isa_ports uses direct register addresses which are
> + * only correct on x86 architectures. This may have undesirable
> + * consequences (including segfaults) when used on other architectures.
> + */
> +	return 0;
>  }

That comment layout is whacky.  I did this:

--- a/arch/arm/include/asm/parport.h~parport-prevent-arm-boards-frmo-crashing-when-cups-is-loaded-fix
+++ a/arch/arm/include/asm/parport.h
@@ -9,12 +9,13 @@
 #ifndef __ASMARM_PARPORT_H
 #define __ASMARM_PARPORT_H
 
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
+static int __devinit parport_pc_find_nonpci_ports(int autoirq, int autodma)
 {
-/* parport_pc_find_isa_ports uses direct register addresses which are
- * only correct on x86 architectures. This may have undesirable
- * consequences (including segfaults) when used on other architectures.
- */
+	/*
+	 * parport_pc_find_isa_ports() uses direct register addresses which are
+	 * only correct on x86 architectures. This may have undesirable
+	 * consequences (including segfaults) when used on other architectures.
+	 */
 	return 0;
 }
 
_
