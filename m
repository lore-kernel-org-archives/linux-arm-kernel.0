From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu, 6 Jul 2017 21:14:49 +0200
Subject: Stack overflow in merge_fdt_bootargs()?
Message-ID: <20170706191448.vbb72qev7o4frzld@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arch/arm/boot/compressed/atags_to_fdt.c, we have

static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
{
        char cmdline[COMMAND_LINE_SIZE];
        const char *fdt_bootargs;
        char *ptr = cmdline;
        int len = 0;

which means a stack frame of at least 1030 bytes. This is called very early
on from head.S via atags_to_fdt(). How much stack space is available?

I ask because all kernels after (but not including) v4.0.0 have hung with
no output on my Trimslice, which runs an old boot loader without device tree
support. The kernels for it have CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
enabled to pick up the command line passed in by the boot loader using the
old ATAG mechanism. Between v4.0.0 and v4.1-rc1, head.S was changed by commit
c2607f74aad96d18316a6e709b40e0ffe9def148 so that potentially much less room
is left between the FDT and the stack[1]. The size of the DTB is 21152 bytes,
and prevously, the buffer set aside for manipulating the DTB was 64 kB while
now, it comes out to 32 kB in my case.

I've managed to boot a newer kernel by hacking merge_fdt_bootargs() so the
stack frame stays below 1024 bytes, so a stack overflow seems to be a
possible explanation.

[1] The way head.S is written suggests to me that on entry to head.S, the stack
follows immediately after the appended DTB.

-- 
Rask Ingemann Lambertsen
