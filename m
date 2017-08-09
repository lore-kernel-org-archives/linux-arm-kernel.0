From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 11:13:41 +0100
Subject: [PATCH] arm64/vdso: Support mremap() for vDSO
In-Reply-To: <20170726170737.21696-1-dsafonov@virtuozzo.com>
References: <20170726170737.21696-1-dsafonov@virtuozzo.com>
Message-ID: <20170809101341.j7qvffmkgaxtfapb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 08:07:37PM +0300, Dmitry Safonov wrote:
> vDSO VMA address is saved in mm_context for the purpose of using
> restorer from vDSO page to return to userspace after signal handling.
> 
> In Checkpoint Restore in Userspace (CRIU) project we place vDSO VMA
> on restore back to the place where it was on the dump.
> With the exception for x86 (where there is API to map vDSO with
> arch_prctl()), we move vDSO inherited from CRIU task to restoree
> position by mremap().
> 
> CRIU does support arm64 architecture, but kernel doesn't update
> context.vdso pointer after mremap(). Which results in translation
> fault after signal handling on restored application:
> https://github.com/xemul/criu/issues/288
> 
> Make vDSO code track the VMA address by supplying .mremap() fops
> the same way it's done for x86 and arm32 by:
> commit b059a453b1cf ("x86/vdso: Add mremap hook to vm_special_mapping")
> commit 280e87e98c09 ("ARM: 8683/1: ARM32: Support mremap() for sigpage/vDSO").
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>

Queued for 4.14. Thanks.

-- 
Catalin
