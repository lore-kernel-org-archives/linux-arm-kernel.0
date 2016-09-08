From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Sep 2016 14:40:25 +0100
Subject: [PATCH v2 2/2] arm64: Use static keys for CPU features
In-Reply-To: <48d10fa1-ee4c-e398-b5ae-9815bf0f18eb@akamai.com>
References: <1473096348-19548-1-git-send-email-catalin.marinas@arm.com>
 <1473096348-19548-3-git-send-email-catalin.marinas@arm.com>
 <48d10fa1-ee4c-e398-b5ae-9815bf0f18eb@akamai.com>
Message-ID: <20160908134025.2nq3e5ohienesrae@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 12:59:52PM -0400, Jason Baron wrote:
> On 09/05/2016 01:25 PM, Catalin Marinas wrote:
> > This patch adds static keys transparently for all the cpu_hwcaps
> > features by implementing an array of default-false static keys and
> > enabling them when detected. The cpus_have_cap() check uses the static
> > keys if the feature being checked is a constant, otherwise the compiler
> > generates the bitmap test.
> > 
> > Because of the early call to static_branch_enable() via
> > check_local_cpu_errata() -> update_cpu_capabilities(), the jump labels
> > are initialised in cpuinfo_store_boot_cpu().
> 
> Was there a reason the jump_label_init() couldn't be moved
> earlier in the common code?

No particular reason, only that I wasn't sure what the arch requirements
to be able to initialise the jump labels early are (for example,
jump_label_init() calls arch_jump_label_transform_static(); there don't
seem to be any issues at a first look but I don't have the hardware to
test and confirm). Therefore I followed the powerpc idea of calling
jump_label_init() directly earlier.

We also don't know how early it needs to be to benefit other
architectures (powerpc seems to call it on a very early path via
early_setup()).

-- 
Catalin
