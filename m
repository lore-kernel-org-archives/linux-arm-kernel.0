From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  7 Apr 2014 20:04:19 -0700
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
Message-ID: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave, Oleg, and All,

Short story
===========

It seems to me that ARMv7 uprobes need proper icache 
flush after xol write. Please look at [1] discussion for similar 
issue on ppc.

It seems that flush_dcache_page was sufficient for latter
architectures of PPC but it does not look that it is good enough
for ARMv7.

AFAIK know ARM V7 does not have "snooping Harvard caches"
and needs something like __cpuc_coherent_user_range function call
to sync up icache and dcache after instruction write through
dcache.

Patch that I propose follows this cover letter. There I
introduced weak arch_uprobe_xol_sync_dcache_icache function that 
does traditional flush_dcache_page call and I redefined this
function to __cpuc_coherent_user_range call in ARM v7 > case.

[1] http://linux-kernel.2935.n7.nabble.com/Re-PATCH-6-9-uprobes-flush-cache-after-xol-write-td216886.html


Longer story
============

I was trying Dave's armv7 uprobes with SystemTap on Arndale
board. I used Linaro linux branch 3.14 based that contained 
Dave's armv7 uprobes topic code. I believe it should be
pretty much the same as armv7 uprobes code that went to Russell's
tree.

I was able to do one function simple test - it worked
fine for me. But when I've tried to run many function like "probe
process("foobar").function("*")" probe SystemTap my target
process always crashed. 

After quite a bit of chasing the issue, I was able to come
up with test case that shows several probes installed against
'ls' process. First probe placed at 'push {r4, r5, r6, r7,
r8, r9, r10, r11, lr}' instruction, which is first in 
_getopt_initialize function, then script adds few more probes 
at _getopt_initialize addresses that are executed latter. And
in those probes I dump registers set and top of stack. By
looking at execution of script one may easily conclude that it
looks like that for each probe 'push {r4, r5, r6, r7, r8, r9,
r10, r11, lr}' instruction is always executed - one may see
36 bytes increase of stack size and see copy of corresponding
registers on the stack.

The code path is the following:

handle_swbp -> pre_ssout

   pre_ssout -> xol_get_insn_slot

       xol_get_insn_slot -> copy_to_page
       xol_get_insn_slot -> flush_dcache_page

   pre_ssout -> arch_uprobe_pre_xol

pre_ssout function calls xol_get_insn_slot which finds 
available slot in XOL area, that is mapped into user process
and copies required instruction into xol slot. After that it
calls flush_dcache_page, but icache is not flushed in ARM
case by this function. So I think the following thing happens:
first time first xol slot got 'push {r4, r5, r6, r7, r8, r9, 
r10, r11, lr}' instruction and it retrieved into icache. Latter
when other probes are executed the same first slot of xol area
it will get different instruction but because icache is not 
flushed CPU keep executing 'push' instruction.

When I add the following testing patch that flush icache
in arch_uprobe_pre_xol

[kamensky at kamensky-w530 git]$ git diff
diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
index f9bacee..ef34623 100644
--- a/arch/arm/kernel/uprobes.c
+++ b/arch/arm/kernel/uprobes.c
@@ -117,6 +117,8 @@ int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
        struct uprobe_task *utask = current->utask;
 
+       __flush_icache_all();
+
        if (auprobe->prehandler)
                auprobe->prehandler(auprobe, &utask->autask, regs);
 

it fixes my test problem, 'ls' executes fine, I am able to
trace it with "process("foobar").function("*")" traces.

Having complete icache flush is far from optimal. I was
looking for better and more optimal and targeted icache flush.

In discussion [1] and corresponding commit it was alluded
that flush_icache_user_range should help but I don't think it
will work for ARMv7. It seems that for ARMv7
flush_icache_user_range is not quite correct - it calls
again 'flush_dcache_page(page)' which I don't think touches
icache (other strange thing that it ignores len completely).

I looked at armv7 kprobes code, in similar area arch_prepare_kprobe 
function calls arch_prepare_kprobe which calls flush_insn macro
which is defined as call flush_icache_range, which in turn
defines as __cpuc_coherent_kern_range(s,e).

