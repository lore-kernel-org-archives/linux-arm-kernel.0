From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Dec 2009 14:58:49 +0100
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <4B213627.5000007@caviumnetworks.com>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091210175007.GC13210@n2100.arm.linux.org.uk>
	<4B213627.5000007@caviumnetworks.com>
Message-ID: <20091216135849.GC3674@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Thu, Dec 10, 2009 at 09:55:51AM -0800, David Daney wrote:
> Russell King - ARM Linux wrote:
>> On Tue, Dec 08, 2009 at 10:55:38AM +0100, Uwe Kleine-K?nig wrote:
>>> Use the new unreachable() macro instead of for(;;);
>>
>> Have you investigated what effect this has on generated code?
>
> Yes.
>
> Pre GCC-4.5 the generated code should be identical as 'unreachable()'  
> just expands to 'for(;;);' in this case.
>
> Post GCC-4.5 the generated code should be smaller.
I don't have a toolchain using gcc 4.5.

What should we do with this patch?  I think in theory the patch is OK.
And for pre gcc-4.5 it should not make any difference as we have in
include/linux/compiler-gcc4.h:

#if __GNUC_MINOR__ >= 5
...
#define unreachable() __builtin_unreachable()
#endif

and in include/linux/compiler.h:

#ifndef unreachable
# define unreachable() do { } while (1)
#endif

So the only impact if that

	do { } while (1)

is used instead of

	for(;;)

.  My toolchain (based on 4.3.2) produces the same object files with and
without the patch.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
