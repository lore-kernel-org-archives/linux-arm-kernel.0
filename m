From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 07 Oct 2013 12:32:21 +0200
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for
 BE correct operation
In-Reply-To: <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
References: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
 <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <52528DB5.9000608@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 08:47, Victor Kamensky wrote:
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
>
> Signed-off-by: Victor Kamensky<victor.kamensky@linaro.org>

do the __local_flush_tlb_mm() macros need to be changed to always
ensure they take the lowest word of the two?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
