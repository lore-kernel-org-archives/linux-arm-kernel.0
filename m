From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 09:32:09 +0000
Subject: [PATCH 0/0] RFC: ARM: Thumb-2: Symbol manipulation macros for
	function body copying
In-Reply-To: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110112093209.GA18833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:02:30PM -0600, Dave Martin wrote:
> To make it easier to deal with cases like this, I've had a
> go at writing some macros to make copying function bodies
> easier, while being robust for ARM and Thumb-2.

How about instead providing some infrastructure which coes the
copy too?  Something like:

#define copy_fn_to_sram(to, fn, size) ({		\
	__typeof__(fn) f;				\
	unsigned long ptr;				\
	__asm__("" : "=r" (ptr) : "0" (fn));		\
	memcpy(to, (void *)(ptr & ~1), size);		\
	ptr = (ptr & 1) | (unsigned long)to;		\
	__asm__("" : "=r" (f) : "0" (ptr));		\
	f;						\
})

Used by:
extern void my_func(int foo);
extern int my_func_size;

void call_my_func(void *to, int arg)
{
	void (*fn)(int);

	fn = copy_fn_to_sram(to, my_func, my_func_size);
	fn(arg);
}

Then if you need to fix the way the copies are done for some
architectural reason, there's only one place to do it.

I'm not sure asm/unified.h is the right place - I don't think this has
anything to do with the unified assembler syntax.  Please create a new
header for this.