I looked at ptrace breakpoint write code as well that deals
with similar issue.

As far as I see it seems that the best function to sync up icache
and dcache of user land process is to use __cpuc_coherent_user_range
function which sync up dcache and icache memory region of given
size and at given address on current core. In case of Arndale
it goes through v7_coherent_user_range function. Given uprobes
single step like use case it seem syncing up cache on current core
is sufficient. If someone can confirm that __cpuc_coherent_user_range
is right choice for this situation it would be nice. Test shows
it work, we would need to know for sure.

Next issue is how to integrate this call with cpu independent
uprobes code. I introduced week arch_uprobe_xol_sync_dcache_icache
function that calls flush_dcache_page as before, and for ARMv7
defined one that calls __cpuc_coherent_user_range. As far I
understand flush_dcache_page was introduced for some relatively
recent ppc CPU, it seems to be noop on x86. I was thinking that
default weak version of arch_uprobe_xol_sync_dcache_icache should
be empty and ppc define one that calls flush_dcache_page. But
I have no way to test ppc case so I decided do conservative
implementation and keep default version calling flush_dcache_page
as it was before.

Thanks,
Victor

Appendix: Test case that shows push instruction executed several times
======================================================================

SystemTap test script
---------------------

root at genericarmv7a:~/systemtap/test# cat ls_t4_not_r4.stp
function print_memory(addr:long, size:long) {
	i = 0;
	addr2 = addr;
	while (i < size) {
		printf("0x%8.8x: ", addr2);
		while (i < size) {
			printf ("0x%8.8x ", user_uint32(addr2));
			addr2 = addr2 + 4;
			i = i + 4;
			if (i%16 == 0) {
				break;
			}
		}
		printf("\n");
	} 
}

probe process("/bin/ls.coreutils").function("_getopt_initialize")
{
        sp = register("sp");
	print_memory(sp, 64);
	print_regs();
	printf("-> _getopt_initialize\n");
}

probe process("/bin/ls.coreutils").statement(0x0001b2e8) {
        sp = register("sp");
        print_memory(sp, 64);
 
	print_regs();
	printf("-> 0x0001b2e8\n");
}


probe process("/bin/ls.coreutils").statement(0x0001b2d8) {
        sp = register("sp");
        print_memory(sp, 64);
 
	print_regs();
	printf("-> 0x0001b2d8\n");
}

probe process("/bin/ls.coreutils").statement(0x0001b408) {
        sp = register("sp");
        print_memory(sp, 64);
 
	print_regs();
	printf("-> 0x0001b408\n");
}



probe process("/bin/ls.coreutils").function("_getopt_internal_r")
{
//        sp = register("sp");
//        print_memory(sp, 64);
 
	print_regs();
	printf("-> _getopt_internal_r\n");
}


execution of script
-------------------

Look at log of script execution. Check how $sp changes at
each probe (+36). And see that r4, r5, r6, r7, r8, r9, r10, r11,
lr registers are always at top of stack.

root at genericarmv7a:~/systemtap/test# stap -U -v ls_t4_not_r4.stp
Pass 1: parsed user script and 100 library script(s) using 20520virt/16336res/1728shr/15260data kb, in 410usr/30sys/437real ms.
Pass 2: analyzed script: 5 probe(s), 8 function(s), 3 embed(s), 2 global(s) using 21984virt/18568res/2620shr/16724data kb, in 1280usr/870sys/2507real ms.
Pass 3: translated to C into "/tmp/stapPmXkE6/stap_06d9647b8c7b3327fecfc3259c39e0ed_6448_src.c" using 21984virt/18796res/2848shr/16724data kb, in 70usr/260sys/330real ms.
Pass 4: compiled C into "stap_06d9647b8c7b3327fecfc3259c39e0ed_6448.ko" in 16050usr/1290sys/18328real ms.
Pass 5: starting run.
 CPU: 1pc : [<0001b2cc>]    lr : [<0001c1ac>]
