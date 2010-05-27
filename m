From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 20:31:18 +0100
Subject: [not solved yet] debugging linux kernel on arm926ejs target
In-Reply-To: <4BFE8D51.2020708@gmail.com>
References: <4BFE8D51.2020708@gmail.com>
Message-ID: <20100527193118.GA25921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 11:18:41AM -0400, f. achkar wrote:
>       DRAM bank   = 0x00000000
>       -> start    = 0x30000000
>       -> size     = 0x04000000
>       DRAM bank   = 0x00000001
>       -> start    = 0x38000000
>       -> size     = 0x04000000

So writable memory is at 0x30000000.

> (gdb) load
> Loading section .init, size 0x7b000 lma 0xc0008000
> Loading section .text, size 0x2bb618 lma 0xc0083000
> Loading section __ksymtab, size 0x4a58 lma 0xc033f000
> Loading section __ksymtab_gpl, size 0x1360 lma 0xc0343a58
> Loading section __ksymtab_gpl_future, size 0x18 lma 0xc0344db8
> Loading section __ksymtab_strings, size 0xcab7 lma 0xc0344dd0
> Loading section __param, size 0x654 lma 0xc0351888
> Loading section .data, size 0x21538 lma 0xc0352000
> Start address 0xc0008000, load size 3582507
> Transfer rate: 35 KB/sec, 15922 bytes/write.

But gdb is loading the kernel at 0xc0008000.

This is quite a normal thing to do, because the vmlinux is linked to
execute from 0xc0008000.  This is the _virtual_ address, which is where
the kernel expects to be running once basic services such as the MMU
are initialized.

This initialization is done by the early part of the kernel, which given
the above SDRAM settings, the kernel will expect to be loaded and executed
at physical 0x30008000, not its link-time virtual address of 0xc0008000.

I don't do any debugging of kernels via gdb, so I couldn't tell you how
to persuade gdb to load the kernel at a different address to that which
it's linked for.  However, relinking the kernel for 0x30008000 is
definitely the wrong answer, and will result in something that also
doesn't work.

I think you need to consult with the openocd folk to discuss how to debug
a Linu kernel with their debugging solution.
