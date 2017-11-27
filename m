From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 09:44:36 +0000
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
 <CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
Message-ID: <20171127094436.GB31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 12:05:19PM +1030, Joel Stanley wrote:
> Hello Russell,
> 
> On Sat, Nov 25, 2017 at 10:03 PM, Russell King
> <rmk+kernel@armlinux.org.uk> wrote:
> > Detect if we are returning to usermode via the normal kernel exit paths
> > but the saved PSR value indicates that we are in kernel mode.  This
> > could occur due to corrupted stack state, which has been observed with
> > "ftracetest".
> >
> > This ensures that we catch the problem case before we get to user code.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> 
> This patch breaks my 32 bit ARM system when running under Qemu. I get
> this continually:
> 
> [    2.130043] ------------[ cut here ]------------
> [    2.130132] kernel BUG at Returning to usermode but unexpected PSR
> bits set?:9!
> [    2.130233] Internal error: Oops - BUG: 0 [#1] ARM
> [    2.130375] Modules linked in:
> [    2.130805] CPU: 0 PID: 154 Comm: modprobe Not tainted 4.15.0-rc1 #3
> [    2.130874] Hardware name: Generic DT based system
> [    2.131023] task: 87a02800 task.stack: 87970000
> [    2.131158] PC is at no_work_pending+0x2c/0x30
> [    2.131402] LR is at 0x76f18ae8
> [    2.131462] pc : [<8000a600>]    lr : [<76f18ae8>]    psr: 200001d3
> [    2.131516] sp : 87971fb0  ip : 80014484  fp : 00000000
> [    2.131567] r10: 00000000  r9 : 87970000  r8 : 00000000
> [    2.131627] r7 : 00c5387d  r6 : ffffffff  r5 : 00000150  r4 : 76f18ae8
> [    2.131686] r3 : 00000000  r2 : 87971fec  r1 : 00000150  r0 : 00000000
> [    2.131818] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
> Segment user
> [    2.131894] Control: 00c5387d  Table: 8794c008  DAC: 00000055
> [    2.131971] Process modprobe (pid: 154, stack limit = 0x87970188)
> [    2.132075] Stack: (0x87971fb0 to 0x87972000)
> [    2.132273] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [    2.132344] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    2.132395] 1fe0: 00000000 7ec5fec0 00000000 76f18ae8 00000150
> ffffffff e3a00001 e58d300c
> [    2.133146] Code: e9527fff e1a00000 e28dd048 e1b0f00e (e7f001f2)
> [    2.133593] ---[ end trace 46087be8f22855bc ]---

It looks like FIQs are disabled when returning to userspace.  Also it
looks like imprecise aborts were disabled too, which isn't good for
running userspace.

As we explicitly set the userspace CPSR value when we exec a program,
these bits should not be set.  The mostly-zeros dump of the registers
in the stack with the exception of old_r0 being ~0 suggests that we
were are handling an exception very close to the start of execution of
modprobe - maybe a prefetch abort to fault the first page of executable
code in.

This has the feeling of being a qemu bug.

We could reduce the mask being tested in the patch to exclude the FIQ
bit.  However, I'd like to see it investigated further - but qemu and
myself do not get along - my only success with it was running some
MIPS code.  I've never had it do anything useful with ARM stuff.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
