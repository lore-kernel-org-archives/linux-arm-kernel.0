From: a.aubert@overkiz.com (Antoine Aubert)
Date: Mon, 14 Sep 2015 14:41:32 +0200
Subject: at91sam9 Main crystal frequency problems
In-Reply-To: <20150908181212.0b4336f0@bbrezillon>
References: <55ED3D3B.8060700@overkiz.com> <20150908181212.0b4336f0@bbrezillon>
Message-ID: <55F6C07C.8080803@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thank you for your help. I have some news thanks to traces in clk driver.


Le 08/09/2015 18:12, Boris Brezillon a ?crit :
> Hi Antoine,
> 
> On Mon, 7 Sep 2015 09:31:07 +0200
> Antoine Aubert <a.aubert@overkiz.com> wrote:
> 
>> Hi,
>>
>> I currently bring up a board based on AT91SAM9G25cu, and I having
>> problems of watchdogs resets.
>>
>> We use linux-4.04 mainline, and i found some weird warnings on kernel
>> traces, concerning main clk.
>>
>> [    0.000000] Main crystal frequency not set, using approximate value
>> [    0.000000] master clk is overclocked
>> [    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
>> wraps every 16777216000000000ns
>> [    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
>>
>> I set crystal clock in the DT, but it doesn't seems to work.. I feel
>> that the board works out of the specified range.
> 
> According to your clk_summary dump that's not the case.
> 
>>
>> So here comes my questions:
>> Can there be a relationship with watchdog problems ? (1 per day)
> 
> I'd say no, but could you tell me more about your watchdog issues.

Yet, we did not take the analysis. We just observed these resets.

But, I found a clue:
We recently removed the slow clock to the PCB. I forgot to disabled the
slow_xtal. :/
 Can there be a link ? (I think so...)

> 
>> Why is it that the frequency of Crystal is not found ?
> 
> That's a good question, and honestly I don't. Everything seems to be
> defined properly in your device tree.
> 
> Could you add some traces in the fixed-rate clk driver [1] to see if the
> main_xtal is correctly registered and if its registration occurs before
> the main_osc registration?

On our board, there is two kernel boot phases.

First, we boot from at91-bootstrap.
Second we launched kexec with an other kernel.

I found that the device tree is well loaded from the at91-bootstrap. Any
crystal issues. But, on kexec --exec, (with the same kernel) those
issues appears. (see dmesg attached)

If I launch kexec with --dtb, it's working ...
I thought kexec keep old dtb. Was I wrong ?

> 
> Best Regards,
> 
> Boris
> 
> [1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/clk/clk-fixed-rate.c?id=refs/tags/v4.0.4#n115
> 

Best regards,
Antoine Aubert
a.aubert at overkiz.com
-------------- next part --------------
[  187.421875] kexec: Starting new kernel
[  187.421875] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.4 (antoine at compile-embedded) (gcc version 4.9.1 (GCC) ) #1 Fri Sep 11 14:36:53 CEST 2015
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: Overkiz Kizbox mini
[    0.000000] Memory policy: Data cache writeback
[    0.000000] AT91: Detected soc type: at91sam9x5
[    0.000000] AT91: Detected soc subtype: at91sam9g25
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line:  root=ubi0:root 
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 125620K/131072K available (2698K kernel code, 133K rwdata, 988K rodata, 128K init, 194K bss, 5452K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03a1f5c   (3688 kB)
[    0.000000]       .init : 0xc03a2000 - 0xc03c2000   ( 128 kB)
[    0.000000]       .data : 0xc03c2000 - 0xc03e37c0   ( 134 kB)
[    0.000000]        .bss : 0xc03e37c0 - 0xc0414394   ( 195 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Main crystal frequency not set, using approximate value
[    0.000000] parent_rate: 0
[    0.000000] pmc: c7802400
[    0.000000] rate: 0
[    0.000000] min:  0
[    0.000000] max:  133333333
[    0.000000] rate: 148866833
[    0.000000] min:  0
[    0.000000] max:  133333333
[    0.000000] master clk is overclocked
[    0.000000] of_fixed_clk_setup
[    0.000000] clock freq: 5000000
[    0.000000] clock accuracy: 0
[    0.000000] clock name: adc_op_clk
[    0.000000] error !
[    0.000000] Done
[    0.000000] of_fixed_clk_setup
[    0.000000] clock freq: 12000000
[    0.000000] clock accuracy: 0
[    0.000000] clock name: main_xtal
[    0.000000] rate: 133333333
[    0.000000] min:  0
[    0.000000] max:  133333333
[    0.000000] error !
[    0.000000] Done
[    0.000000] of_fixed_clk_setup
[    0.000000] clock freq: 32768
[    0.000000] clock accuracy: 0
[    0.000000] clock name: slow_xtal
[    0.000000] error !
[    0.000000] Done
[    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
[    0.054687] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
[    0.054687] pid_max: default: 32768 minimum: 301
[    0.062500] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.062500] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.062500] CPU: Testing write buffer coherency: ok
[    0.062500] Setting up static identity map for 0x20290ed8 - 0x20290f54
[    0.070312] devtmpfs: initialized
[    0.070312] pinctrl core: initialized pinctrl subsystem
[    0.093750] NET: Registered protocol family 16
[    0.093750] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.117187] AT91: Power Management
[    0.117187] gpio-at91 fffff400.gpio: at address fefff400
[    0.117187] gpio-at91 fffff600.gpio: at address fefff600
[    0.117187] gpio-at91 fffff800.gpio: at address fefff800
[    0.117187] gpio-at91 fffffa00.gpio: at address fefffa00
[    0.125000] pinctrl-at91 ahb:apb:pinctrl at fffff400: initialized AT91 pinctrl driver
[    0.164062] at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.164062] at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.171875] usbcore: registered new interface driver usbfs
[    0.171875] usbcore: registered new interface driver hub
[    0.171875] usbcore: registered new device driver usb
[    0.171875] Switched to clocksource tcb_clksrc
[    0.187500] NET: Registered protocol family 2
[    0.195312] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.195312] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.195312] TCP: Hash tables configured (established 1024 bind 1024)
[    0.195312] TCP: reno registered
[    0.195312] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.195312] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.195312] NET: Registered protocol family 1
[    0.195312] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.203125] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.203125] io scheduler noop registered (default)
[    0.210937] f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 30, base_baud = 8333333) is a ATMEL_SERIAL
[    0.210937] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 16, base_baud = 8333333) is a ATMEL_SERIAL
[    0.562500] console [ttyS0] enabled
[    0.578125] brd: module loaded
[    0.601562] loop: module loaded
[    0.617187] atmel_nand 40000000.nand: Use On Flash BBT
[    0.625000] atmel_nand 40000000.nand: Using dma0chan0 for DMA transfers.
[    0.632812] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.632812] nand: AMD/Spansion S34ML01G2
[    0.640625] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.648437] atmel_nand 40000000.nand: minimum ECC: 4 bits in 512 bytes
[    0.648437] atmel_nand 40000000.nand: Initialize PMECC params, cap: 4, sector: 512
[    0.656250] Bad block table found at page 65472, version 0x01
[    0.664062] Bad block table found at page 65408, version 0x01
[    0.671875] 2 ofpart partitions found on MTD device atmel_nand
[    0.679687] Creating 2 MTD partitions on "atmel_nand":
[    0.679687] 0x000000000000-0x000000020000 : "bootstrap"
[    0.687500] 0x000000020000-0x000080000000 : "ubi"
[    0.695312] mtd: partition "ubi" extends beyond the end of device "atmel_nand" -- size truncated to 0x7fe0000
[    0.710937] libphy: MACB_mii_bus: probed
[    0.804687] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 26 (f8:81:1a:02:4a:3b)
[    0.812500] macb f802c000.ethernet eth0: attached PHY driver [Micrel KSZ8081 or KSZ8091] (mii_bus:phy_addr=f802c000.etherne:01, irq=-1)
[    0.820312] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.828125] ehci-atmel: EHCI Atmel driver
[    0.828125] atmel-ehci 700000.ehci: EHCI Host Controller
[    0.835937] atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
[    0.843750] atmel-ehci 700000.ehci: irq 32, io mem 0x00700000
[    0.867187] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    0.867187] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.875000] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.882812] usb usb1: Product: EHCI Host Controller
[    0.882812] usb usb1: Manufacturer: Linux 4.0.4 ehci_hcd
[    0.890625] usb usb1: SerialNumber: 700000.ehci
[    0.898437] hub 1-0:1.0: USB hub found
[    0.898437] hub 1-0:1.0: 3 ports detected
[    0.906250] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.914062] ohci-atmel: OHCI Atmel driver
[    0.914062] AT91: Starting after general reset
[    0.921875] at91sam9_wdt: enabled (heartbeat=15 sec, nowayout=1)
[    0.929687] hidraw: raw HID events driver (C) Jiri Kosina
[    0.937500] usbcore: registered new interface driver usbhid
[    0.945312] usbhid: USB HID core driver
[    0.945312] TCP: cubic registered
[    0.953125] NET: Registered protocol family 17
[    0.960937] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    0.976562] VFS: Cannot open root device "ubi0:root" or unknown-block(0,0): error -2
[    0.984375] Please append a correct "root=" boot option; here are the available partitions:
[    0.992187] 0100            8192 ram0  (driver?)
[    0.992187] 0101            8192 ram1  (driver?)
[    1.000000] 0102            8192 ram2  (driver?)
[    1.007812] 0103            8192 ram3  (driver?)
[    1.007812] 1f00             128 mtdblock0  (driver?)
[    1.015625] 1f01          130944 mtdblock1  (driver?)
[    1.015625] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    1.015625] CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.4 #1
[    1.015625] Hardware name: Atmel AT91SAM9
[    1.015625] [<c000ded0>] (unwind_backtrace) from [<c000bd00>] (show_stack+0x10/0x14)
[    1.015625] [<c000bd00>] (show_stack) from [<c028d8dc>] (panic+0x74/0x1dc)
[    1.015625] [<c028d8dc>] (panic) from [<c03a310c>] (mount_block_root+0x26c/0x2b0)
[    1.015625] [<c03a310c>] (mount_block_root) from [<c03a3338>] (prepare_namespace+0x88/0x1ac)
[    1.015625] [<c03a3338>] (prepare_namespace) from [<c03a2d54>] (kernel_init_freeable+0x168/0x1ac)
[    1.015625] [<c03a2d54>] (kernel_init_freeable) from [<c028ca90>] (kernel_init+0x8/0xe0)
[    1.015625] [<c028ca90>] (kernel_init) from [<c0009658>] (ret_from_fork+0x14/0x3c)
[    1.015625] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   64.492187] random: nonblocking pool is initialized
-------------- next part --------------
static unsigned long clk_main_recalc_rate(struct at91_pmc *pmc,
                                          unsigned long parent_rate)
{
        u32 tmp;

        if (parent_rate)
                return parent_rate;

        pr_warn("Main crystal frequency not set, using approximate value\n");
pr_err("parent_rate: %lu\n", parent_rate);
pr_err("pmc: %p\n", pmc);

        tmp = pmc_read(pmc, AT91_CKGR_MCFR);
        if (!(tmp & AT91_PMC_MAINRDY))
                return 0;

        return ((tmp & AT91_PMC_MAINF) * SLOW_CLOCK_FREQ) / MAINF_DIV;
}

