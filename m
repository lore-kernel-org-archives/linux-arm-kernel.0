From: embedded@gmx.net (A.Schallenberg)
Date: Mon, 12 Sep 2011 11:54:17 +0200
Subject: OMAP3503, SMC911x: mac address issue
Message-ID: <201109121154.17796.embedded@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am adding support for a custom board to the 3.0 kernel.
The board is very similar to the beagle board, so I took this
as my starting point. I also have an older (v2.6.32) kernel
with its beagle board support modified to support this custom
board instead.

Using the same boot paramaters passed by U-Boot (only the ttyS2
to ttyO2 change was made) the new kernel has issues with eth0.

The kernel driver is added to the board support, compiled and
successfully probed. I verified this by adding some "printk" lines:

...
[    1.939361] SMC911x: init()
[    1.942382] SMC911x: drv_probe()
[    1.945831] SMC911x: probe()
[    1.952484] eth0: LAN9115 (rev 2) at 0x2c000000 IRQ 225
[    1.958099] eth0: Invalid ethernet MAC address ff:ff:ff:ff:ff:ff. Please 
set using ifconfig.
[    1.967071] eth0: External PHY 0xffffffff
[    1.971313] eth0: probe() succeeded
...

Later on, I get:
...
[    2.087951] IP-Config: Failed to open eth0
[    2.093109] IP-Config: Device `eth0' not found.
[    2.098419] Root-NFS: no NFS server address
...


This is ic_open_devs() (from ipconfig.c) calling
dev_change_flags(dev, oflags | IFF_UP). This ultimately
leads to a call to eth_validate_addr() in eth.c
which fails and returns -EADDRNOTAVAIL.
So the MAC address is not correctly passed on to the driver.

The kernel boot parameters are:
[    0.000000] Kernel command line: console=ttyO2,115200n8 
video=omapfb:vram:2M,vram:4M,mode:1024x768 at 60,vxres=1024,vyres=768 
ip=10.100.100.28:10.100.10.69:10.100.0.1:255.255.0.0:3flex:eth0:none 
ethaddr=00:E0:18:1B:21:55 root=/dev/nfs rootfstype=nfs

Here is how I do the initialization in the board file now.
The code is directly taken from the v2.6.32 kernel. 

------------------------------------------------------------

#define OMAP3_BOARD_ETHR_START     0x2c000000
#define OMAP3_BOARD_ETHR_SIZE      1024
#define OMAP3_BOARD_ETHR_GPIO_IRQ  65      // Sos
#define OMAP3_BOARD_SMC911X_CS     5

static struct resource omap3_board_smc911x_resources[] = {
        [0] =   {
                .start  = OMAP3_BOARD_ETHR_START,
                .end    = (OMAP3_BOARD_ETHR_START + OMAP3_BOARD_ETHR_SIZE - 
1),
                .flags  = IORESOURCE_MEM,
        },
        [1] =   {
                .start  = OMAP_GPIO_IRQ(OMAP3_BOARD_ETHR_GPIO_IRQ),
                .end    = OMAP_GPIO_IRQ(OMAP3_BOARD_ETHR_GPIO_IRQ),
                .flags  = IORESOURCE_IRQ,
        },
};

static struct platform_device omap3_board_smc911x_device = {
        .name           = "smc911x",
        .id             = -1,
        .num_resources  = ARRAY_SIZE(omap3_board_smc911x_resources),
        .resource       = &omap3_board_smc911x_resources [0],
};


static inline void __init omap3_board_init_smc911x(void)
{
        int eth_cs;
        struct clk *l3ck;
        unsigned int rate;


        eth_cs = OMAP3_BOARD_SMC911X_CS;


        l3ck = clk_get(NULL, "l3_ck");
        if (IS_ERR(l3ck))
                rate = 100000000;
        else
                rate = clk_get_rate(l3ck);

        if (gpio_request(OMAP3_BOARD_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
                printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
                        OMAP3_BOARD_ETHR_GPIO_IRQ);
                return;
        }

        gpio_direction_input(OMAP3_BOARD_ETHR_GPIO_IRQ);
        platform_device_register(&omap3_board_smc911x_device);
        printk(KERN_INFO "BOARD: Registered SMC911x\n");
}

------------------------------------------------------------------------------

What am I doing wrong here?

I am aware of the thread "Linux Kernel without Ethernet (missed MAC)"
( http://www.mail-archive.com/u-boot@lists.denx.de/msg27711.html )
and also tried the patch by Daniel Gorsulowski but that didn't help.
It should be some different issue here since I am using "ethaddr"
to pass the MAC.


If this is the wrong mailing list for this question,
please point me to a more appropriate one.

Best,
Andreas Schallenberg
