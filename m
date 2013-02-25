From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Feb 2013 15:59:46 +0000
Subject: [PATCH 2/2] ARM: mm: make mm->context.id an atomic64_t variable
In-Reply-To: <1361805488-8798-2-git-send-email-will.deacon@arm.com>
References: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
 <1361805488-8798-2-git-send-email-will.deacon@arm.com>
Message-ID: <20130225155946.GC612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 03:18:08PM +0000, Will Deacon wrote:
> mm->context.id is updated under asid_lock when a new ASID is allocated
> to an mm_struct. However, it is also read without the lock when a task
> is being scheduled and checking whether or not the current ASID
> generation is up-to-date.
> 
> If two threads of the same process are being scheduled in parallel and
> the bottom bits of the generation in their mm->context.id match the
> current generation (that is, the mm_struct has not been used for ~2^24
> rollovers) then the non-atomic, lockless access to mm->context.id may
> yield the incorrect ASID.
> 
> This patch fixes this issue by making mm->context.id and atomic64_t,
> ensuring that the generation is always read consistently. For code that
> only requires access to the ASID bits (e.g. TLB flushing by mm), then
> the value is accessed directly, which GCC converts to an ldrb.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
