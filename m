From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 16 Mar 2015 19:16:05 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150316181634.GK8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk> <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk>
Message-ID: <55072BF5.7030901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/03/15 18:16, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 05:47:46PM +0000, Sudeep Holla wrote:
>> Hi Russell,
>>
>> I was able to see exact behaviour on my VExpress setup with CA9X4 core-tile.
>> Few observations from my side:
>>
>> 1. This issue can be reproduced even on v3.19
>> 2. As you suspected L2C, I tried disabling L2C and it seems to solve
>>     the issue
>
> My L2C says it's cache ID is 0x410000c3 - which is indeed a L2C-310, but
> with an undocumented revision ID of 3, which as far as we can make out,
> it's a R1Px where x > 0.
>
>> 3. Since it's very random and enabling LL_DEBUG made it difficult to
>>     reproduce the issue, I tried to dump the stack using DS5 debugger
>> 4. The stack is exactly same always both on v4.0-rc* and v3.19 kernel
>>     and on multiple runs
>
> Hmm, I haven't seen them before I moved to 4.0-rc3 - before then my
> nightly boot tests (which run two boots on the platform each night)
> always seemed to succeed.
>
>> 5. Connecting to h/w debugger, stopping and re-starting the CPUs,
>>     solves the issue. It's helping CPUs to get out of __radix_tree_lookup
>>     somehow
>
> Interesting.  Are the traces below from 4.0-rc3 or an older kernel?
>

This one is with v3.19 but I get exact same trace with v4.0-rc* kernel.

>> Stacktrace
>> ==========
>> (sorry it's looks different from std. Linux backtrace as this one id dump
>> from DS5)
>>
>> CPU 0
>> ----
>> #0 __radix_tree_lookup( root = <Value currently has no location>, index =
>> 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at
>> radix-tree.c:517
>
> Can you dump the disassembly around this location for both CPU0 and CPU1
> and the register values please?  I think it would be interesting to see
> if they're both stuck on exactly the same address access.
>

(with v4.0-rc4 this time)

CPU#0
=====
#0 __radix_tree_lookup( root = <Value currently has no location>, index 
= 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at 
radix-tree.c:517
     node = (struct radix_tree_node*) 0xBEC00001
     parent = <Value optimised away by compiler>
     height = 1
     shift = 0
     slot = <Value currently has no location>
#1 generic_handle_irq( irq = 16 ) at irqdesc.c:349
     desc = <Value optimised away by compiler>
#2 __handle_domain_irq( domain = (struct irq_domain*) 0xBF004400, hwirq 
= 16, lookup = <Value currently has no location>, regs = <Value 
currently has no location> ) at irqdesc.c:391
     old_regs = (struct pt_regs*) 0x0
     irq = <Value optimised away by compiler>
     ret = 0
#3 __raw_readl( addr = <Value optimised away by compiler> ) at io.h:121
#4 gic_handle_irq( regs = (struct pt_regs*) 0x805F1F40 ) at irq-gic.c:277
     irqstat = 2147518036
     irqnr = <Value currently has no location>
     gic = <Value optimised away by compiler>
     cpu_base = (void*) 0xC0802100
#5 [__irq_svc+0x40]

S:0x8021F80C : LSL      lr,r4,#3
S:0x8021F810 : SUB      lr,lr,r4,LSL #1
S:0x8021F814 : SUB      lr,lr,#6
S:0x8021F818 : B        {pc}+8 ; 0x8021f820
S:0x8021F81C : MOV      r5,r0
S:0x8021F820 : LSR      r12,r1,lr
S:0x8021F824 : SUB      lr,lr,#6
S:0x8021F828 : AND      r12,r12,#0x3f
S:0x8021F82C : ADD      r12,r12,#6
S:0x8021F830 : LDR      r0,[r5,r12,LSL #2]

Core registers:
R0           0x0000003F
R1           0x00000010
R2           0x00000000
R3           0x00000000
R4           0x00000001
R5           0xBEC00000
R6           0x00000000
R7           0x00000000
R8           0xBF004400
R9           0x805F1F90
R10          0x00000001
R11          0x805EEB08
R12          0xBEC00001
SP           0x805F1EFC
LR           0x00000000
PC           0x8021F820
CPSR         0x80000193

CPU#1
=====
#0 __radix_tree_lookup( root = <Value currently has no location>, index 
= 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at 
radix-tree.c:517
     node = (struct radix_tree_node*) 0xBEC00001
     parent = <Value optimised away by compiler>
     height = 1
     shift = 0
     slot = <Value currently has no location>
#1 __irq_get_desc_lock( irq = <Value currently has no location>, flags = 
(long unsigned int*) 0xBF08BF94, bus = false, check = 3 ) at irqdesc.c:544
     desc = <Value optimised away by compiler>
#2 enable_percpu_irq( irq = 16, type = 0 ) at manage.c:1583
     cpu = 1
     flags = <Value currently has no location>
     desc = <Value optimised away by compiler>
