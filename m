From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Sep 2014 18:02:06 +0100
Subject: [PATCH] arm64: insn: Add return statements after BUG_ON()
In-Reply-To: <1410885753-25025-1-git-send-email-broonie@kernel.org>
References: <1410885753-25025-1-git-send-email-broonie@kernel.org>
Message-ID: <20140918170205.GE25330@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 05:42:33PM +0100, Mark Brown wrote:
> Following a recent series of enhancements to the insn code the ARMv8
> allnoconfig build has been generating a large number of warnings in the
> form of:
> 
> arch/arm64/kernel/insn.c:689:8: warning: 'insn' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This is because BUG() and related macros can be compiled out so we get
> execution paths which normally result in a panic compiling out to noops
> instead.
> 
> I wasn't able to immediately identify a sensible return value to use in
> these cases so just return 0 - this is all "should never happen" code so
> hopefully it never has a practical impact.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/insn.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 0668ee5..7af35f3 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -388,6 +388,7 @@ u32 __kprobes aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
>  		break;
>  	default:
>  		BUG_ON(1);
> +		return 0;
>  	}

Wouldn't there be less lines if we initialise insn to 0 in these
functions?

-- 
Catalin
