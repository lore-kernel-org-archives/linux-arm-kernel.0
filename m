From: asavkov@redhat.com (Artem Savkov)
Date: Fri, 4 Nov 2016 09:35:19 +0100
Subject: arm64 build failure with CONFIG_ARM64_LSE_ATOMICS=y
In-Reply-To: <20161103184624.GA695@e104818-lin.cambridge.arm.com>
References: <20161102164427.GB24243@shodan.usersys.redhat.com>
 <20161102232854.GO22791@arm.com>
 <1efb101a-a8ab-5ad9-f2bd-e7d485c71904@arm.com>
 <20161103111238.GC24243@shodan.usersys.redhat.com>
 <20161103184624.GA695@e104818-lin.cambridge.arm.com>
Message-ID: <20161104083519.GD24243@shodan.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 06:46:25PM +0000, Catalin Marinas wrote:
> On Thu, Nov 03, 2016 at 12:12:38PM +0100, Artem Savkov wrote:
> > On Thu, Nov 03, 2016 at 10:39:43AM +0000, Suzuki K Poulose wrote:
> > > On 02/11/16 23:28, Will Deacon wrote:
> > > > On Wed, Nov 02, 2016 at 05:44:27PM +0100, Artem Savkov wrote:
> > > > > Looks like your patch "efd9e03 arm64: Use static keys for CPU features"
> > > > > breaks arm64 build with "CONFIG_ARM64_LSE_ATOMICS=y" because it creates a
> > > > > circular dependency for asm/lse.h through jump_label.h:
> [...]
> > Apparently it fails with an older gcc (4.8.5), but doesn't with 6.2.0.
> > The different bit is that with 4.8.5 I don't have CC_HAVE_ASM_GOTO set.
> > It is reproducible with 6.2.0 if you manually remove CC_HAVE_ASM_GOTO.
> 
> -----------8<----------------
> From e27eb40cd5af38f1a5e64553a367220f00a1b5d8 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 3 Nov 2016 18:34:34 +0000
> Subject: [PATCH] arm64: Fix circular include of asm/lse.h through
>  linux/jump_label.h
> 
> Commit efd9e03facd0 ("arm64: Use static keys for CPU features")
> introduced support for static keys in asm/cpufeature.h, including
> linux/jump_label.h. When CC_HAVE_ASM_GOTO is not defined, this causes a
> circular dependency via linux/atomic.h, asm/lse.h and asm/cpufeature.h.
> 
> This patch moves the capability macros out out of asm/cpufeature.h into
> a separate asm/cpucaps.h and modifies some of the #includes accordingly.
> 
> Fixes: efd9e03facd0 ("arm64: Use static keys for CPU features")
> Reported-by: Artem Savkov <asavkov@redhat.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/alternative.h |  2 +-
>  arch/arm64/include/asm/cpucaps.h     | 40 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/cpufeature.h  | 20 +-----------------
>  arch/arm64/include/asm/lse.h         |  1 -
>  4 files changed, 42 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cpucaps.h

Tested-by: Artem Savkov <asavkov@redhat.com>

The patch fixes the issue. Thanks.

-- 
Regards,
  Artem
