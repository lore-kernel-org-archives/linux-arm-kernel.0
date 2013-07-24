From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 24 Jul 2013 15:58:43 +0100
Subject: Requirements for FDT load address on ARM
Message-ID: <1374677923.6623.194.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[apologies if this is a repeat, I don't see it in the archives and at
least one CC'd recipient (Julien) didn't receive it either. Beasties in
our email server I expect...]

Are there any requirements about where the FDT may be loaded by the
bootloader?

I'm finding that if I load it "too high" I get a fault (the specifics
aren't that relevant but details are below). FWIW with RAM from
0x8000000-0xffffffff and a kernel loaded at 0x80008000 "too high" means
above somewhere around 0xaf800000.

I expect this is because the kernel doesn't use an explicit mapping of
the fdt but expects it to be within the RAM directly mapped by the
lowmem area (i.e. it uses phys_to_virt, since day one aka 93c02ab40ae6
"arm/dt: probe for platforms via the device tree"). This effectively
limits the FDT to being within the first ~700MB (give or take based
on .config etc, I suppose <500MB is a pretty safe rule of thumb). Is
this expected or is it actually not intentional and the kernel should
really be using an explicit mapping here? Should I send a patch against
Documentation/arm/Booting?

Ian.

        Unable to handle kernel paging request at virtual address ffe00000
        pgd = c0004000
        [ffe00000] *pgd=af7fe821, *pte=00000000, *ppte=00000000
        Internal error: Oops: 17 [#1] ARM
        CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc1-arm-native+ #136
        task: c045e500 ti: c0454000 task.ti: c0454000
        PC is at __unflatten_device_tree+0x18/0x11c
        LR is@unflatten_device_tree+0x1c/0x34
        pc : [<c027fb38>]    lr : [<c0445bec>]    psr: a00001d3
        sp : c0455f70  ip : 80454000  fp : 00000000
        r10: c0ca10c0  r9 : 410fd0f0  r8 : c045f380
        r7 : c0434340  r6 : c045f380  r5 : ffe00000  r4 : c0434340
        r3 : d00dfeed  r2 : c0434340  r1 : c0497608  r0 : ffe00000
        Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
        Control: 10c5383d  Table: 80004059  DAC: 00000015
        Process swapper (pid: 0, stack limit = 0xc0454230)
        Stack: (0xc0455f70 to 0xc0456000)
        5f60:                                     ffe00000 c0497608 c0434340 c0497608
        5f80: c0434340 c044cb90 c045f380 c04649b0 c045f380 c0445bec c044b958 c0433970
        5fa0: 00000000 10c53c7d c046184c 00000001 ffffffff c044cba0 c045f4a0 80004059
        5fc0: 00000000 c04304f8 00000000 00000000 00000000 00000000 00000000 c044cba4
        5fe0: 00000000 10c53c7d c045c024 c044cba0 c045f4a0 80008070 00000000 00000000
        [<c027fb38>] (__unflatten_device_tree+0x18/0x11c) from [<c0445bec>] (unflatten_device_tree+0x1c/0x34)
        [<c0445bec>] (unflatten_device_tree+0x1c/0x34) from [<c0433970>] (setup_arch+0x5ac/0x72c)
        [<c0433970>] (setup_arch+0x5ac/0x72c) from [<c04304f8>] (start_kernel+0x68/0x2d8)
        [<c04304f8>] (start_kernel+0x68/0x2d8) from [<80008070>] (0x80008070)
        Code: e1a07002 e58d100c 0a00003a e59f30e8 (e5952000) 
        ---[ end trace 1b75b31a2719ed1c ]---
        Kernel panic - not syncing: Attempted to kill the idle task!
        
