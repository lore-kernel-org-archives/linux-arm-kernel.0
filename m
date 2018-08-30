From: Eugeniy.Paltsev@synopsys.com (Eugeniy Paltsev)
Date: Thu, 30 Aug 2018 11:53:17 +0000
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <20180830095148.GB5942@arm.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
Message-ID: <1535629996.4465.44.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, 2018-08-30 at 10:51 +0100, Will Deacon wrote:
> On Thu, Aug 30, 2018 at 11:44:11AM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 29, 2018 at 09:16:43PM +0000, Vineet Gupta wrote:
> > > On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:
> > > > Hi Guys,
> > > > Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
> > > > The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
> > > > even on boot.
> > > > 
> > > > I don't know exactly what breaks but bisect clearly assign the blame to this commit:
> > > > 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_torvalds_linux_commit_84c6591103dbeaf393a092a3fc7b09510825f6b9&d=DwIBAg&c=DPL6
> > > > _X_6JkXFx7AXWqB0tg&r=ZlJN1MriPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=6y0FFvkGdIQ6kX2lZ31V99lMfMV-
> > > > RyWyYhiUGzh0Bi0&s=GNwmhSynIcWqgZhiOwFEEH_AtbZAH443_L6QH4nw_ls&e=
> > > > 
> > > > Reverting the commit solves this problem.
> > > > 
> > > > I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
> > > > generic bitops implementation and it works fine.
> > > > 
> > > > Do you have any ideas what went wrong?
> > > 
> > > Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> > > commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> > > __clear_bit_unlock()")
> > > That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> > > __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> > > 
> > > This patch undoes that which could explain the issues you see. @Peter, @Will ?
> > 
> > Right, so the thinking is that on platforms that suffer that issue,
> > atomic_set*() should DTRT. And if you look at your spinlock based atomic
> > implementation, you'll note that atomic_set() does indeed do the right
> > thing.
> > 
> > arch/arc/include/asm/atomic.h:108
> 
> Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644c56a
> boils down to concurrent atomic_long_set_release() vs
> atomic_long_fetch_or_acquire(), which really needs to work.
> 
> I'll keep digging. In the meantime, Vineet, do you have any useful crash
> logs and do you only see the crashes in certain configurations (e.g. SMP but
> !CONFIG_ARC_HAS_LLSC)?

We don't have such configuration (SMP with !CONFIG_ARC_HAS_LLSC).

I can see crashes with LLSC enabled in both SMP running on 4 cores
and SMP running on 1 core.


There are some crash logs (not sure if they are really useful):
Crashes are quite spontaneous and mostly happens in IO-related code: 

