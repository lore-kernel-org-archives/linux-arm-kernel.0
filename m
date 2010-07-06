From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 06 Jul 2010 17:16:16 +0100
Subject: cortex-m3 on linux-2.6.33
In-Reply-To: <AANLkTikEZcUjmAx7CpMXubH-pj5dSFiOBkw2Uvu7u2o3@mail.gmail.com>
References: <AANLkTikEZcUjmAx7CpMXubH-pj5dSFiOBkw2Uvu7u2o3@mail.gmail.com>
Message-ID: <1278432976.5108.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 16:40 +0100, RK Raggit wrote:
> I rebased the baseport of my cortex-m3 board on your latest
> linux-2.6-stable git (2.6.33 kernel).
> My first observation after booting is that the system appears more
> stable now. My earlier baseport
> based on 2.6.28 kernel was largely unstable with simple commands
> crashing the kernel easily.
> My first question -
> 
> Q1/ could you please summarise significant changes that you made in
> the cortex-m3 architecture
> port in the 2.6.33 kernel

The only changes I have made were for solving conflicts with the new
kernel version. A major difference is that the Thumb-2 support (required
for Cortex-M3) is already in mainline 2.6.33 and it may have got various
fixes.

The new feature in the M-profile support is floating point (Cortex-M4).

> Now to an issue i am facing with the latest kernel. When i run command
> like "ls -l" or
> cat /proc/meminfo in an infinite loop on the shell, after running for
> about a minute or so they crash
> with a dump like below -
> 
> -------------------------------8<8<---------------------------
> (ls -l dump)
> Unhandled exception: IPSR = 00000003 LR = fffffff1
> CPU: 0    Not tainted  (2.6.33-arm1 #6)
> PC is at copy_namespaces+0xe/0x8c
> LR is at copy_process+0x565/0x904
> pc : [<800531d6>]    lr : [<80044fd9>]    psr: 2100000b
> sp : 83c20238  ip : 83c42848  fp : 83cf0ac0
> r10: 83c44a10  r9 : 00000000  r8 : 00000000
> r7 : 83c20248  r6 : 00004111  r5 : 00000010  r4 : 460ad0f9
> r3 : 83c77000  r2 : 00000000  r1 : 00000010  r0 : 00004111

IPSR=3 looks like a HardFault. This usually shows unrecoverable system
failures though the docs aren't very clear on what could trigger this
(or I haven't read them in detail).

I can't tell more without further details. What code is around the pc
address? You can also do an "addr2line -e vmlinux -i 800531d6".

-- 
Catalin
