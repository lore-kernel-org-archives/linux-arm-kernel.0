From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Sep 2016 10:19:47 +0100
Subject: [RFCv3][PATCH 3/5] arm64: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <1473715978-11633-4-git-send-email-labbott@redhat.com>
References: <1473715978-11633-1-git-send-email-labbott@redhat.com>
 <1473715978-11633-4-git-send-email-labbott@redhat.com>
Message-ID: <20160913091946.GB7467@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Mon, Sep 12, 2016 at 02:32:56PM -0700, Laura Abbott wrote:
> 
> arm64 may need to guarantee the caches are synced. Implement versions of
> the kernel_force_cache API to allow this.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Switch to calling cache operations directly instead of relying on
> DMA mapping.
> ---
>  arch/arm64/include/asm/cacheflush.h |  8 ++++++++
>  arch/arm64/mm/cache.S               | 24 ++++++++++++++++++++----
>  arch/arm64/mm/flush.c               | 11 +++++++++++
>  3 files changed, 39 insertions(+), 4 deletions(-)

I'm really hesitant to expose these cache routines as an API solely to
support a driver sitting in staging/. I appreciate that there's a chicken
and egg problem here, but we *really* don't want people using these routines
in preference to the DMA API, and I fear that we'll simply grow a bunch
more users of these things if we promote it as an API like you're proposing.

Can the code not be contained under staging/, as part of ion?

Will
