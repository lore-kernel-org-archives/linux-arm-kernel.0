From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Apr 2017 12:38:49 +0100
Subject: arm64: Question about warnings due to unspecified ASM operand
 width
In-Reply-To: <20170418013156.GB105296@google.com>
References: <20170418013156.GB105296@google.com>
Message-ID: <20170418113849.GC27592@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 06:31:56PM -0700, Matthias Kaehlcke wrote:
> During my work on improving support for kernel builds with clang I
> came across a bunch of warnings on arm64 builds about the width of
> operands in assembly not being specified:
> 
> arch/arm64/include/asm/arch_timer.h:92:46: error: value size does
>       not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
>         asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));

I think the first step would be to test it against a newer kernel. The
above code disappeared in 4.9 in favour of dedicated read_sysreg()
macros which shouldn't give this warning (u64 __val).

> I understand that this is usually not a problem and might even be
> desired to give the compiler more flexiblity in the use of the
> available registers.

I don't think arm64 would benefit from such ambiguity, so we should
rather fix them. In practice there is no issue since the compiler cannot
allocate two 32-bit variables in a 64-bit register.

> Before delving into 'fixing' these 'asm-operand-widths' warnings I'd
> be interested to know if this is actually desirable or if it is
> preferred to keep the operand width unspecified in certain cases.

I'm not aware of a desirable ambiguity here.

Thanks.

-- 
Catalin
