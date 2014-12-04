From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Dec 2014 11:03:57 +0100
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
Message-ID: <20141204100357.GO2129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(first I have to admit that originally my question is a bit off-topic
because I'm currently looking into the cache handling of barebox, but it
also applies to Linux, so I guess it's fine to ask here.)

Reading through ARMARM for v7-A and v7-R (ARM DDI 0406C.c, p1269) I
found:

 ==== Behavior of the caches at reset ====
 [...]
 * An implementation can require the use of a specific cache
   initialization routine to invalidate its storage array before it is
   enabled.

The breakage I'm currently seeing in barebox might well be explained by
stale I-cache entries and barebox (as of now) doesn't invalidate the
i-cache before enabling it. Looking into how Linux enables the I-cache
in the decompressor for v7[1] revealed that the caches are not cleaned
there either. (So my plan to copy from Linux failed :-)

Now I wonder if that is only an unlikely (or even theoretical) issue
that wasn't noticed up to now or if I'm missing something.

In the paragraph that the above quote is taken from, furthermore the
following is written:

 It is IMPLEMENTATION DEFINED whether an access can generate a cache hit
 when the cache is disabled.

So stale entries in the cache might even hurt before the cache is
enabled?! This would mean that you want to invalidate/flush the cache at
disable-time. Still I think doing it before enabling it in Linux would
be a good idea. And if it's only because bootloaders and (maybe worse)
boot roms cannot be trusted in this area.

What do you think?

Best regards
Uwe

[1] __armv7_mmu_cache_on in arch/arm/boot/compressed/head.S
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
