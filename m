From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Mar 2016 12:09:05 +0000
Subject: [PATCH] arm64: fix KASLR boot-time I-cache maintenance
In-Reply-To: <1458040977-27558-1-git-send-email-mark.rutland@arm.com>
References: <1458040977-27558-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160321120905.GC25466@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 11:22:57AM +0000, Mark Rutland wrote:
> Commit f80fb3a3d50843a4 ("arm64: add support for kernel ASLR") missed a
> DSB necessary to complete I-cache maintenance in the primary boot path,
> and hence stale instructions may still be present in the I-cache and may
> be executed until the I-cache maintenance naturally completes.
> 
> Since commit 8ec41987436d566f ("arm64: mm: ensure patched kernel text is
> fetched from PoU"), all CPUs invalidate their I-caches after their MMU
> is enabled. Prior a CPU's MMU having been enabled, arbitrary lines may
> have been fetched from the PoC into I-caches. We never patch text
> expected to be executed with the MMU off. Thus, it is unnecessary to
> perform broadcast I-cache maintenance in the primary boot path.
> 
> This patch reduces the scope of the I-cache maintenance to the local
> CPU, and adds the missing DSB with similar scope, matching prior
> maintenance in the primary boot path.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesehvuel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
