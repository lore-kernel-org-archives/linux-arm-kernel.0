From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 28 May 2015 11:48:50 +0100
Subject: [PATCH RFC] ARM: use -marm unconditionally for THUMB2_KERNEL=n
 builds
In-Reply-To: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150528104729.GB3655@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 11:42:07AM +0200, Uwe Kleine-K?nig wrote:
> When using a toolchain that defaults to v7-m code generation using
> cc-option fails to add -marm because it conflicts with the default cpu
> type:
> 
> 	$ echo > test.c
> 	$ arm-cortexm3-uclinuxeabi-gcc -marm -c test.c
> 	test.c:1:0: error: target CPU does not support ARM mode
> 
> resulting in errors like
> 
> 	Error: selected processor does not support Thumb mode `mrs r1,cpsr'
> 
> Dropping the use of cc-option and using -marm unconditionally works fine
> for this compiler because it's only ever used together with $(arch-y)
> (e.g. -march=armv4).

cc-option passes the compiler flags already selected via KBUILD_CFLAGS,
so hoisting some of the append to KBUILD_CFLAGS earlier would probably
help:

KBUILD_CFLAGS += $(CFLAGS_ABI) $(arch-y) $(tune-y)

...

CFLAGS_ISA := $(call cc-option,-marm,)

...

KBUILD_CFLAGS += $(CFLAGS_ISA)


That should remove any risk of toolchain incompatibility -- but I've
not tested it...

Cheers
---Dave

[...]
