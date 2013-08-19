From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 00:24:11 +0100
Subject: [PATCH resend] ARM: nommu: remove ARCH_MULTIPLATFORM's
 dependency on CONFIG_MMU
In-Reply-To: <1374597712-18112-1-git-send-email-jonathan.austin@arm.com>
References: <1374597712-18112-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20130819232411.GX23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 05:41:51PM +0100, Jonathan Austin wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ARCH_MULTIPLATFORM currently requires CONFIG_MMU to be set, however it is
> intended that all future V6/V7 platforms are compatible with
> ARCH_MULTIPLATFORM, and so this requirement precludes that addition of new
> !MMU platforms.
> 
> Furthermore, this requirement creates unnecessary differences between the MMU
> and !MMU worlds, which is undesirable.
> 
> This patch allows ARCH_MULTIPLATFORM to remain selected in a !MMU
> configuration. There is still a need to hardcode CONFIG_DRAM_BASE and other
> parameters relating to the system, so this patch is less about making an
> actual multiplatform kernel for !MMU and more about consistency across the
> kernel.
> 
> Along with the nommu-fixes, R7 support and MPU support already sent to this
> list, this patch is sufficient to allow building and booting of kernel for a
> Cortex-R7 core on a Versatile Express platform.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
> 
> This patch was written by Arnd and after some discussion/testing at my end he
> asked me to send it to the list with a full description.
> 
> I'm resending this after testing it still allows R7 to boot on 3.11.
> 
> Assuming no comments, I'll drop this in the patch system shortly. Any
> calls for Cc-ing stable?

No, this is not a stable issue.  Stable is for fixing regressions, it's
not for features, and as this is something that has never been in any
kernel, it can't be claimed to be fixing a regression.

Now, here's the question: can multiplatform ever work properly on nommu?

We get multiplatform working on MMU by using the MMU to provide a more
consistent view of the system.  On noMMU, we don't have that.  So if
your kernel is built to run assuming that it will be located in ram at
location X on platform Y, that isn't going to work if platform Z doesn't
have RAM there.

My feeling is that the motivation behind this patch is to avoid an
amount of yuckyness associated with trying to enable Versatile Express
support outside of the multiplatform container - it's not really about
being able to build a single zImage which works on all noMMU platforms.
So, I don't think this is the right solution to this problem.

The quick way to solve this is to append || !MMU to:

	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7

but this still leaves us in the situation where we can select multiple
incompatible platforms.  That I don't really have an answer for.

However, one thing I am certain of is that faking things by allowing
multiplatform support for platforms which can't be multiplatform is
the wrong approach.
