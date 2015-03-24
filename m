From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Mar 2015 12:22:39 +0000
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150324122239.GB3579@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 11:16:24AM +0100, Ard Biesheuvel wrote:
> When building a very large kernel, it is up to the linker to decide
> when and where to insert stubs to allow calls to functions that are
> out of range for the ordinary b/bl instructions.
> 
> However, since the kernel is built as a position dependent binary,
> these stubs (aka veneers) may contain absolute addresses, which will
> break such veneer assisted far calls performed with the MMU off.
> 
> For instance, the call from __enable_mmu() in the .head.text section
> to __turn_mmu_on() in the .idmap.text section may be turned into
> something like this:
> 
> c0008168 <__enable_mmu>:
> c0008168:       f020 0002       bic.w   r0, r0, #2
> c000816c:       f420 5080       bic.w   r0, r0, #4096
> c0008170:       f000 b846       b.w     c0008200 <____turn_mmu_on_veneer>
> [...]
> c0008200 <____turn_mmu_on_veneer>:
> c0008200:       4778            bx      pc
> c0008202:       46c0            nop
> c0008204:       e59fc000        ldr     ip, [pc]
> c0008208:       e12fff1c        bx      ip
> c000820c:       c13dfae1        teqgt   sp, r1, ror #21
> [...]
> c13dfae0 <__turn_mmu_on>:
> c13dfae0:       4600            mov     r0, r0
> [...]
> 
> After adding --pic-veneer to the LDFLAGS, the veneer is emitted like
> this instead:
> 
> c0008200 <____turn_mmu_on_veneer>:
> c0008200:       4778            bx      pc
> c0008202:       46c0            nop
> c0008204:       e59fc004        ldr     ip, [pc, #4]
> c0008208:       e08fc00c        add     ip, pc, ip
> c000820c:       e12fff1c        bx      ip
> c0008210:       013d7d31        teqeq   sp, r1, lsr sp
> c0008214:       00000000        andeq   r0, r0, r0
> 
> Note that this particular example is best addressed by moving
> .head.text and .idmap.text closer together, but this issue could
> potentially affect any code that needs to execute with the
> MMU off.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Although that fixes the problem, wouldn't this introduce extra potential
overhead for every call in the kernel?

How many such veneers get added in the your kernel configuration, and
how many are actually necessary (i.e., calls between MMU-off code and
elsewhere)?

Cheers
---Dave
