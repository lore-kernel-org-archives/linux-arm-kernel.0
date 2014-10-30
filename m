From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Oct 2014 23:37:37 +0000
Subject: [PATCH] ARM: decompressor: ensure I-side picks up relocated code
In-Reply-To: <5452914E.5040905@gmail.com>
References: <1414688066-11043-1-git-send-email-will.deacon@arm.com>
 <5452914E.5040905@gmail.com>
Message-ID: <20141030233737.GR27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 12:28:14PM -0700, Florian Fainelli wrote:
> On 10/30/2014 09:54 AM, Will Deacon wrote:
> > To speed up decompression, the decompressor sets up a flat, cacheable
> > mapping of memory. However, when there is insufficient space to hold
> > the page tables for this mapping, we don't bother to enable the caches
> > and subsequently skip all the cache maintenance hooks.
> > 
> > Skipping the cache maintenance before jumping to the relocated code
> > allows the processor to predict the branch and populate the I-cache
> > with stale data before the relocation loop has completed (since a
> > bootloader may have SCTLR.I set, which permits normal, cacheable
> > instruction fetches regardless of SCTLR.M).
> > 
> > This patch moves the cache maintenance check into the maintenance
> > routines themselves, allowing the v6/v7 versions to invalidate the
> > I-cache regardless of the MMU state.
> > 
> > Cc: Julien Grall <julien.grall@linaro.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> I guess we could credit Marc as well for reporting and providing early
> patches addressing this?

If we're going to start doing that, then it should also have:

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>

since Will and myself discussed it earlier today and I suggested moving
the tst check into the cache_clean_flush methods as a way to solve this
issue.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
