From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  2 Jun 2014 22:46:08 -0700
Subject: [PATCH] arm64: ptrace: fix empty registers set in prstatus of aarch32
 process core
Message-ID: <1401774369-7060-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

I've run into situation when core of aarch32 (V7) process created
by V8 kernel has empty registers set saved in prstatus notes. As
result core file are broken. Below are details on the issues. Proposed
patch follows this cover letter. 

Test Case For Problem
---------------------

V8 kernel runs with v7 rootfs. Below output for BE system but LE has
the same issue. hello test case compiled as v7 code. Notice that
all registers in core file are zeros.

root at genericarmv7ab:~# cat hello.c 
#include <stdio.h>

int main (void)
{
    printf("Hello, world\n");
    *(int *) 0 = 0;
}
root at genericarmv7ab:~# ./hello
Hello, world
hello[825]: unhandled level 3 translation fault (11) at 0x00000000, esr 0x92000047
pgd = ffffffc07cb02000
[00000000] *pgd=00000000fcad2003, *pmd=00000000fcad9003, *pte=0000000000000000

CPU: 0 PID: 825 Comm: hello Not tainted 3.15.0-rc5+ #1
task: ffffffc07dbf0000 ti: ffffffc07c978000 task.ti: ffffffc07c978000
PC is at 0x8434
LR is at 0xf74e03c4
pc : [<0000000000008434>] lr : [<00000000f74e03c4>] pstate: 600f0210
sp : 00000000ff9ce128
x12: 000000000000000d 
x11: 00000000ff9ce12c x10: 00000000f75d2000 
x9 : 0000000000000000 x8 : 0000000000000000 
x7 : 0000000000000000 x6 : 00000000000082f4 
x5 : 0000000000000000 x4 : 00000000ff9ce148 
x3 : 0000000000000000 x2 : 0000000000000000 
x1 : 0000000000000000 x0 : 000000000000000d 

Segmentation fault (core dumped)
root at genericarmv7ab:~# gdb hello 
GNU gdb (Linaro GDB) 7.6.1-2013.10
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "armeb-oe-linux-gnueabi".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/root/hello...done.
(gdb) target core core
[New LWP 825]
Program terminated with signal 11, Segmentation fault.
#0  0x00000000 in ?? ()
(gdb) info reg
r0             0x0      0
r1             0x0      0
r2             0x0      0
r3             0x0      0
r4             0x0      0
r5             0x0      0
r6             0x0      0
r7             0x0      0
r8             0x0      0
r9             0x0      0
r10            0x0      0
r11            0x0      0
r12            0x0      0
sp             0x0      0x0
lr             0x0      0
pc             0x0      0x0
cpsr           0x0      0
(gdb) 

If one look at core file notes it can see that all registers in
PRSTATUS note are zeros:

[root at kamensky-w530 root]# eu-readelf --notes ~kamensky/v8v7-core/v8_v7_le_core 

Note segment of 984 bytes at offset 0x1f4:
  Owner          Data size  Type
  CORE                 148  PRSTATUS
    info.si_signo: 11, info.si_code: 0, info.si_errno: 0, cursig: 11
    sigpend: <>
    sighold: <>
    pid: 1358, ppid: 1351, pgrp: 1358, sid: 1349
    utime: 0.000000, stime: 0.020000, cutime: 0.000000, cstime: 0.000000
    orig_r0: 0, fpvalid: 0
    r0:             0  r1:             0  r2:             0
    r3:             0  r4:             0  r5:             0
    r6:             0  r7:             0  r8:             0
    r9:             0  r10:            0  r11:            0
    r12:            0  sp:    0x00000000  lr:    0x00000000
    pc:    0x00000000  spsr:  0x00000000


Writing prstatus code under debugger
------------------------------------

Here is backtrace of code that writes PRSTATUS note. compat_gpr_get
called to fill in registers value. Note kbuf has valid address,
ubuf is 0.

#0 compat_gpr_get( target = (struct task_struct*) 0xFFFFFFC07CB39400, regset = (const struct user_regset*) 0xFFFFFFC0003D5290, pos = 0, count = 72, kbuf = (void*) 0xFFFFFFC07CFE4158, ubuf = (void*) 0x0 ) at ptrace.c:622
#1 fill_note( data = (void*) 0xFFFFFFC07CFE4110, sz = 148, type = 1, name = 0xFFFFFFC0004C4670 "CORE", note = (struct memelfnote*) 0xFFFFFFC07CFE41A8 ) at binfmt_elf.c:1279
#2 fill_thread_core_info( view = (const struct user_regset_view*) 0xFFFFFFC0003D5300, view = (const struct user_regset_view*) 0xFFFFFFC0003D5300, total = (size_t*) 0xFFFFFFC07C8B3B18, signr = <Value currently has no location>, t = (struct elf_thread_core_info*) 0xFFFFFFC07CFE4100 ) at binfmt_elf.c:1541
#3 elf_core_dump( cprm = (struct coredump_params*) 0xFFFFFFC07C8B3C38 ) at binfmt_elf.c:2123
#4 write_note_info( cprm = (struct coredump_params*) 0xFFFFFFC07C8B3C38, info = (struct elf_note_info*) 0xFFFFFFFFFFFFFFF8 ) at binfmt_elf.c:1698
#5 do_coredump( siginfo = <Value optimised away by compiler> ) at coredump.c:667
#6 get_signal_to_deliver( info = (siginfo_t*) 0xFFFFFFC07C8B3DF0, return_ka = (struct k_sigaction*) 0xFFFFFFC07C8B3E70, regs = <Value optimised away by compiler>, cookie = <Value optimised away by compiler> ) at signal.c:2372
#7 do_signal( regs = (struct pt_regs*) 0xFFFFFFC07C8B3ED0 ) at signal.c:377
#8 do_notify_resume( regs = <Value optimised away by compiler>, thread_flags = <Value optimised away by compiler> ) at signal.c:413
#9 [/wd1/linaro/linux-build/_le_64_linus_062/vmlinux EL1N:0xFFFFFFC00008428C ]
p ubuf
$30 = (void*) 0x0
p kbuf
$31 = (void*) 0xFFFFFFC07CFE4158


Fix
---

In compat_gpr_get and compat_gpr_set functions
handle kbuf and ubuf as two separate cases as other similar functions do,
i.e user_regset_copyout, user_regset_copyin functions

Tests
-----

Tested core files or single threaded and multithread aarch32 processes.
Able to see registers value, execute backtrace command, etc.

Thanks,
Victor

Victor Kamensky (1):
  arm64: ptrace: fix empty registers set in prstatus of aarch32 process
    core

 arch/arm64/kernel/ptrace.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

-- 
1.8.1.4
