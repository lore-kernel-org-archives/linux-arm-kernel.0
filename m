From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 16:19:53 +0000
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <55030A68.6070002@free.fr>
References: <55030A68.6070002@free.fr>
Message-ID: <20150313161953.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 05:03:52PM +0100, Mason wrote:
> Hello everyone,
> 
> As far as I can tell, read_cpuid_id() resolves to read_cpuid(CPUID_ID)
> which resolves to mrc 15, 0, rN, cr0, cr0, {0}
> 
> Consider this:
> 
> /*
>  * The CPU ID never changes at run time, so we might as well tell the
>  * compiler that it's constant.  Use this function to read the CPU ID
>  * rather than directly reading processor_id or read_cpuid() directly.
>  */
> static inline unsigned int __attribute_const__ read_cpuid_id(void)
> {
> 	return read_cpuid(CPUID_ID);
> }
> 
> Despite the comment and attribute, my compiler(*) still reloads the
> value every time.
> 
> (*) gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)
> 
> e.g.
> 
> static int __get_cpu_architecture(void)
> {
> 	int cpu_arch;
> 
> 	unsigned int id = read_cpuid_id();
> 	if ((id & 0x0008f000) == 0) {
> 		cpu_arch = CPU_ARCH_UNKNOWN;
> 	} else if ((id & 0x0008f000) == 0x00007000) {
> 		cpu_arch = (id & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
> 	} else if ((id & 0x00080000) == 0x00000000) {
> 		cpu_arch = (id >> 16) & 7;
> 		if (cpu_arch)
> 			cpu_arch += CPU_ARCH_ARMv3;
> 	} else if ((id & 0x000f0000) == 0x000f0000) {
> 
> resolves to
> 
> c01fec74:       ee10cf10        mrc     15, 0, ip, cr0, cr0, {0}
> c01fec78:       e21cca8f        ands    ip, ip, #585728 ; 0x8f000
> c01fec7c:       e34c3023        movt    r3, #49187      ; 0xc023
> c01fec80:       e5837008        str     r7, [r3, #8]
> c01fec84:       e50b304c        str     r3, [fp, #-76]  ; 0x4c
> c01fec88:       0a000022        beq     c01fed18 <setup_arch+0xe4>
> c01fec8c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> c01fec90:       e2033a8f        and     r3, r3, #585728 ; 0x8f000
> c01fec94:       e3530a07        cmp     r3, #28672      ; 0x7000
> c01fec98:       1a000004        bne     c01fecb0 <setup_arch+0x7c>
> c01fec9c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> c01feca0:       e3130502        tst     r3, #8388608    ; 0x800000
> c01feca4:       13a0c003        movne   ip, #3
> c01feca8:       03a0c001        moveq   ip, #1
> c01fecac:       ea000019        b       c01fed18 <setup_arch+0xe4>
> c01fecb0:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
> c01fecb4:       e3130702        tst     r3, #524288     ; 0x80000
> 
> 
> So I thought it would be nice to give the poor compiler a break,
> and just stuff the result in a local variable:

NAK.

Your compiler behaviour is different to mine (stock gcc 4.7.4):

 4f8:   e1a0c00d        mov     ip, sp
 4fc:   e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 500:   e24cb004        sub     fp, ip, #4
 504:   e24dd00c        sub     sp, sp, #12
 508:   ee105f10        mrc     15, 0, r5, cr0, cr0, {0} <== load id
 50c:   e1a07000        mov     r7, r0
 510:   e1a00005        mov     r0, r5			<== r5 = id
 514:   ebfffffe        bl      0 <lookup_processor_type>
 518:   e2504000        subs    r4, r0, #0
 51c:   1a000003        bne     530 <setup_arch+0x38>
 520:   e59f063c        ldr     r0, [pc, #1596] ; b64 <setup_arch+0x66c>
 524:   e1a01005        mov     r1, r5
 528:   ebfffffe        bl      0 <printk>
 52c:   eafffffe        b       52c <setup_arch+0x34>
 530:   e5948020        ldr     r8, [r4, #32]
 534:   e2153a8f        ands    r3, r5, #585728 ; 0x8f000 <== r5 = id
 538:   e59f2628        ldr     r2, [pc, #1576] ; b68 <setup_arch+0x670>
 538:   e59f2628        ldr     r2, [pc, #1576] ; b68 <setup_arch+0x670>
 53c:   e5828000        str     r8, [r2]
 540:   0a00001f        beq     5c4 <setup_arch+0xcc>
 544:   e3530a07        cmp     r3, #28672      ; 0x7000
 548:   1a000003        bne     55c <setup_arch+0x64>
 54c:   e3150502        tst     r5, #8388608    ; 0x800000 <== r5 = id
 550:   03a03001        moveq   r3, #1
 554:   13a03003        movne   r3, #3
 558:   ea000019        b       5c4 <setup_arch+0xcc>
 55c:   e3150702        tst     r5, #524288     ; 0x80000 <== r5 = id
 560:   1a000003        bne     574 <setup_arch+0x7c>
 564:   e7e23855        ubfx    r3, r5, #16, #3		<== r5 = id
 568:   e3530000        cmp     r3, #0
 56c:   12833001        addne   r3, r3, #1
 570:   ea000013        b       5c4 <setup_arch+0xcc>
 574:   e205580f        and     r5, r5, #983040 ; 0xf0000 <== r5 = id
 578:   e355080f        cmp     r5, #983040     ; 0xf0000
 57c:   13a03000        movne   r3, #0
 580:   1a00000f        bne     5c4 <setup_arch+0xcc>
...

The point here is that the compiler is free to optimise the code as it
sees fit - if it decides that the register pressure from having the
value cached in a register is too high, it can decide to spill the
cached value, and reload it from CP15 as and when it needs to.  That
is an advantage.

It seems that GCC 4.7.4 optimises better than Linaro's 4.9.3.  In fact,
it looks like Linaro's 4.9.3 is rather buggy as far as optimisation
goes.

Later compilers aren't always better.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