sp : 7eeb2940  ip : 00000001  fp : 0002a2d8
r10: 76ffe000  r9 : 0002a2d8  r8 : 7eeb29c4
r7 : 00000000  r6 : 00000000  r5 : 0002a2b0  r4 : 0002af40
r3 : 0001e914  r2 : 00020dc4  r1 : 7eeb2de4  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 30C5387D
Table: AC5A14C0  DAC: 55555555
-> _getopt_internal_r
0x7eeb28d8: 0xffffffff 0x00000000 0x76e97e34 0x76ffb8f8 
0x7eeb28e8: 0x00000000 0x00000038 0x00000000 0x76f560c8 
0x7eeb28f8: 0x00000077 0x00001500 0x00000005 0x000018b2 
0x7eeb2908: 0x00000a3b 0x7f1c0300 0x01000415 0x76ffa4c0 
 CPU: 1pc : [<0001b2d8>]    lr : [<0001c1ac>]
sp : 7eeb28d8  ip : 00000001  fp : 0002a2d8
r10: 00000001  r9 : 0002a2d8  r8 : 7eeb29c4
r7 : 00000000  r6 : 00000000  r5 : 0002a2b0  r4 : 0002af40
r3 : 0001e914  r2 : 00020dc4  r1 : 7eeb2de4  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 30C5387D
Table: AC5A14C0  DAC: 55555555
-> 0x0001b2d8
0x7eeb28b4: 0x0002af40 0x0002a2b0 0x00000000 0x00000000 
0x7eeb28c4: 0x7eeb29c4 0x0002a2d8 0x7eeb2de4 0x0001e914 
0x7eeb28d4: 0x0001c1ac 0xffffffff 0x00000000 0x76e97e34 
0x7eeb28e4: 0x76ffb8f8 0x00000000 0x00000038 0x00000000 
 CPU: 1pc : [<0001b2e8>]    lr : [<0001c1ac>]
sp : 7eeb28b4  ip : 00000001  fp : 0002a2d8
r10: 00000001  r9 : 0002a2d8  r8 : 7eeb29c4
r7 : 00000000  r6 : 00000000  r5 : 0002a2b0  r4 : 0002af40
r3 : 00000001  r2 : 00020dc4  r1 : 7eeb2de4  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 30C5387D
Table: AC5A14C0  DAC: 55555555
-> 0x0001b2e8
0x7eeb2890: 0x0002af40 0x0002a2b0 0x00000000 0x00000000 
0x7eeb28a0: 0x7eeb29c4 0x00000001 0x00000001 0x0002a2d8 
0x7eeb28b0: 0x0001c1ac 0x0002af40 0x0002a2b0 0x00000000 
0x7eeb28c0: 0x00000000 0x7eeb29c4 0x0002a2d8 0x7eeb2de4 
 CPU: 1pc : [<0001b3f8>]    lr : [<0001c1ac>]
sp : 7eeb2890  ip : 00000001  fp : 0002a2d8
r10: 00000001  r9 : 0002a2d8  r8 : 7eeb29c4
r7 : 00000000  r6 : 00000000  r5 : 0002a2b0  r4 : 0002af40
r3 : 00000001  r2 : 00000000  r1 : 7eeb2de4  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 30C5387D
Table: AC5A14C0  DAC: 55555555
-> _getopt_initialize
0x7eeb286c: 0x0002af40 0x0002a2b0 0x00000000 0x00000000 
0x7eeb287c: 0x7eeb29c4 0x0002a2d8 0x00000001 0x0002a2d8 
0x7eeb288c: 0x0001c1ac 0x0002af40 0x0002a2b0 0x00000000 
0x7eeb289c: 0x00000000 0x7eeb29c4 0x00000001 0x00000001 
 CPU: 1pc : [<0001b408>]    lr : [<0001c1ac>]
sp : 7eeb286c  ip : 00000001  fp : 0002a2d8
r10: 00000001  r9 : 0002a2d8  r8 : 7eeb29c4
r7 : 00000000  r6 : 00000000  r5 : 0002a2b0  r4 : 0002af40
r3 : 00000001  r2 : 00000000  r1 : 7eeb2de4  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 30C5387D
Table: AC5A14C0  DAC: 55555555
-> 0x0001b408


gdb session of crashed ls command
=================================