#3 twd_timer_cpu_notify( self = <Value not available : Undefined value 
in stack frame for register R0>, action = <Value currently has no 
location>, hcpu = <Value not available : Undefined value in stack frame 
for register R2> ) at smp_twd.c:322
#4 notifier_call_chain( nl = <Value currently has no location>, val = 
<Value not available : Undefined value in stack frame for register R1>, 
v = <Value not available : Undefined value in stack frame for register 
R2>, nr_to_call = <Value not available : Undefined value in stack frame 
for register R3>, nr_calls = (int*) 0x0 ) at notifier.c:95
     ret = <Value currently has no location>
     nb = <Value optimised away by compiler>
     next_nb = <Value optimised away by compiler>
#5 notifier_to_errno( ret = <Value currently has no location> ) at 
notifier.h:179
#6 cpu_notify( val = <Value currently has no location>, v = <Value 
currently has no location> ) at cpu.c:234
#7 secondary_start_kernel() at smp.c:367
     mm = <Value optimised away by compiler>
     cpu = 1
#8 [S:0x60008724]

Disassembly:

S:0x8021F80C : LSL      lr,r4,#3
S:0x8021F810 : SUB      lr,lr,r4,LSL #1
S:0x8021F814 : SUB      lr,lr,#6
S:0x8021F818 : B        {pc}+8 ; 0x8021f820
S:0x8021F81C : MOV      r5,r0
S:0x8021F820 : LSR      r12,r1,lr
S:0x8021F824 : SUB      lr,lr,#6
S:0x8021F828 : AND      r12,r12,#0x3f
S:0x8021F82C : ADD      r12,r12,#6
S:0x8021F830 : LDR      r0,[r5,r12,LSL #2]

Core registers:
R0           0x0000003F
R1           0x00000010
R2           0x00000000
R3           0x00000000
R4           0x00000001
R5           0xBEC00000
R6           0xBF08BF94
R7           0x00000000
R8           0x805F92A0
R9           0x00000000
R10          0x00000000
R11          0x00000000
R12          0xBEC00001
SP           0xBF08BF6C
LR           0x00000000
PC           0x8021F820
CPSR         0x800001D3   Nzcvq_ge3ge2ge1ge0_inactive_eAIFtj_SVC

[...]

> I'm beginning to believe at this point that there /is/ a bug in the L2C on
> the test chip, and that we're probably better off changing the Versatile
> Express DT files to disable the L2C cache controller... what are your
> thoughts on that?
>

I was thinking of taking the dump of L2C register settings and comparing
them. But currently I am facing issues booting even v3.18 on my setup,
it seem to fails somewhere else which I need to look at.

> I'm currently doing up to 8 boot tests - if I can do 8 consecutive boot
> tests which all succeed, I'm declaring it a pass, otherwise it's a fail.
> Generally, I've found that it will fail very early (like the first) but
> sometimes up to the 4th.
>
> I guess one thing we need to confirm is whether we have exactly the same
> hardware and firmware versions.  Here's my board's early boot messages:
>

ARM V2M Boot loader v1.1.2
HBI0190 build 2313

ARM V2M Firmware v3.1.2
Build Date: Apr 16 2013

Date: Mon 16 Mar 2015
Time:     18:57:21

Powering up system...
Daughterboard fitted to site 1.

Switching on ATXPSU...
ATX3V3: ON
VIOset: 1.8V
MBtemp: 26 degC

Configuring motherboard (rev D, var A)...
IOFPGA  config: PASSED
MUXFPGA config: PASSED
OSC CLK config: PASSED

Testing SMC devices (FPGA build 8)...
SRAM 32MB test: PASSED
VRAM  8MB test: PASSED
LAN9118   test: PASSED
USB & OTG test: PASSED
KMI1/KMI2 test: PASSED
MMC & SD  test: PASSED
DVI image test: PASSED
AACI AC97 test: PASSED
CF card   test: PASSED
UART port test: PASSED
MAC addrs test: PASSED

Reading Site 1 Board File \SITE1\HBI0191B\board.txt
DB1 JTAG configuration complete.
Setting DB1 OSCCLKS...
DB1.0 DCC 0 SPI configuration complete.

Writing SCC 0x40610000 with 0xBB8A802A
Writing SCC 0x40610001 with 0x00001F09
Writing SCC 0x40610002 with 0x00000000
DB1.0 DCC 0 SCC configuration complete.

DB SMB clock enabled.
Waiting for SITE1 CB_READY...
Testing SMB clock...
Configuring MUXFPGA for MB.
Setting DVI mode for VGA.
Releasing Daughterboard resets.
Switching MCC log to UART1.
%BootMonitor-Warning, Unable to open SYSTEM.DAT


ARM Versatile Express Boot Monitor
Version:    V5.2.1
Build Date: Apr  4 2013
Daughterboard Site 1: V2P-CA9 Cortex A9
Daughterboard Site 2: Not Used
Running boot script from flash - BOOTSCRIPT
