From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 11 Oct 2012 07:46:35 +0200
Subject: bug with 3.4.6, 3.5.3, 3.6.1
Message-ID: <50765D3B.6000909@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

when booting Linux v3.4.6, v3.5.3, or v3.6.1 on a pandaboard with an 
OMAP4430 ES2.1, compiled with the following configuration:
http://xenomai.org/~gch/config-panda

I get the bug below after mounting the root filesystem.

CONFIG_VMSPLIT_2G and CONFIG_THUMB2_KERNEL disabled seems to be the 
combination which triggers the bug.

With this configuration, it seems the init_mm.mm_count incrementation
done at the beginning of secondary_start_kernel() is "lost" after the
calls to cpu_switch_mm() and local_flush_tlb().

Modifying the secondary_startup() function in head.S to pass the 
swapper pgdir instead of the idmap pgdir in r4 also avoids the issue.

Regards.


init (301): undefined instruction: pc=80027fe0                                   
Code: e59f3058 e1a04000 e1500003 1a000000 (e7f001f2)                             
------------[ cut here ]------------                                             
kernel BUG at kernel/fork.c:558!                                                 
Internal error: Oops - BUG: 0 [#1] SMP ARM                                       
CPU: 1    Tainted: G        W     (3.4.6+ #61)                                   
PC is at __mmdrop+0x1c/0x78                                                      
LR is at finish_task_switch+0xa4/0xec                                            
pc : [<80027fe0>]    lr : [<80049a78>]    psr: 60000113                          
sp : bfa79f60  ip : bfa79f78  fp : bfa79f74                                      
r10: 00000000  r9 : 00000000  r8 : 00000000                                      
r7 : 00000000  r6 : 00000000  r5 : bf83a080  r4 : 803655c8                       
r3 : 803655c8  r2 : 00000000  r1 : 00000000  r0 : 803655c8                       
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user                
Control: 10c53c7d  Table: bfa7c04a  DAC: 00000015                                
Process init (pid: 301, stack limit = 0xbfa782f0)                                
Stack: (0xbfa79f60 to 0xbfa7a000)                                                
9f60: 803655c8 bf83a080 bfa79f94 bfa79f78 80049a78 80027fd0 80be2100 bf83a080    
9f80: 00000000 00000000 bfa79fac bfa79f98 8004b2e0 800499e0 00000000 00000000    
9fa0: 00000000 bfa79fb0 8000de44 8004b2ac 00000000 7ee4aba0 76f734c0 00000000    
9fc0: 000e21e0 7ee4ac7c 00000001 000000be 00000305 00000000 0001196c 00000000    
9fe0: 00000075 7ee4ac30 000a2494 76e07384 60000010 80000000 ffefffff 00000000    
Backtrace:                                                                       
[<80027fc4>] (__mmdrop+0x0/0x78) from [<80049a78>] (finish_task_switch+0xa4/0xec)
 r5:bf83a080 r4:803655c8                                                         
[<800499d4>] (finish_task_switch+0x0/0xec) from [<8004b2e0>] (schedule_tail+0x40/0xd0)                                                                            
 r7:00000000 r6:00000000 r5:bf83a080 r4:80be2100                                 
[<8004b2a0>] (schedule_tail+0x0/0xd0) from [<8000de44>] (ret_from_fork+0x8/0x44) 
 r5:00000000 r4:00000000                                                         
Code: e59f3058 e1a04000 e1500003 1a000000 (e7f001f2)                             
mappings:                                                                        
0x00008000-0x000d7000 r-xp 0x00000000 /bin/busybox                               
0x000df000-0x000e0000 rw-p 0x000cf000 /bin/busybox                               
0x000e0000-0x00103000 rw-p 0x000e0000 [heap]                                     
0x76d66000-0x76ea1000 r-xp 0x00000000 /lib/libc.so.6                             
0x76ea1000-0x76ea9000 ---p 0x0013b000 /lib/libc.so.6                             
0x76ea9000-0x76eab000 r--p 0x0013b000 /lib/libc.so.6                             
0x76eab000-0x76eac000 rw-p 0x0013d000 /lib/libc.so.6                             
0x76eac000-0x76eaf000 rw-p 0x76eac000                                            
0x76eaf000-0x76f47000 r-xp 0x00000000 /lib/libm.so.6                             
0x76f47000-0x76f4e000 ---p 0x00098000 /lib/libm.so.6                             
0x76f4e000-0x76f4f000 r--p 0x00097000 /lib/libm.so.6                             
0x76f4f000-0x76f50000 rw-p 0x00098000 /lib/libm.so.6                             
0x76f50000-0x76f6f000 r-xp 0x00000000 /lib/ld-linux.so.3                         
0x76f73000-0x76f74000 rw-p 0x76f73000                                            
0x76f75000-0x76f76000 rw-p 0x76f75000                                            
0x76f76000-0x76f77000 r--p 0x0001e000 /lib/ld-linux.so.3                         
0x76f77000-0x76f78000 rw-p 0x0001f000 /lib/ld-linux.so.3                         
0x7ee29000-0x7ee4b000 rw-p 0x7efde000 [stack]                                    
---[ end trace 1b75b31a2719ed1e ]---                                             

-- 
                                                                Gilles.
