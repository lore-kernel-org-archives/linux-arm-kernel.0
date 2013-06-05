From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Jun 2013 11:01:53 +0100
Subject: arm64: opportunity for (micro) optimisation in set_bit et al?
In-Reply-To: <1370424981.24512.163.camel@zakaz.uk.xensource.com>
References: <1370424981.24512.163.camel@zakaz.uk.xensource.com>
Message-ID: <20130605100152.GC8758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Wed, Jun 05, 2013 at 10:36:21AM +0100, Ian Campbell wrote:
> I was "borrowing" the arm64 Linux bitops for use in Xen and Tim Deegan
> wondered about the use of eor in:
>        and     x3, x0, #63             // Get bit offset
>        eor     x0, x0, x3              // Clear low bits
>        mov     x2, #1
>        add     x1, x1, x0, lsr #3      // Get word offset

BTW, the latest kernel uses W registers (32-bit here since the function
prototype has an 'int' and the compiler does not guarantee that the top
32-bit are 0.

> That eor has a dependency on the previous and instruction which could be
> avoided using a bic or a lsr #5 followed by lsl #2 instead of the lsr #3
> on the add (this is what arm32 does).

Any of these would do (I haven't tried, bic #imm is an alias for and).
I'll check with the hardware guys whether it makes any difference but it
is a harmless change anyway.

Thanks.

-- 
Catalin
