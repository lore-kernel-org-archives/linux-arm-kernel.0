From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 17 Jun 2010 12:30:37 +0200
Subject: invalid address for enqueue_task
Message-ID: <201006171230.38101.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been redirecting to this mailing list after mailing to Ingo Molnar.
On several AT91SAM9G20 (arm9) based boards i get the following kernel panic 
message:

Unable to handle kernel paging request at virtual address f0bc5a20                                                                           
pgd = c1e7c000                                                                                                                                                   
[f0bc5a20] *pgd=00000000                                                                                                                                         
Internal error: Oops: 0 [#1]                                                                                                                                     
Modules linked in:                                                                                                                                               
CPU: 0    Not tainted  (2.6.31.12 #3)                                                                                                                            
PC is at 0xf0bc5a20                                                                                                                                              
LR is at enqueue_task+0x28/0x34                                                                                                                                  
pc : [<f0bc5a20>]    lr : [<c0031108>]    psr: 200000b3                                                                                                          
sp : c1e0de38  ip : 00000000  fp : c1e0de4c                                                                                                                      
r10: 00005b2a  r9 : 7fffffff  r8 : ffffffff                                                                                                                      
r7 : 00000187  r6 : 197f8400  r5 : c1d9b0c0  r4 : c1d9b0c0                                                                                                       
r3 : c023ccd8  r2 : 00000001  r1 : c1d9b0c0  r0 : c030d480                                                                                                       
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 0005317f  Table: 21e7c000  DAC: 00000015
Process gpsnewag (pid: 482, stack limit = 0xc1e0c270)
Stack: (0xc1e0de38 to 0xc1e0e000)
de20:                                                       00000001 c030d480
de40: 00000000 00000001 c1e0de5c c00311cc c030d480 c1d9b0c0 c1e0de7c c0033614
de60: 60000093 a0000093 c1e4df28 c030f408 c030f3b8 c004e26c 3a2cdb8c c004e28c
de80: ffffffff c004e57c 00000000 00000001 c0326430 3a2cdb8c c030f408 c004f118
dea0: 00000000 c030f408 0d8566c7 4c192744 0000004e 00005b2a 3a2cdb8c 00005b2a
dec0: befaccfc c0326480 00000000 00000000 00000013 c0026e84 c1e0c000 401a0b60
dee0: befaccfc c01b3ec8 ffffffff c0065bcc ffffffff c0310a1c 00000013 c0310a58
df00: c0326480 c006749c 00000013 00000000 00000013 0000004e c0026e84 c0026068
df20: 60000013 ffffffff fefff000 c0026994 befaccd8 c1e0df90 00000004 00000000
df40: 00000000 befaccd8 c1e0df90 0000004e c0026e84 c1e0c000 401a0b60 befaccfc
df60: 00000000 c1e0df7c c003bd0c c012dc34 60000013 ffffffff c1e0c000 befaccd8
df80: 00000008 00000000 00000000 c003bd0c 4c192744 0003760f befacce8 00000140
dfa0: 00000000 c0026d00 befacce8 00000140 befaccd8 00000000 00000000 befacce8
dfc0: befacce8 00000140 00000000 0000004e 00000000 00000000 401a0b60 befaccfc
dfe0: 00000000 befaccd8 400eb3fc 400eb42c 60000010 befaccd8 00000000 00000000
Code: bad PC value.
Kernel panic - not syncing: Fatal exception in interrupt
[<c002b86c>] (unwind_backtrace+0x0/0xd4) from [<c0237580>] (panic+0x40/0x118)
[<c0237580>] (panic+0x40/0x118) from [<c002a6b8>] (die+0xa8/0xc8)
[<c002a6b8>] (die+0xa8/0xc8) from [<c002c974>] (__do_kernel_fault+0x64/0x74)
[<c002c974>] (__do_kernel_fault+0x64/0x74) from [<c002cb9c>] 
(do_translation_fault+0x68/0x74)
[<c002cb9c>] (do_translation_fault+0x68/0x74) from [<c0026a6c>] 
(__pabt_svc+0x4c/0x80)
[<c0026a6c>] (__pabt_svc+0x4c/0x80) from [<f0bc5a20>] (0xf0bc5a20)

After doing some research I found out that sched_class inside struct_task has 
been modified to some bogus address so sched_class->enqueue_task 
(kernel/sched.c:1886) jumps to some invalid address.
I also tried using the 2.6.34 kernel which results in quite the same problem.

BUG: sleeping function called from invalid context at mm/slub.c:1705                                                                                   
in_atomic(): 1, irqs_disabled(): 128, pid: 484, name: gpsnewag                                                                                                   
1 lock held by gpsnewag/484:                                                                                                                                     
 #0:  (&rq->lock){......}, at: [<c0030d20>] task_rq_lock+0x60/0x78                                                                                               
[<c002a7d8>] (unwind_backtrace+0x0/0xec) from [<c008fdc8>] 
(kmem_cache_alloc+0x38/0xc0)                                                                          
[<c008fdc8>] (kmem_cache_alloc+0x38/0xc0) from [<c0233024>] 
(generic_create_cred+0x14/0xe8)                                                                      
[<c0233024>] (generic_create_cred+0x14/0xe8) from [<c0232630>] 
(rpcauth_lookup_credcache+0x128/0x2a0)                                                            
[<c0232630>] (rpcauth_lookup_credcache+0x128/0x2a0) from [<c0232420>] 
(rpcauth_lookupcred+0xa0/0xe8)                                                             
[<c0232420>] (rpcauth_lookupcred+0xa0/0xe8) from [<c00f3e2c>] 
(nfs_open+0xc/0x64)                                                                                
[<c00f3e2c>] (nfs_open+0xc/0x64) from [<c002ff38>] (enqueue_task+0x28/0x34)                                                                                      
^^^^
A valid but wrong pointer obviously here!

[<c002ff38>] (enqueue_task+0x28/0x34) from [<c0030000>] 
(activate_task+0x38/0x44)                                                                                
[<c0030000>] (activate_task+0x38/0x44) from [<c00327b0>] 
(try_to_wake_up+0x60/0xf0)                                                                              
[<c00327b0>] (try_to_wake_up+0x60/0xf0) from [<c004f0ac>] 
(hrtimer_wakeup+0x20/0x28)                                                                             
[<c004f0ac>] (hrtimer_wakeup+0x20/0x28) from [<c004f3ec>] 
(__run_hrtimer+0x50/0xa4)                                                                              
[<c004f3ec>] (__run_hrtimer+0x50/0xa4) from [<c004f578>] 
(hrtimer_interrupt+0x138/0x310)                                                                         
[<c004f578>] (hrtimer_interrupt+0x138/0x310) from [<c01bb690>] 
(ch2_irq+0x20/0x28)                                                                               
[<c01bb690>] (ch2_irq+0x20/0x28) from [<c006817c>] 
(handle_IRQ_event+0x24/0xc4)                                                                                  
[<c006817c>] (handle_IRQ_event+0x24/0xc4) from [<c0069e10>] 
(handle_level_irq+0xb8/0x134)                                                                        
[<c0069e10>] (handle_level_irq+0xb8/0x134) from [<c002506c>] 
(asm_do_IRQ+0x6c/0x98)                                                                              
[<c002506c>] (asm_do_IRQ+0x6c/0x98) from [<c00259f4>] (__irq_svc+0x34/0x60)                                                                                      
Exception stack(0xc1e6df20 to 0xc1e6df68)                                                                                                                        
df20: beaefcdc c1e6df98 ffffffe8 00000000 00000000 beaefcd8 c1e6df90 0000004e                                                                                    
df40: 4752a851 c1e6c000 401a0b60 beaefcfc 00000018 c1e6df6c 0005c228 c01314f4                                                                                    
df60: 00000013 ffffffff                                                                                                                                          
[<c00259f4>] (__irq_svc+0x34/0x60) from [<c01314f4>] 
(__copy_to_user_std+0xd4/0x3a8)                     

Again sched_class is destroyed again. This problem only occurs after several 
hours of run time (5h or more). Sometimes only 30min.
Have you any idea which could cause such a problem? Do you need more 
information?

Best regards
Alexander
