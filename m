From: moazkorena@gmail.com (moaz korena)
Date: Thu, 9 Jun 2016 17:08:26 +0800
Subject: FDT compatible list parsing problem (Kernel cant parse, always
 returns null)
Message-ID: <CA+fqkcEFiFJaks0-B+NUnsK7yLgvOBtEqUm6uvVkMcU0a=AxQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I'm working on adding device tree support for an S5PV210 Samsung SoC based
board, so I added the dts file, and configured some default values, I
could share
all that, but I'm hoping someone went through a similar thing and can point out
an obvious (usual) mistake.

What I've done so far:
- Added early print statements, verified the dtb in memory is identical to the
compiled dtb, in size and content.
- Verified that the call to early_init_dt_verify within
setup_machine_fdt function
 (in arch/arm/kernel/devtree.c) returns true (successful verification).
- Traced the problem all the way to the doorsteps of the following routine
 fdt_getprop in scripts/dtc/libfdt/fdt_ro.c

int of_fdt_is_compatible(const void *blob,
                      unsigned long node, const char *compat)
{
        const char *cp;
        int cplen;
        unsigned long l, score = 0;

        cp = fdt_getprop(blob, node, "compatible", &cplen);
        if (cp == NULL)
                return 0;
        while (cplen > 0) {
                score++;
                if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
                        return score;
                l = strlen(cp) + 1;
                cp += l;
                cplen -= l;
        }

        return 0;
}



cp in the above snippet is always null, blob holds the correct
(virtual) address of the dtb,
the same address used for successful verification of magic, size and
version of the fdt,
which is the problem I'm facing, this causes a panic very soon after,
I've dumped the
logs below, note that there are many early_print statements , so
there's more information
than the kernel usually gives..

Here's the dts contents:


/dts-v1/;
#include <dt-bindings/input/input.h>
#include "s5pv210.dtsi"

/ {
model = "FriendlyARM Tiny210v1204 based on S5PV210";
compatible = "friendlyarm,tiny210v1204", "samsung,s5pv210";

chosen {
bootargs = "root=/dev/ram0 rw ramdisk=8192 ignore_loglevel earlyprintk
console=ttyS0,115200n8 init=/linuxrc";
};

memory {
device_type = "memory";
reg = <0x20000000 0x20000000>;
};
};

&xxti {
clock-frequency = <24000000>;
};
&xusbxti {
clock-frequency = <24000000>;
};

&uart0 {
status = "okay";
};

&uart1 {
status = "okay";
};

&uart2 {
status = "okay";
};

&uart3 {
status = "okay";
};

&rtc {
status = "okay";
};


Here's the kernel panic :

Uncompressing Linux... done, booting the kernel.

dumping memory description variables ...

PHYS_OFFSET(20000000) ...

PAGE_OFFSET(80000000) ...

__atags_pointer = 20000100



fdt_check_header passed for DTF at 80000100

flat device tree:

magic: d00dfeed

size: 00005c21

version: 00000011

size of passed DT = 23585

initial_boot_params = 80000100

initial_boot_params = 80000100

[    0.000000] Booting Linux on physical CPU 0x0


[    0.000000] Linux version 4.7.0-rc1-00107-g31a346f-dirty
(korena at korena-solid) (gcc version 5.1.1 20150608 (Linaro GCC
5.1-2015.08) )
#18 PREEMPT Thu Jun 9 17:03:13 MYT 2016


[    0.000000] CPU: ARMv7 Processor [412fc082] revision 2 (ARMv7), cr=10c5387d


[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache


[    0.000000] dumping memory description variables ...


[    0.000000] PHYS_OFFSET(20000000) ...


[    0.000000] PAGE_OFFSET(80000000) ...


[    0.000000] __atags_pointer = 20000100


[    0.000000]


[    0.000000] fdt_check_header passed for DTF at 80000100


[    0.000000] flat device tree:


[    0.000000] magic: d00dfeed


[    0.000000] size: 00005c21


[    0.000000] version: 00000011


[    0.000000] size of passed DT = 23585


[    0.000000] initial_boot_params = 80000100


[    0.000000] initial_boot_params = 80000100


[    0.000000] Machine model: (null)


[    0.000000] debug: ignoring loglevel setting.


[    0.000000] bootconsole [earlycon0] enabled


[    0.000000] Memory policy: Data cache writeback


[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate
0x2000 bytes below 0x0.


[    0.000000]


[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.7.0-rc1-00107-g31a346f-dirty #18


[    0.000000] Hardware name: Generic DT based system


[    0.000000] [<8010c4b4>] (unwind_backtrace) from [<8010aa34>]
(show_stack+0x10/0x14)


[    0.000000] [<8010aa34>] (show_stack) from [<8016bb18>] (panic+0xc8/0x23c)


[    0.000000] [<8016bb18>] (panic) from [<8050d688>]
(memblock_alloc_base+0x34/0x3c)


[    0.000000] [<8050d688>] (memblock_alloc_base) from [<80505a54>]
(early_alloc_aligned+0xc/0x2c)


[    0.000000] [<80505a54>] (early_alloc_aligned) from [<805066f4>]
(paging_init+0x774/0x9cc)


[    0.000000] [<805066f4>] (paging_init) from [<80504130>]
(setup_arch+0x61c/0x84c)


[    0.000000] [<80504130>] (setup_arch) from [<805009c8>]
(start_kernel+0x5c/0x380)


[    0.000000] [<805009c8>] (start_kernel) from [<20008078>] (0x20008078)


[    0.000000] ---[ end Kernel panic - not syncing: ERROR: Failed to
allocate 0x2000 bytes below 0x0.



So where did I go wrong?

Thanks

Korena

----------------------------------------------------------------------------------------------------------

Software Consultant
Siphyc
