From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 19 Apr 2015 23:52:17 +0200
Subject: [PATCH v2 1/8] ARM: replace PROCINFO embedded branch with
 relative offset
In-Reply-To: <20150419192836.GO12732@n2100.arm.linux.org.uk>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAGhQ9VynJZWRb4iysXPE3X0GRaZNDNObz2Bgys01Kn7gjav7ag@mail.gmail.com>
 <20150419170819.GN12732@n2100.arm.linux.org.uk>
 <6D2381CE-C6EB-4B18-972D-DA07FD77C2D4@linaro.org>
 <20150419192836.GO12732@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9X_0CNEzgdWKGQopwxy1sFD5BcS=6pTsS+WRWXzh5uWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2015 at 21:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Apr 19, 2015 at 07:41:08PM +0200, Ard Biesheuvel wrote:
>> I am away from my work pc so i can't check but i wonder if all setup
>> functions are correctly annotated as thumb2 when built in thumb2 mode.
>> If not, it would explain why a plain branch works but doing arithmetic
>> on the address doesn't.
>
> Yes, it's a Thumb2 kernel, but more importantly, it's a nommu kernel,
> and the nommu code wasn't touched.
>

Ah, my bad. I had no idea that code was duplicated elsewhere, but I
guess grepping for PROCINFO_INITFUNC would have given me a strong
hint.

> So, the entry code looks like this:
>
> 28008000:       f8df 9024       ldr.w   r9, [pc, #36]   ; 28008028 <__after_proc_init+0x4>
> 28008004:       f8d9 9000       ldr.w   r9, [r9]
> 28008008:       f001 f926       bl      28009258 <__lookup_processor_type>
> 2800800c:       ea5f 0a05       movs.w  sl, r5
> 28008010:       f001 8164       beq.w   280092dc <__error_p>
> 28008014:       f8df d014       ldr.w   sp, [pc, #20]   ; 2800802c <__after_proc_init+0x8>
> 28008018:       f20f 0e07       addw    lr, pc, #7
> 2800801c:       f10a 0c10       add.w   ip, sl, #16
> 28008020:       46e7            mov     pc, ip

OK, there's still a dodgy bit here. The issue I pointed out in my
previous email actually does exist, i.e., the setup functions are not
always annotated as thumb2 so the offset from the base of the struct
may lack the thumb bit even if the function is coded in thumb2. This
is caused by the fact that local labels lack this annotation, even if
the function is emitted into a separate section in the same object
file and references to it are resolved by the linker through
relocations.

Looking at a couple of procinfo entries from proc-v7.S, it turns out
that the offset field (the 1st word on the 2nd line) indeed contains
even values in some cases in a Thumb2 kernel

c0771364 <__v7_ca9mp_proc_info>:
c0771364:       410fc090 ff0ffff0 00011c0e 00000c02     ...A............
c0771374:       ffaab634 c0773934 c077393a 00008097     4...49w.:9w.....
...

c0771398 <__v7_ca8_proc_info>:
c0771398:       410fc080 ff0ffff0 00011c0e 00000c02     ...A............
c07713a8:       ffaab667 c0773934 c077393a 00008097     g...49w.:9w.....
...

c07713cc <__v7_pj4b_proc_info>:
c07713cc:       560f5800 ff0fff00 00011c0e 00000c02     .X.V............
c07713dc:       ffaab5ee c0773934 c077393a 00008097     ....49w.:9w.....
...

c0771400 <__v7_cr7mp_proc_info>:
c0771400:       410fc170 ff0ffff0 00011c0e 00000c02     p..A............
c0771410:       ffaab598 c0773934 c077393a 00008097     ....49w.:9w.....
...

c0771434 <__v7_ca7mp_proc_info>:
c0771434:       410fc070 ff0ffff0 00011c0e 00000c02     p..A............
c0771444:       ffaab56a c0773934 c077393a 00008097     j...49w.:9w.....
...

but we are getting lucky because the 'ret r12' instruction from
head{-nommu}.S is emitted as 'mov pc, ip', which is a [for v7]
deprecated method of performing a branch-to-register which doesn't
incur a mode switch. In other words, if we'd use the architecturally
correct 'bx ip' here, the code breaks.

As far as I can tell, there are no such setup functions that could run
on a Thumb2 capable CPU but are emitted in ARM code explicitly, so I
think the fix could be as simple as

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index c671f345266a..a4f6d74e9e21 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -333,7 +333,7 @@ ENTRY(\name\()_tlb_fns)
 .endm

 .macro initfn, func, base
-       .long   \func - \base
+       .long   BSYM(\func) - \base
 .endm

        /*
