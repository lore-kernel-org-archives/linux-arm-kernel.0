From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 7 Dec 2014 02:30:31 +0530
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
In-Reply-To: <20141204100357.GO2129@pengutronix.de>
References: <20141204100357.GO2129@pengutronix.de>
Message-ID: <20141206210031.GA1758@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Dec 04, 2014 at 11:03:57AM +0100, Uwe Kleine-K?nig wrote:

> The breakage I'm currently seeing in barebox might well be explained by
> stale I-cache entries and barebox (as of now) doesn't invalidate the
> i-cache before enabling it. Looking into how Linux enables the I-cache
> in the decompressor for v7[1] revealed that the caches are not cleaned
> there either. (So my plan to copy from Linux failed :-)
> 
> Now I wonder if that is only an unlikely (or even theoretical) issue
> that wasn't noticed up to now or if I'm missing something.

> So stale entries in the cache might even hurt before the cache is
> enabled?! This would mean that you want to invalidate/flush the cache at
> disable-time. Still I think doing it before enabling it in Linux would
> be a good idea. And if it's only because bootloaders and (maybe worse)
> boot roms cannot be trusted in this area.

Are you sure that stale I-cache is causing the issue ?, but
D-cache should not have stale data - it is a pre-requisite for
booting the Kernel [1,2] (though not in Booting documentation)

We were troubled by this issue when Kernel was loaded directly w/o
bootloader, since D-cache was not invalidated, upon enabling,
due to stale data Kernel was crashing randomly

Did want to patch it for long time, but then with cash invalidation
and all it never happened ;)

Regards
Afzal

[1] http://www.arm.linux.org.uk/developer/booting.php
[2] http://comments.gmane.org/gmane.linux.ports.arm.kernel/77718

---------------------------------8<--------------------------------------
diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 371814a36719..c4c423164d5e 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -193,6 +193,7 @@ In any case, the following conditions must be met:
   The MMU must be off.
   Instruction cache may be on or off.
   Data cache must be off.
+  Data cache should be invalidated.
 
   If the kernel is entered in HYP mode, the above requirements apply to
   the HYP mode configuration in addition to the ordinary PL1 (privileged
