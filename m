From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jan 2010 16:03:13 +0000
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
Message-ID: <20100103160313.GA21156@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 03, 2010 at 11:05:05PM +0800, Hui Zhu wrote:
> Hello,
> 
> For, when the kernel die, the user will get some message like:
> PC is at kernel_init+0xd4/0x104
> LR is at _atomic_dec_and_lock+0x48/0x6c
> pc : [<c0008470>]    lr : [<c01911f8>]    psr: 60000013
> sp : c7823fd8  ip : c7823f48  fp : c7823ff4
> Stack: (0xc7823fd8 to 0xc7824000)
> 3fc0:                                                       00000000 00000001
> Backtrace:
> [<c000839c>] (kernel_init+0x0/0x104) from [<c0042660>] (do_exit+0x0/0x880)
> This backtrace have some wrong message sometime and cannot get any
> val. Of course, kdump can get more message.  But it need do some a lot
> of other config.

If you have frame pointers enabled, the backtrace is _never_ wrong.
It only goes wrong if you disable frame pointers, at which point the
unwind tables have to be used.

> When kernel die, show some message:
> S2C:elf_class=1
> S2C:elf_data=1
> S2C:elf_arch=40
> S2C:elf_osabi=0
> S2C:r0=0x00000000;
> S2C:r1=0xc7822000;
> S2C:r2=0xc7823f48;
> S2C:r3=0x00000003;
> S2C:r4=0x00000000;
> S2C:r5=0x00000000;
> S2C:r6=0x00000000;
> S2C:r7=0x00000000;
> S2C:r8=0x00000000;
> S2C:r9=0x00000000;
> S2C:r10=0x00000000;
> S2C:fp=0xc7823ff4;
> S2C:ip=0xc7823f48;
> S2C:sp=0xc7823fd8;
> S2C:lr=0xc01911f8;
> S2C:pc=0xc0008470;
> S2C:cpsr=0x60000013;
> S2C:ORIG_r0=0xffffffff;
> 
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0xf8, 0x3f, 0x82, 0xc7,
> S2C:stack=0x60, 0x26, 0x04, 0xc0, 0xa8, 0x83, 0x00, 0xc0,
> S2C:stack=0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

Please don't invent yet another way of dumping stuff out of the kernel.
What we already have is sufficient for your needs - there's no reason
what so ever to change it to achieve your goals.  We already dump the
registers and the stack, which seems to be all that you require.