-------------- next part --------------
static unsigned long clk_master_recalc_rate(struct clk_hw *hw,
                                            unsigned long parent_rate)
{
        u8 pres;
        u8 div;
        unsigned long rate = parent_rate;
        struct clk_master *master = to_clk_master(hw);
        struct at91_pmc *pmc = master->pmc;
        const struct clk_master_layout *layout = master->layout;
        const struct clk_master_characteristics *characteristics =
                                                master->characteristics;
        u32 tmp;

        pmc_lock(pmc);
        tmp = pmc_read(pmc, AT91_PMC_MCKR) & layout->mask;
        pmc_unlock(pmc);

        pres = (tmp >> layout->pres_shift) & MASTER_PRES_MASK;
        div = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;

        if (characteristics->have_div3_pres && pres == MASTER_PRES_MAX)
                rate /= 3;
        else
                rate >>= pres;

        rate /= characteristics->divisors[div];

pr_err("rate: %lu\n", rate);
pr_err("min:  %lu\n", characteristics->output.min);
pr_err("max:  %lu\n", characteristics->output.max);

        if (rate < characteristics->output.min)
                pr_warn("master clk is underclocked");
        else if (rate > characteristics->output.max)
                pr_warn("master clk is overclocked");

        return rate;
}
-------------- next part --------------
void of_fixed_clk_setup(struct device_node *node)
{
        struct clk *clk;
        const char *clk_name = node->name;
        u32 rate;
        u32 accuracy = 0;

pr_err("of_fixed_clk_setup\n");

        if (of_property_read_u32(node, "clock-frequency", &rate))
                return;
pr_err("clock freq: %u\n", rate);

        of_property_read_u32(node, "clock-accuracy", &accuracy);

pr_err("clock accuracy: %u\n", accuracy);

        of_property_read_string(node, "clock-output-names", &clk_name);

pr_err("clock name: %s\n", clk_name);

        clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
                                                    CLK_IS_ROOT, rate,
                                                    accuracy);
        if (!IS_ERR(clk)){
pr_err("error !\n");
                of_clk_add_provider(node, of_clk_src_simple_get, clk);
}

pr_err("Done\n");
}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/5ab722db/attachment-0001.sig>
