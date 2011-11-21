From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Nov 2011 13:18:55 +0000
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
In-Reply-To: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
References: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
Message-ID: <CAHkRjk491+H9Wh-uV8807VSkZ4Mk+UK3Jv6EThtOsRb7ULpUjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2011 11:54, Moln?r G?bor <conqrx@gmail.com> wrote:
> im working on a project wich aims at porting the 2.6.38 kernel to an
> arm11 mpcore based board.
>
> The kernel fails to boot, in the paging_init func, it throws an
> exception (pc: FFFF_000C) when executing the third mcr instruction in
> the list below:
>
> 0xc000bf34 ?<>: ? ?blx ?r3
> 0xc000bf38 ?<>: ? ?mov ?r5, #0 ?; 0x0
> 0xc000bf3c ?<>: ? ?mcr ?15, 0, r5, cr7, cr10, {4}
> 0xc000bf40 ?<>: ? ?mcr ?15, 0, r5, cr8, cr6, {0}
> 0xc000bf44 ?<>: ? ?mcr ?15, 0, r5, cr8, cr5, {0} //throws an exception
> here, Invalidate Instruction TLB Register
> 0xc000bf48 ?<>: ? ?mcr ?15, 0, r5, cr7, cr5, {6}
> 0xc000bf4c ?<>: ? ?mcr ?15, 0, r5, cr7, cr10, {4}
> 0xc000bf50 ?<>: ? ?mcr ?15, 0, r5, cr7, cr5, {4}
> 0xc000bf54 ?<>: ? ?ldr ?lr, [pc, #176] ?; 0xc000c00c

So you get a prefetch abort as soon as the TLBs are invalidated, which
means that the page table is not set up correctly.

What's your RAM configuration (start address, size)?

> The kernel has been patched with the 2.6.38-arm1 patch, and configured
> to be as minimal as possible (the vmlinux.elf is 1.8MB) and
> cross-compiled with the?Codesourcery gcc toolchain.
> The minimal size is improtant because the aim is to make the kernel
> run with only 5-6MB of memory (from c0000000 to c0500000).
> The 'boot_loader' i wrote passes the atag pointers (basically core and
> memory) and the kernel seemingly reads and parses them fine. The
> __log_buf before the exception:
>
> <5>Linux version 2.6.38-rc8 (VirtualBox) (gcc version 4.5.2 (Sourcery
> G++ Lite 2011.03-41) ) #6 Wed Nov 9 21:59:29 CET 2011
> <4>CPU: ARMv6-compatible processor [410fb025] revision 5 (ARMv7), cr=08c5387f"
> <4>CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> <4>Machine: ARM-RealView PB11MPCore
> <5>Ignoring RAM at c0000000-c04fffff (vmalloc region overlap).

Does your physical RAM start at 0xc0000000 and it is all ignored?
Setting highmem would fix as all your lowmem (including the kernel
code) would be unmapped, hence the fault. What's the VMALLOC_END
defined to?

-- 
Catalin
