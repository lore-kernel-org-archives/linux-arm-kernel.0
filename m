From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 11:45:24 +0100
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for
 BE correct operation
In-Reply-To: <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
References: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
 <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131007104524.GK12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 11:47:38PM -0700, Victor Kamensky wrote:
> __flush_tlb_mm function need to use intermediate 'int' type 'asid'
> variable int tlb_op macro call. Direct use of ASID macro produces
> 64 bit unsigned long long type passed to inline assembler statement
> as 'r' operand (32bit), and resulting behavior is not well specified.
> It works in little endian case, but is broken in big endian case. In
> big endian case gcc generate such code that 0 is passed to
> 'mcr	15, 0, r4, cr8, cr3, {2}' operation.
> 
> Note other functions like __local_flush_tlb_mm, and local_flush_tlb_mm
> already use intermediate 'asid' variable in similar code.

A much better solution would be to ensure that ASID() only returns
the 'unsigned' type, not a long long type.

#define ASID(mm)        ((unsigned)(mm)->context.id.counter & ~ASID_MASK)
