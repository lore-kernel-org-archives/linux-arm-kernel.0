From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 22 Oct 2018 14:52:21 +0200 (CEST)
Subject: DMA configuration in non-DT probed driver
In-Reply-To: <839aa8cf-aabe-c087-4d35-c1a96bbf3f13@arm.com>
References: <18dfef35-54f6-0e45-ff8e-f0c3e70b8580@i2se.com>
 <839aa8cf-aabe-c087-4d35-c1a96bbf3f13@arm.com>
Message-ID: <1629892246.163919.1540212741937@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

> Robin Murphy <robin.murphy@arm.com> hat am 18. Oktober 2018 um 15:35 geschrieben:
> 
> 
> More generally, though, I maintain that DMA configuration is logically 
> the responsibility of whoever creates the struct device, i.e. usually 
> the parent/bus driver. Whether DMA master devices are discrete 
> peripheral blocks or just firmware functions running on some DSP (or 
> indeed GPU), *somewhere* in the silicon there is a DMA master interface 
> emitting transactions, and that interface (or at least one which is 
> indistinguishable from it) should always be described by some DT node 
> (e.g. for dynamically-discovered PCI devices it's the 'platform' side of 
> the host bridge).
> 
> If you consider the VCHIQ node to represent "stuff the VC4 does" and 
> don't want to go to a full-blown "devices owned by VC4" bus_type 
> implementation similar to Host1x, then given that in practice you've got 
> a pretty simple interconnect topology I reckon it's fair and 
> sufficiently accurate for the VCHIQ driver to configure 
> dynamically-created devices based on its own node, i.e. something like:
> 
> 	child_dev = platform_device_alloc(...)
> 	of_dma_configure(&child_dev->dev, vchiq_dev->of_node, ...);
> 	platform_device_add(child_dev);
> 

i tried this but i'm getting "DMA mask not set" from of_dma_configure.

So i tried the following to register the camera and audio:

static struct platform_device *
vchiq_register_child(struct platform_device *pdev, const char *name)
{
	struct platform_device_info pdevinfo;

	memset(&pdevinfo, 0, sizeof(pdevinfo));

	pdevinfo.parent = &pdev->dev;
	pdevinfo.name = name;
	pdevinfo.id = PLATFORM_DEVID_NONE;
	pdevinfo.dma_mask = DMA_BIT_MASK(32);

	return platform_device_register_full(&pdevinfo);
}

This works except of the following memleak:

unreferenced object 0xec9c9300 (size 64):
  comm "systemd-udevd", pid 182, jiffies 4294937996 (age 1376.140s)
  hex dump (first 32 bytes):
    ff ff ff ff 00 00 00 00 2f 70 6c 61 74 66 6f 72  ......../platfor
    6d 2f 73 6f 63 2f 33 66 30 30 62 38 34 30 2e 6d  m/soc/3f00b840.m
  backtrace:
    [<9d7676d1>] vchiq_register_child+0x58/0x74 [vchiq]
    [<6a2780cc>] vchiq_probe+0x1c0/0x264 [vchiq]
    [<278d830e>] platform_drv_probe+0x48/0x98
    [<c9846b79>] really_probe+0x228/0x2d0
    [<489d6b89>] driver_probe_device+0x60/0x164
    [<ccf84a43>] __driver_attach+0xd0/0xd4
    [<042acada>] bus_for_each_dev+0x74/0xb4
    [<b04ae13a>] bus_add_driver+0x18c/0x210
    [<a66d3fa5>] driver_register+0x7c/0x114
    [<a7353eeb>] do_one_initcall+0x54/0x1fc
    [<9420261f>] do_init_module+0x64/0x1f4
    [<571c859a>] load_module+0x1dfc/0x24bc
    [<06885682>] sys_finit_module+0xac/0xd8
    [<85e18c3d>] __sys_trace_return+0x0/0x20
    [<0051c54d>] 0xbecb0898
    [<0a0ced8e>] 0xffffffff

Any idea what i've missed?

Stefan
