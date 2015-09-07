From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Sep 2015 09:56:36 +0100
Subject: [RFC PATCH] arm64: cpuinfo: reduce cache contention on
 update_{feature}_support
In-Reply-To: <55E9C876.7080405@gmail.com>
References: <1441382651-12058-1-git-send-email-ynorov@caviumnetworks.com>
 <55E9C876.7080405@gmail.com>
Message-ID: <20150907085636.GA10645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 09:36:06AM -0700, David Daney wrote:
> On 09/04/2015 09:04 AM, Yury Norov wrote:
> >This patch is on top of https://lkml.org/lkml/2015/9/2/413
> >
> >In master, there's only a single function -
> >	update_mixed_endian_el0_support
> >And similar function is on review mentioned above.
> >
> >The algorithm for them is like this:
> >  - there's system-wide boolean marker for the feature that is
> >    initially enabled;
> >  - there's also updater for the feature that may disable it
> >    system-widely if feature is not supported on current CPU.
> >  - updater is called for each CPU on bootup.
> >
> >The problem is the way updater does its work. On each CPU, it
> >unconditionally updates system-wide marker. For multi-core
> >system it makes CPU issue invalidate message for a cache
> >line containing marker. This invalidate increases cache
> >contention for nothing, because there's a single marker reset
> >that is really needed, and the others are useless.
> >
> >If the number of system-wide markers of this sort will grow,
> >it may become a trouble on large-scale SOCs. The fix is trivial,
> >though: do system-wide marker update conditionally, and preserve
> >corresponding cache line in shared state for all update() calls,
> >except, probably, one.
> >
> >Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> >---
> >  arch/arm64/kernel/cpuinfo.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >index 4a6ae31..9972c1e 100644
> >--- a/arch/arm64/kernel/cpuinfo.c
> >+++ b/arch/arm64/kernel/cpuinfo.c
> >@@ -87,12 +87,14 @@ bool system_supports_aarch32_el0(void)
> >
> >  static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
> >  {
> >-	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
> >+	if (mixed_endian_el0 && !id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0))
> >+		mixed_endian_el0 = false;
> >  }
> >
> >  static void update_aarch32_el0_support(struct cpuinfo_arm64 *info)
> >  {
> >-	aarch32_el0 &= id_aa64pfr0_aarch32_el0(info->reg_id_aa64pfr0);
> >+	if (aarch32_el0 && !id_aa64pfr0_aarch32_el0(info->reg_id_aa64pfr0))
> >+		aarch32_el0 = false;
> >  }
> 
> How many times in the lifetime of the kernel are these functions called?
> 
> If it is just done at startup, then there is no "steady state" performance
> impact, and the burden of complicating the code may not be worthwhile.

I fully agree. Unless the code is on some hot path, I really don't care
about few cycles potentially saved during boot.

And in general, with any such micro optimisations, I want to see
benchmark results to prove it worth.

-- 
Catalin