Crash on boot:
------------------------>8----------------------------
usb 1-1: new high-speed USB device number 2 using ehci-platform
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
usb 1-1.1: new high-speed USB device number 3 using ehci-platform
usb-storage 1-1.1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1.1:1.0
scsi 0:0:0:0: Direct-Access     Generic  STORAGE DEVICE   0272 PQ: 0 ANSI: 0
sd 0:0:0:0: [sda] 15759360 512-byte logical blocks: (8.07 GB/7.51 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 0b 00 00 08
sd 0:0:0:0: [sda] No Caching mode page found
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI removable disk
INFO: task start-stop-daem:85 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
start-stop-daem D    0    85     81 0x00000000

Stack Trace:
  __switch_to+0x0/0xac
  __schedule+0x1b2/0x730
  io_schedule+0x5c/0xc0
  __lock_page+0x98/0xdc
  find_lock_entry+0x38/0x100
  shmem_getpage_gfp.isra.3+0x82/0xbfc
  shmem_fault+0x46/0x138
  handle_mm_fault+0x5bc/0x924
  do_page_fault+0xfc/0x294
  ret_from_exception+0x0/0x8
INFO: task start-stop-daem:85 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
start-stop-daem D    0    85     81 0x00000000
------------------------>8----------------------------

------------------------>8----------------------------
BUG: failure at mm/page-writeback.c:2652/clear_page_dirty_for_io()!

gcc generated __builtin_trap
Path: (null)
CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 4.18.0-06995-g54dbe75bbf1e #22
Workqueue: writeback wb_workfn (flush-8:0)

[ECR   ]: 0x00090005 => gcc generated __builtin_trap
[EFA   ]: 0x90162b50
[BLINK ]: clear_page_dirty_for_io+0x13a/0x164
[ERET  ]: abort+0x2/0x4
[STAT32]: 0x80080802 : IE K    
BTA: 0x9021e356  SP: 0xbf045c64  FP: 0x00000000
LPS: 0x9067fa68 LPE: 0x9067fa7c LPC: 0x00000000
r00: 0x00000043 r01: 0xbfb462d4 r02: 0x00000000
r03: 0x90157788 r04: 0x00000000 r05: 0x9080c040
r06: 0x00000031 r07: 0x00000000 r08: 0xa9ee8400
r09: 0x0000001e r10: 0x00000100 r11: 0x00000000
r12: 0x9021e35a r13: 0xbff33a54 r14: 0xbe87e124
r15: 0xbf045e50 r16: 0xbe87e124 r17: 0x0000470c
r18: 0x0000000f r19: 0x902afee4 r20: 0xbf045cf4
r21: 0xffffffff r22: 0x9080e474 r23: 0x00000000
r24: 0xbff33a54 r25: 0xbf031680



Stack Trace:
 abort+0x2/0x4
 clear_page_dirty_for_io+0x13a/0x164
 write_cache_pages+0x10a/0x328
 mpage_writepages+0x3c/0x94
 do_writepages+0x42/0x398
 __writeback_single_inode+0x2a/0x154
 wb_writeback+0x524/0xac8
 wb_workfn+0x17c/0x34c
 process_one_work+0x1a0/0x354
 worker_thread+0x108/0x4a0
 kthread+0x10c/0x110
 ret_from_fork+0x18/0x1c
------------------------>8----------------------------

------------------------>8----------------------------
# 
# mkdir -p /mnt/mmc2/ttt && mount /dev/sda1 /mnt/mmc2/ttt && df -h /mnt/mmc2/ttt
 && bonnie++ -u root -r 256 -s 512 -x 1 -d /mnt/mmc2/ttt && echo
'OK' &
# FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
Filesystem                Size      Used Available
Use% Mounted on
/dev/sda1                 2.0G      4.0K      2.0G   0% /mnt/mmc2/ttt
Using uid:0, gid:0.
Writing with putc()...random: crng init done
don
e
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in
sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files
in random order...done.
Delete files in random order...INFO: task kworker/u8:0:7 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #41
"echo
0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u8:0    D    0     7      2 0x00000000
Workqueue: writeback wb_workfn
(flush-8:0)

Stack Trace:
  __switch_to+0x0/0xac
  __schedule+0x1b8/0x734
  io_schedule+0x5c/0xc0
  __lock_page+0x9a/0xdc
  generic_writepages+0xc6/0x384
  do_writepages+0x42/0x398
  __writeback_single_inode+0x2a/0x154
  wb_writeback+0x524/0xac8
  wb_workfn+0x21a/0x34c
  process_one_work+0x1a0/0x354
  worker_thread+0x108/0x4a0
  kthread+0x10c/0x110
  ret_from_fork+0x18/0x1c
INFO: task kworker/u8:0:7 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #41
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u8:0    D    0     7      2 0x00000000
Workqueue: writeback wb_workfn (flush-8:0)
------------------------>8----------------------------

------------------------>8----------------------------
# 
# hackbench
Running in process mode with 10 groups using 40 file descriptors each (== 400 tasks)
Each sender will pass 100 messages of 100 bytes
INFO: task hackbench:519 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
hackbench       D    0   519    110 0x00000000

Stack Trace:
  __switch_to+0x0/0xac
  __schedule+0x1b2/0x730
  io_schedule+0x5c/0xc0
  __lock_page+0x98/0xdc
  handle_mm_fault+0x594/0xe1c
  do_page_fault+0xfc/0x294
  ret_from_exception+0x0/0x8
INFO: task hackbench:519 blocked for more than 10 seconds.
      Not tainted 4.19.0-rc1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
hackbench       D    0   519    110 0x00000000
------------------------>8----------------------------


-- 
 Eugeniy Paltsev
