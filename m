From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Feb 2013 15:59:30 +0000
Subject: [PATCH 1/2] ARM: mm: fix race updating mm->context.id on ASID
 rollover
In-Reply-To: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
References: <1361805488-8798-1-git-send-email-will.deacon@arm.com>
Message-ID: <20130225155929.GB612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 03:18:07PM +0000, Will Deacon wrote:
> If a thread triggers an ASID rollover, other threads of the same process
> must be made to wait until the mm->context.id for the shared mm_struct
> has been updated to new generation and associated book-keeping (e.g.
> TLB invalidation) has ben performed.
> 
> However, there is a *tiny* window where both mm->context.id and the
> relevant active_asids entry are updated to the new generation, but the
> TLB flush has not been performed, which could allow another thread to
> return to userspace with a dirty TLB, potentially leading to data
> corruption. In reality this will never occur because one CPU would need
> to perform a context-switch in the time it takes another to do a couple
> of atomic test/set operations but we should plug the race anyway.
> 
> This patch moves the active_asids update until after the potential TLB
> flush on context-switch.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
