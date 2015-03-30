From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Mar 2015 13:11:46 +0100
Subject: [PATCH] dmaengine: sa11x0: fix boot-time warning
In-Reply-To: <1427708510-17370-1-git-send-email-dbaryshkov@gmail.com>
References: <1427708510-17370-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150330121146.GG24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 12:41:50PM +0300, Dmitry Eremin-Solenikov wrote:
> Fix the following warning by initializing directions field in the dma_device
> structure.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:863 dma_async_device_register+0x2b4/0x4f0()
> this driver doesn't support generic slave capabilities reporting
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc5+ #10
> Hardware name: Sharp-Collie
> [<c0105cd8>] (unwind_backtrace) from [<c0103ef8>] (show_stack+0x10/0x14)
> [<c0103ef8>] (show_stack) from [<c010e9b8>] (warn_slowpath_common+0x74/0xac)
> [<c010e9b8>] (warn_slowpath_common) from [<c010ea20>] (warn_slowpath_fmt+0x30/0x40)
> [<c010ea20>] (warn_slowpath_fmt) from [<c02956fc>] (dma_async_device_register+0x2b4/0x4f0)
> [<c02956fc>] (dma_async_device_register) from [<c0296a9c>] (sa11x0_dma_probe+0x21c/0x358)
> [<c0296a9c>] (sa11x0_dma_probe) from [<c02c52c0>] (platform_drv_probe+0x30/0x94)
> [<c02c52c0>] (platform_drv_probe) from [<c02c39bc>] (driver_probe_device+0x84/0x234)
> [<c02c39bc>] (driver_probe_device) from [<c02c3c4c>] (__driver_attach+0x98/0x9c)
> [<c02c3c4c>] (__driver_attach) from [<c02c1f9c>] (bus_for_each_dev+0x74/0xa4)
> [<c02c1f9c>] (bus_for_each_dev) from [<c02c3230>] (bus_add_driver+0x13c/0x1e8)
> [<c02c3230>] (bus_add_driver) from [<c02c4260>] (driver_register+0x78/0xf8)
> [<c02c4260>] (driver_register) from [<c0100624>] (do_one_initcall+0x84/0x1f4)
> [<c0100624>] (do_one_initcall) from [<c0700e1c>] (kernel_init_freeable+0xf8/0x1b4)
> [<c0700e1c>] (kernel_init_freeable) from [<c040a920>] (kernel_init+0x8/0xf0)
> [<c040a920>] (kernel_init) from [<c01013a8>] (ret_from_fork+0x14/0x2c)
> ---[ end trace e188b8fe0e782e75 ]---
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

It's an improvement, but I wonder whether src_addr_widths, dst_addr_widths
and residue_granularity should also be filled in.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