Looking at core of crashed ls process. Look at
disassemble of function you can see uprobe breakpoints
as <UNDEFINED> instruction. For instructions that should
be there and which are executed through xol look at next
section.

root at genericarmv7a:~# gdb /bin/ls.coreutils -c core
GNU gdb (Linaro GDB) 7.6.1-2013.10
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-oe-linux-gnueabi".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /bin/ls.coreutils...Reading symbols from /bin/.debug/ls.coreutils...done.
done.

warning: core file may not match specified executable file.
[New LWP 12424]
Core was generated by `ls'.
Program terminated with signal 11, Segmentation fault.
#0  _getopt_initialize (argc=1, argv=0x7eeb29c4, posixly_correct=175936, d=0x2af40 <getopt_data>, 
    optstring=0x2a2b0 <rpl_optind> "\001") at lib/getopt.c:241
241	  if (optstring[0] == '-')
(gdb) bt   
#0  _getopt_initialize (argc=1, argv=0x7eeb29c4, posixly_correct=175936, d=0x2af40 <getopt_data>, 
    optstring=0x2a2b0 <rpl_optind> "\001") at lib/getopt.c:241
#1  _getopt_internal_r (argc=1, argv=0x7eeb29c4, optstring=0x2a2b0 <rpl_optind> "\001", 
    longopts=0x2a2d8 <interrupt_signal>, longind=0x1c1ac <rpl_getopt_internal+72>, 
    long_only=175936, d=0x2a2b0 <rpl_optind>, posixly_correct=0) at lib/getopt.c:361
#2  0x0002a2d8 in ?? ()
Cannot access memory at address 0x1
#3  0x0002a2d8 in ?? ()
Cannot access memory at address 0x1
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) info reg
r0             0x1	1
r1             0x7eeb2de4	2129341924
r2             0x0	0
r3             0x1	1
r4             0x2af40	175936
r5             0x2a2b0	172720
r6             0x0	0
r7             0x0	0
r8             0x7eeb29c4	2129340868
r9             0x2a2d8	172760
r10            0x1	1
r11            0x2a2d8	172760
r12            0x0	0
sp             0x7eeb2848	0x7eeb2848
lr             0x1c1ac	115116
pc             0x1b420	0x1b420 <_getopt_internal_r+340>
cpsr           0x200f0010	537853968
(gdb) set height 0
(gdb) disassemble _getopt_internal_r
Dump of assembler code for function _getopt_internal_r:
   0x0001b2cc <+0>:			; <UNDEFINED> instruction: 0xe7f001f9
   0x0001b2d0 <+4>:	sub	sp, sp, #68	; 0x44
   0x0001b2d4 <+8>:	subs	r10, r0, #0
   0x0001b2d8 <+12>:			; <UNDEFINED> instruction: 0xe7f001f9
   0x0001b2dc <+16>:	str	r3, [sp, #28]
   0x0001b2e0 <+20>:	str	r1, [sp, #24]
   0x0001b2e4 <+24>:	ldr	r3, [r4, #4]
   0x0001b2e8 <+28>:			; <UNDEFINED> instruction: 0xe7f001f9
   0x0001b2ec <+32>:	str	r3, [sp, #20]
   0x0001b2f0 <+36>:	ble	0x1b4f8 <_getopt_internal_r+556>
   0x0001b2f4 <+40>:	ldr	r3, [r4]
   0x0001b2f8 <+44>:	mov	r2, #0
   0x0001b2fc <+48>:	str	r2, [r4, #12]
   0x0001b300 <+52>:	cmp	r3, r2
   0x0001b304 <+56>:	beq	0x1b3f0 <_getopt_internal_r+292>
   0x0001b308 <+60>:	ldr	r2, [r4, #16]
   0x0001b30c <+64>:	cmp	r2, #0
   0x0001b310 <+68>:	beq	0x1b3f8 <_getopt_internal_r+300>
   0x0001b314 <+72>:	ldr	r5, [sp, #12]
   0x0001b318 <+76>:	ldrb	r3, [r5]
   0x0001b31c <+80>:	cmp	r3, #45	; 0x2d
   0x0001b320 <+84>:	cmpne	r3, #43	; 0x2b
   0x0001b324 <+88>:	ldrbeq	r3, [r5, #1]
   0x0001b328 <+92>:	addeq	r5, r5, #1
   0x0001b32c <+96>:	streq	r5, [sp, #12]
   0x0001b330 <+100>:	cmp	r3, #58	; 0x3a
   0x0001b334 <+104>:	ldr	r9, [r4, #20]
   0x0001b338 <+108>:	ldr	r12, [sp, #20]
   0x0001b33c <+112>:	moveq	r12, #0
   0x0001b340 <+116>:	cmp	r9, #0
   0x0001b344 <+120>:	str	r12, [sp, #20]
   0x0001b348 <+124>:	beq	0x1b458 <_getopt_internal_r+396>
   0x0001b34c <+128>:	ldrb	r3, [r9]
   0x0001b350 <+132>:	cmp	r3, #0
   0x0001b354 <+136>:	beq	0x1b458 <_getopt_internal_r+396>
   0x0001b358 <+140>:	str	r9, [sp, #16]
   0x0001b35c <+144>:	ldr	r12, [sp, #28]
   0x0001b360 <+148>:	cmp	r12, #0
   0x0001b364 <+152>:	beq	0x1b880 <_getopt_internal_r+1460>
   0x0001b368 <+156>:	ldr	r3, [r4]
   0x0001b36c <+160>:	ldr	r5, [sp, #24]
   0x0001b370 <+164>:	str	r3, [sp, #32]
   0x0001b374 <+168>:	ldr	r3, [r5, r3, lsl #2]
   0x0001b378 <+172>:	ldrb	r1, [r3, #1]
   0x0001b37c <+176>:	cmp	r1, #45	; 0x2d
   0x0001b380 <+180>:	beq	0x1b564 <_getopt_internal_r+664>
   0x0001b384 <+184>:	ldr	r12, [sp, #108]	; 0x6c
   0x0001b388 <+188>:	cmp	r12, #0
   0x0001b38c <+192>:	bne	0x1b548 <_getopt_internal_r+636>
   0x0001b390 <+196>:	ldr	r9, [sp, #16]
   0x0001b394 <+200>:	add	r6, r9, #1
   0x0001b398 <+204>:	str	r6, [r4, #20]
   0x0001b39c <+208>:	ldrb	r5, [r9]
   0x0001b3a0 <+212>:	ldr	r0, [sp, #12]
   0x0001b3a4 <+216>:	mov	r1, r5
   0x0001b3a8 <+220>:	bl	0x9db4 <strchr>
   0x0001b3ac <+224>:	ldrb	r3, [r6]
   0x0001b3b0 <+228>:	cmp	r3, #0
   0x0001b3b4 <+232>:	ldreq	r3, [r4]
   0x0001b3b8 <+236>:	addeq	r3, r3, #1
   0x0001b3bc <+240>:	streq	r3, [r4]
   0x0001b3c0 <+244>:	sub	r3, r5, #58	; 0x3a
   0x0001b3c4 <+248>:	cmp	r0, #0
   0x0001b3c8 <+252>:	cmpne	r3, #1
   0x0001b3cc <+256>:	bhi	0x1b6f0 <_getopt_internal_r+1060>
   0x0001b3d0 <+260>:	ldr	r12, [sp, #20]
   0x0001b3d4 <+264>:	cmp	r12, #0
   0x0001b3d8 <+268>:	bne	0x1b6b0 <_getopt_internal_r+996>
   0x0001b3dc <+272>:	mov	r1, #63	; 0x3f
   0x0001b3e0 <+276>:	str	r5, [r4, #8]
   0x0001b3e4 <+280>:	mov	r0, r1
   0x0001b3e8 <+284>:	add	sp, sp, #68	; 0x44
   0x0001b3ec <+288>:	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   0x0001b3f0 <+292>:	mov	r3, #1
   0x0001b3f4 <+296>:	str	r3, [r4]
   0x0001b3f8 <+300>:			; <UNDEFINED> instruction: 0xe7f001f9
   0x0001b3fc <+304>:	str	r3, [r4, #36]	; 0x24
   0x0001b400 <+308>:	cmp	r5, #0
   0x0001b404 <+312>:	str	r3, [r4, #32]
   0x0001b408 <+316>:			; <UNDEFINED> instruction: 0xe7f001f9
   0x0001b40c <+320>:	str	r3, [r4, #20]
   0x0001b410 <+324>:	movne	r0, #1
   0x0001b414 <+328>:	beq	0x1b530 <_getopt_internal_r+612>
   0x0001b418 <+332>:	ldr	r12, [sp, #12]
   0x0001b41c <+336>:	str	r0, [r4, #28]
=> 0x0001b420 <+340>:	ldrb	r3, [r12]
   0x0001b424 <+344>:	cmp	r3, #45	; 0x2d
   0x0001b428 <+348>:	beq	0x1b848 <_getopt_internal_r+1404>
   0x0001b42c <+352>:	cmp	r3, #43	; 0x2b
   0x0001b430 <+356>:	beq	0x1b868 <_getopt_internal_r+1436>
   0x0001b434 <+360>:	cmp	r0, #0


disassemble of _getopt_internal_r function
------------------------------------------

Just to see what instructions got breakpoint

(gdb) disassemble _getopt_internal_r
Dump of assembler code for function _getopt_internal_r:
   0x0001b2cc <+0>:	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
   0x0001b2d0 <+4>:	sub	sp, sp, #68	; 0x44
   0x0001b2d4 <+8>:	subs	r10, r0, #0
   0x0001b2d8 <+12>:	ldr	r4, [sp, #112]	; 0x70
   0x0001b2dc <+16>:	str	r3, [sp, #28]
   0x0001b2e0 <+20>:	str	r1, [sp, #24]
   0x0001b2e4 <+24>:	ldr	r3, [r4, #4]
   0x0001b2e8 <+28>:	str	r2, [sp, #12]
   0x0001b2ec <+32>:	str	r3, [sp, #20]
   0x0001b2f0 <+36>:	ble	0x1b4f8 <_getopt_internal_r+556>
   0x0001b2f4 <+40>:	ldr	r3, [r4]
   0x0001b2f8 <+44>:	mov	r2, #0
   0x0001b2fc <+48>:	str	r2, [r4, #12]
   0x0001b300 <+52>:	cmp	r3, r2
   0x0001b304 <+56>:	beq	0x1b3f0 <_getopt_internal_r+292>
   0x0001b308 <+60>:	ldr	r2, [r4, #16]
   0x0001b30c <+64>:	cmp	r2, #0
   0x0001b310 <+68>:	beq	0x1b3f8 <_getopt_internal_r+300>
   0x0001b314 <+72>:	ldr	r5, [sp, #12]
   0x0001b318 <+76>:	ldrb	r3, [r5]
   0x0001b31c <+80>:	cmp	r3, #45	; 0x2d
   0x0001b320 <+84>:	cmpne	r3, #43	; 0x2b
   0x0001b324 <+88>:	ldrbeq	r3, [r5, #1]
   0x0001b328 <+92>:	addeq	r5, r5, #1
   0x0001b32c <+96>:	streq	r5, [sp, #12]
   0x0001b330 <+100>:	cmp	r3, #58	; 0x3a
   0x0001b334 <+104>:	ldr	r9, [r4, #20]
   0x0001b338 <+108>:	ldr	r12, [sp, #20]
   0x0001b33c <+112>:	moveq	r12, #0
   0x0001b340 <+116>:	cmp	r9, #0
   0x0001b344 <+120>:	str	r12, [sp, #20]
   0x0001b348 <+124>:	beq	0x1b458 <_getopt_internal_r+396>
   0x0001b34c <+128>:	ldrb	r3, [r9]
   0x0001b350 <+132>:	cmp	r3, #0
   0x0001b354 <+136>:	beq	0x1b458 <_getopt_internal_r+396>
   0x0001b358 <+140>:	str	r9, [sp, #16]
   0x0001b35c <+144>:	ldr	r12, [sp, #28]
   0x0001b360 <+148>:	cmp	r12, #0
   0x0001b364 <+152>:	beq	0x1b880 <_getopt_internal_r+1460>
   0x0001b368 <+156>:	ldr	r3, [r4]
   0x0001b36c <+160>:	ldr	r5, [sp, #24]
   0x0001b370 <+164>:	str	r3, [sp, #32]
   0x0001b374 <+168>:	ldr	r3, [r5, r3, lsl #2]
   0x0001b378 <+172>:	ldrb	r1, [r3, #1]
   0x0001b37c <+176>:	cmp	r1, #45	; 0x2d
   0x0001b380 <+180>:	beq	0x1b564 <_getopt_internal_r+664>
   0x0001b384 <+184>:	ldr	r12, [sp, #108]	; 0x6c
   0x0001b388 <+188>:	cmp	r12, #0
   0x0001b38c <+192>:	bne	0x1b548 <_getopt_internal_r+636>
   0x0001b390 <+196>:	ldr	r9, [sp, #16]
   0x0001b394 <+200>:	add	r6, r9, #1
   0x0001b398 <+204>:	str	r6, [r4, #20]
   0x0001b39c <+208>:	ldrb	r5, [r9]
   0x0001b3a0 <+212>:	ldr	r0, [sp, #12]
   0x0001b3a4 <+216>:	mov	r1, r5
   0x0001b3a8 <+220>:	bl	0x9db4 <strchr>
   0x0001b3ac <+224>:	ldrb	r3, [r6]
   0x0001b3b0 <+228>:	cmp	r3, #0
   0x0001b3b4 <+232>:	ldreq	r3, [r4]
   0x0001b3b8 <+236>:	addeq	r3, r3, #1
   0x0001b3bc <+240>:	streq	r3, [r4]
   0x0001b3c0 <+244>:	sub	r3, r5, #58	; 0x3a
   0x0001b3c4 <+248>:	cmp	r0, #0
   0x0001b3c8 <+252>:	cmpne	r3, #1
   0x0001b3cc <+256>:	bhi	0x1b6f0 <_getopt_internal_r+1060>
   0x0001b3d0 <+260>:	ldr	r12, [sp, #20]
   0x0001b3d4 <+264>:	cmp	r12, #0
   0x0001b3d8 <+268>:	bne	0x1b6b0 <_getopt_internal_r+996>
   0x0001b3dc <+272>:	mov	r1, #63	; 0x3f
   0x0001b3e0 <+276>:	str	r5, [r4, #8]
   0x0001b3e4 <+280>:	mov	r0, r1
   0x0001b3e8 <+284>:	add	sp, sp, #68	; 0x44
   0x0001b3ec <+288>:	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
   0x0001b3f0 <+292>:	mov	r3, #1
   0x0001b3f4 <+296>:	str	r3, [r4]
   0x0001b3f8 <+300>:	ldr	r5, [sp, #116]	; 0x74
   0x0001b3fc <+304>:	str	r3, [r4, #36]	; 0x24
   0x0001b400 <+308>:	cmp	r5, #0
   0x0001b404 <+312>:	str	r3, [r4, #32]
   0x0001b408 <+316>:	mov	r3, #0
   0x0001b40c <+320>:	str	r3, [r4, #20]
   0x0001b410 <+324>:	movne	r0, #1
   0x0001b414 <+328>:	beq	0x1b530 <_getopt_internal_r+612>
   0x0001b418 <+332>:	ldr	r12, [sp, #12]
   0x0001b41c <+336>:	str	r0, [r4, #28]
   0x0001b420 <+340>:	ldrb	r3, [r12]
   0x0001b424 <+344>:	cmp	r3, #45	; 0x2d
   0x0001b428 <+348>:	beq	0x1b848 <_getopt_internal_r+1404>
   0x0001b42c <+352>:	cmp	r3, #43	; 0x2b
   0x0001b430 <+356>:	beq	0x1b868 <_getopt_internal_r+1436>
   0x0001b434 <+360>:	cmp	r0, #0


Victor Kamensky (1):
  ARM: uprobes need icache flush after xol write

 arch/arm/kernel/uprobes.c |  6 ++++++
 include/linux/uprobes.h   |  3 +++
 kernel/events/uprobes.c   | 20 +++++++++++++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
1.8.1.4
