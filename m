From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 15 Feb 2013 10:25:21 +0100
Subject: i.MX6 Solo: maxcpus=1 vs. nosmp: Warning from smp_twd.c?
In-Reply-To: <20130214143752.GH17833@n2100.arm.linux.org.uk>
References: <511CF063.3010200@de.bosch.com>
 <20130214143752.GH17833@n2100.arm.linux.org.uk>
Message-ID: <511DFF01.8000508@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2013 15:37, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 03:10:43PM +0100, Dirk Behme wrote:
>> working on a i.MX6 Solo SoC (one Cortex A9 core) we are usually booting  
>> with maxcpus=1 a kernel built with CONFIG_NR_CPUS=4. This is done to be  
>> able to boot the same kernel on the Solo and Quad version of that SoC.
> 
> And what happens if you compile a kernel without SMP support and boot
> it on this SoC?

- Case 1:

Kernel command line: ... nosmp ...
$ cat .config | grep SMP
CONFIG_USE_GENERIC_SMP_HELPERS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_SMP=y
CONFIG_SMP=y
CONFIG_SMP_ON_UP=y

=> Gives warning [1] as reported


- Case 2:

Kernel command line: ... nosmp ...
$ cat .config | grep SMP
CONFIG_BROKEN_ON_SMP=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_SMP=y
# CONFIG_SMP is not set

=> Boots without warning


Best regards

Dirk


[1]

...
sched_clock: 32 bits at 49MHz, resolution 20ns, wraps every 86767ms
------------[ cut here ]------------
WARNING: at arch/arm/kernel/smp_twd.c:345 
twd_local_timer_of_register+0x7c/0x90()
twd_local_timer_of_register failed (-6)
Modules linked in:
Backtrace:
[<80011f14>] (dump_backtrace+0x0/0x10c) from [<8044dd30>] 
(dump_stack+0x18/0x1c)
  r7:805e9f58 r6:805ba84c r5:80539331 r4:00000159
[<8044dd18>] (dump_stack+0x0/0x1c) from [<80020fbc>] 
(warn_slowpath_common+0x54/0x6c)
[<80020f68>] (warn_slowpath_common+0x0/0x6c) from [<80021078>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:412fc09a r8:8fffffff r7:ffffffff r6:00000001 r5:80633b8c
r4:80b32da8
[<80021040>] (warn_slowpath_fmt+0x0/0x40) from [<805ba84c>] 
(twd_local_timer_of_register+0x7c/0x90)
  r3:fffffffa r2:8053934b
[<805ba7d0>] (twd_local_timer_of_register+0x0/0x90) from [<805c0bec>] 
(imx6q_timer_init+0x18/0x4c)
  r5:80633800 r4:8053b701
[<805c0bd4>] (imx6q_timer_init+0x0/0x4c) from [<805ba4e8>] 
(time_init+0x28/0x38)
  r5:80633800 r4:805dc0f4
[<805ba4c0>] (time_init+0x0/0x38) from [<805b6854>] 
(start_kernel+0x1a0/0x310)
[<805b66b4>] (start_kernel+0x0/0x310) from [<10008044>] (0x10008044)
  r8:1000406a r7:805f3f8c r6:805dc0c4 r5:805f0518 r4:10c5387d
---[ end trace 1b75b31a2719ed1c ]---
CPU identified as i.MX6S/DL, silicon rev 1.0
...
