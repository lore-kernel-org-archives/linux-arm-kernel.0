From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 10 Nov 2013 11:25:18 +0000
Subject: [PATCH] arm64: emulate aarch32 CP15 barriers if needed
In-Reply-To: <1384075404-19605-1-git-send-email-ming.lei@canonical.com>
References: <1384075404-19605-1-git-send-email-ming.lei@canonical.com>
Message-ID: <C6F109E2-5DFE-4F76-A5FA-3638481424BB@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Nov 2013, at 09:23, Ming Lei <ming.lei@canonical.com> wrote:
> CP15BEN of SCTLR_EL1 may not be implemented, so we need
> to emulate these three CP15 barriers to avoid breaking
> aarch32 applications since they can be used in user mode.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Can you describe which aarch32 applications is this breaking?  These
barriers have been deprecated in ARMv7 and removed in ARMv8 (same as the
SWP instruction).  User space is supposed to use the kuser helpers which
provide the right barriers for the architecture.  Compiler intrinsics
for ARMv7 already generate (inline) the new ARMv7 barriers.

So for compat support, I consider this similar to other instructions we
will not emulate like SWP and certain unaligned accesses.  IOW, arm64
compat only supports non-deprecated ARMv7 features.

Catalin
