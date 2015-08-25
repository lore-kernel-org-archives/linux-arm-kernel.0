From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 11:44:22 +0100
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
 <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
Message-ID: <20150825104422.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 12:32:51PM +0200, Geert Uytterhoeven wrote:
> This patch, which is now in arm-soc/for-next, breaks shmobile_defconfig
> on r8a7791/koelsch, which has a dual core CA15:
> 
>     [ ok ] Configuring network interfaces...done.
>     Unhandled fault: page domain fault (0x01b) at 0xbe8e6120
>     pgd = edbb0000
>     [be8e6120] *pgd=6da77831, *pte=bf4d075f, *ppte=bf4d0c7f
>     Internal error: : 1b [#1] SMP ARM
>     CPU: 1 PID: 1629 Comm: ntpdate Not tainted
> 4.2.0-rc8-06444-g3c24fd89c9421db1 #31
>     9
>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>     task: ed883a80 ti: ed41c000 task.ti: ed41c000
>     PC is at csum_partial_copy_from_user+0x28/0x3d8
>     LR is at csum_and_copy_from_iter+0x334/0x4c0
>     pc : [<c04ba510>]    lr : [<c01c82e8>]    psr: 000f0013
>     sp : ed41db00  ip : 00000020  fp : ed41db6c
>     r10: ed41ddc0  r9 : 00000027  r8 : ed41dc20
>     r7 : 00000027  r6 : eda52653  r5 : ed41dec8  r4 : 00000000
>     r3 : 00000000  r2 : 00000027  r1 : eda5262c  r0 : be8e6120
>     Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>     Control: 10c5307d  Table: 6dbb006a  DAC: 00000051
>     Process ntpdate (pid: 1629, stack limit = 0xed41c210)

Thanks.  I wonder what's different about your ntpdate that triggers
this, and why all my iMX6 behave fine, which have desktop-like ubuntu
installs on (of two different versions.)

What it's basically showing is that (unsurprisingly)
csum_partial_copy_from_user is trying to access userspace.  I'll see
about fixing that today, or pulling the patch from -next if I can't.

I've also noticed that on rpc_defconfig, the 0-day builder shows that
this triggers an ICE as the compiler appears to think it's run out of
registers.

> After disabling CONFIG_CPU_SW_DOMAIN_PAN it  fails differently:
> 
>     VFS: Mounted root (nfs filesystem) readonly on device 0:13.
>     devtmpfs: mounted
>     Freeing unused kernel memory: 300K (c0629000 - c0674000)
>     Unhandled fault: page domain fault (0x81b) at 0x000263e0
>     pgd = ed908000
>     [000263e0] *pgd=6e299831, *pte=bf81d75f, *ppte=bf81dc7f

Yes, this one is because I forgot to provide the non-protected default
for bootup, which I've already merged a fix for.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
