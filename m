From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Feb 2016 17:54:47 +0000
Subject: [PATCH] arm64: kasan: clear stale stack poison
In-Reply-To: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
References: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160218175447.GD2538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 05:27:38PM +0000, Mark Rutland wrote:
> @@ -145,6 +146,7 @@ ENTRY(cpu_resume_mmu)
>  ENDPROC(cpu_resume_mmu)
>  	.popsection
>  cpu_resume_after_mmu:
> +	kasan_unpoison_stack 96

I don't think the 96 here is needed since we populate the stack in
assembly (__cpu_suspend_enter) and unwind it again still in assembly
(cpu_resume_after_mmu), so no KASAN shadow writes/reads.

Otherwise the patch looks fine.

-- 
Catalin
