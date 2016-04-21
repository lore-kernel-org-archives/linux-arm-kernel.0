From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Apr 2016 08:54:10 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <5717A67C.4010007@opensource.altera.com>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420110643.GI31470@pengutronix.de>
 <5717A67C.4010007@opensource.altera.com>
Message-ID: <20160421065410.GA21638@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:55:40AM -0500, Dinh Nguyen wrote:
> >  void __init socfpga_sysmgr_init(void)
> >  {
> > @@ -38,14 +37,6 @@ void __init socfpga_sysmgr_init(void)
> >  
> >  	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
> >  
> > -	if (of_property_read_u32(np, "cpu1-start-addr",
> > -			(u32 *) &socfpga_cpu1start_addr))
> > -		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
> > -
> > -	/* Ensure that socfpga_cpu1start_addr is visible to other CPUs */
> > -	smp_wmb();
> > -	sync_cache_w(&socfpga_cpu1start_addr);
> > -
> >  	sys_manager_base_addr = of_iomap(np, 0);
> >  
> >  	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
> > 
> 
> Your proposed patch is causing this failure during a CPU hotlpug, and
> ultimately CPU1 doesn't seem to be able to comeback online at all:
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> [   53.664085] CPU1: shutdown
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> [   60.394169] Unable to handle kernel paging request at virtual address
> c0118668

This issue can be fixed by setting the socfpga_boot_fn variable in the
smp_prepare_cpus hook instead of the smp_boot_secondary hook. I just
a fixed version as a formal patch. Compared to the last version I also
removed the unnecessary if(1) and fixed big endian support.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
