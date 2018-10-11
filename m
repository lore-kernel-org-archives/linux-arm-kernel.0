From: fernando.ae2017@gmail.com (Fernando AE)
Date: Thu, 11 Oct 2018 18:03:45 +0200
Subject: i.MX6UL external bus access, simple kernel module
In-Reply-To: <CAK3Qp=Wp1ibFqeNVoKGgN_FVT63V-nhW9deSbdOWPbTYaAQc=w@mail.gmail.com>
References: <CAK3Qp=Wp1ibFqeNVoKGgN_FVT63V-nhW9deSbdOWPbTYaAQc=w@mail.gmail.com>
Message-ID: <CAK3Qp=VL591dDPRtUfwWfCoPTWcR=uOsD2T2P9H+S3iHzB1Egg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I found the problem by myself.

What happens is that the kernel may disable the clock of unused
peripherals, and this was my case because I'm relying on U-Boot to set
up the external bus. In any case, the DTB should be configured with
the reserved memories, otherwise mmap() will not succeed.

Hope it helps someone in the future,
Fernando A. E.
On Fri, Sep 28, 2018 at 11:23 AM Fernando AE <fernando.ae2017@gmail.com> wrote:
>
> Hello all,
>
> We are kicking off a new project based on the i.MX6UL processor. For
> testing purposes, we are trying to blink a LED that is mapped to
> 0x50005002, going through the External Interface Module (EIM) of the
> processor.
>
> We intend for now to let U-Boot set up the EIM, so that external
> accesses in Linux will work without re-configuring the external bus.
>
> In U-Boot, simply doing:
>
> mw.b 0x50005002 1
> mw.b 0x50005002 0
>
> can already blink the LED.
>
> In the Linux side, we are using the following DTB config:
>
> / {
>     model = "NXP i.MX6 UltraLite";
>     compatible = "fsl,imx6ul";
>
>     chosen {
>         stdout-path = &uart1; /* Default output is uart 1 */
>     };
>
>     memory {
>         reg = <0x80000000 0x10000000>;  /* 2Gb RAM */
>     };
>
>     reserved-memory {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges;
>
>         /* EIM bus access to extension cards, etc */
>         reserved_fpga: buffer at 0 {
>             reg = <0x50000000 0x9000>;
>         };
>     };
>
>     reserved-driver at 0 {
>         compatible = "reserved-memory";
>         memory-region = <&reserved_fpga>;
>     };
> };
>
> And a kernel module compiled out of the tree:
>
> int init_module(void)
> {
>     char *name;
>     char *led;
>     int ret;
>     phys_addr_t paddr;
>     struct device_node *device;
>     struct resource r;
>
>     printk(KERN_INFO "Turning on LED USR\n");
>
>     /* Get reserved memory region from Device-tree */
>     name = "reserved-memory";
>     device = of_find_compatible_node(NULL, NULL, name);
>     if (!device) {
>         printk(KERN_INFO "No device %s found\n", name);
>         goto error1;
>     } else {
>         printk(KERN_INFO "Device %s found\n", name);
>     }
>
>     device = of_parse_phandle(device, "memory-region", 0);
>     if (!device) {
>         printk(KERN_INFO "No %s specified\n", "memory-region");
>         goto error1;
>     } else {
>         printk(KERN_INFO "Device memory-region found\n", "memory-region");
>     }
>
>     ret = of_address_to_resource(device, 0, &r);
>     if (ret) {
>         printk(KERN_INFO "No memory address assigned to the region\n");
>         goto error1;
>     } else {
>         printk(KERN_INFO "Memory address assigned to the region found\n");
>     }
>
>     paddr = r.start;
>     led = memremap(r.start, resource_size(&r), MEMREMAP_WB);
>
>     printk(KERN_INFO "Allocated reserved memory, vaddr: 0x%0lX, paddr:
> 0x%0lX (paddr.end: 0x%0lX)\n",
>             (long)led, (long)paddr, (long)r.end);
>
>     led += 0x5002;
>
>     printk(KERN_INFO "Writing to virtual address 0x%0lX\n", (long)led);
>
>     *led = 0;
>
>     /*
>      * A non 0 return means init_module failed; module can't be loaded.
>      */
>     return 0;
> error1:
>     return 1;
> }
>
> When I insmod the module I get:
>
> root at machine:~# /sbin/insmod /home/greenbird/simple-leds.ko
> simple_leds: no symbol version for module_layout
> simple_leds: loading out-of-tree module taints kernel.
> Turning on LED USR
> Device reserved-memory found
> Device memory-region found
> Memory address assigned to the region found
> Allocated reserved memory, vaddr: 0xA0B10000, paddr: 0x50000000
> (paddr.end: 0x50008FFF)
> Writing to virtual address 0xA0B15002
>
> Which means that the DTB seems to be correctly configured, the
> physical address is mapped to a logical one, but the processor resets
> after a few seconds, without any further message.
>
> Could someone try to help us?
>
> Thanks in advance.
> Kind regards,
> Fernando A. E.
