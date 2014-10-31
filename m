From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Oct 2014 10:04:03 +0000
Subject: [PATCH] ARM: decompressor: ensure I-side picks up relocated code
In-Reply-To: <5452914E.5040905@gmail.com>
References: <1414688066-11043-1-git-send-email-will.deacon@arm.com>
 <5452914E.5040905@gmail.com>
Message-ID: <20141031100403.GA6731@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 07:28:14PM +0000, Florian Fainelli wrote:
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
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/347950

Thanks, I hadn't noticed that thread. Not sure what tag I'd add though --
Marc could ack it I suppose?

Maybe I can collect the maximal set of tags.

Will
