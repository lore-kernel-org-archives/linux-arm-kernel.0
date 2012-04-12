From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 12 Apr 2012 12:37:14 -0500
Subject: Question about return_address()
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206986C0886@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I have a question about the return_address() function.

In arch/arm/include/asm/ftrace.h we have this (comment removed):


#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)

void *return_address(unsigned int);

#else

extern inline void *return_address(unsigned int level)
{
	return NULL;
}

#endif


And in arch/arm/kernel/return_address.c we have this (only relevant
parts):


#include <linux/ftrace.h>

#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)

void *return_address(unsigned int level)
{
	...
}

#else /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */

#if defined(CONFIG_ARM_UNWIND)
#warning "TODO: return_address should use unwind tables"
#endif

void *return_address(unsigned int level)
{
	return NULL;
}

#endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) / else */

EXPORT_SYMBOL_GPL(return_address);


It appears that when CONFIG_FRAME_POINTER is set and CONFIG_ARM_UNWIND
is not the function is declared twice, once as an inline in the header and again as an
exported function in the source.

Is this a problem which should be fixed?

Right now it's producing a sparse warning:

	warning: symbol 'return_address' was not declared. Should it be static?

Regards,
Hartley
