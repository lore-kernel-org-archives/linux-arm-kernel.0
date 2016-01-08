From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 08 Jan 2016 11:51:07 +0100
Subject: Armada XP (MV78460): BUG in netdevice.h with maxcpus=2
In-Reply-To: <20160108182537.0a68630c@xhacker> (Jisheng Zhang's message of
 "Fri, 8 Jan 2016 18:25:37 +0800")
References: <568F6A47.6010905@gmail.com> <20160108182537.0a68630c@xhacker>
Message-ID: <87fuy81h0k.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,
 
 On ven., janv. 08 2016, Jisheng Zhang <jszhang@marvell.com> wrote:

> Hi Stefan,
>
> On Fri, 8 Jan 2016 08:50:31 +0100 Stefan Roese wrote:
>
>> Hi Thomas,
>> 
>> I'm currently trying to boot latest Linux on the DB-MV784MP-GP
>> Marvell board. This works just fine for the normal
>> configuration. But when I try to boot with only 2 CPUs enabled
>> (maxcpus=2), mounting the rootfs via NFS crashes with this
>> log:
>> 
>> [   16.408285] ------------[ cut here ]------------
>> [   16.412915] kernel BUG at include/linux/netdevice.h:507!
>> [   16.418239] Internal error: Oops - BUG: 0 [#1] SMP ARM
>> [   16.423390] Modules linked in:
>> [   16.426464] CPU: 0 PID: 1424 Comm: systemd-udevd Not tainted 4.4.0-rc8-00045-gcbf389a #37
>> [   16.434660] Hardware name: Marvell Armada 370/XP (Device Tree)
>> [   16.440507] task: ee9d3100 ti: ee164000 task.ti: ee164000
>> [   16.445927] PC is at mvneta_percpu_notifier+0x358/0x35c
>> [   16.451167] LR is at mvneta_percpu_notifier+0x27c/0x35c
>> [   16.456405] pc : [<c0310d60>]    lr : [<c0310c84>]    psr: 60010013
>> [   16.456405] sp : ee165e18  ip : 00000003  fp : c077c494
>> [   16.467914] r10: c077cd58  r9 : 00000002  r8 : c077ce08
>> [   16.473154] r7 : eea8a520  r6 : ff7ea400  r5 : 00000004  r4 : 00000000
>> [   16.479697] r3 : 00000000  r2 : 00000008  r1 : 00000004  r0 : 00000004
>> [   16.486243] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [   16.493402] Control: 10c5387d  Table: 2e16806a  DAC: 00000051
>> [   16.499168] Process systemd-udevd (pid: 1424, stack limit = 0xee164220)
>> [   16.505801] Stack: (0xee165e18 to 0xee166000)
>> [   16.510170] 5e00:                                                       c07b89c0 eea8a500
>> [   16.518373] 5e20: 00000002 ffffffdb 00000002 00000002 00000000 c0782aa0 00000000 ee82a5c0
>> [   16.526575] 5e40: 00000000 c003fb44 00000000 00000000 c077c494 00000000 00000001 c0024f68
>> [   16.534774] 5e60: 00000000 00000000 00000002 c0025574 ee165e7c 00000022 00000000 00000028
>> [   16.542977] 5e80: 00000002 eefca010 eefca044 ee165f88 edc61240 b6f07000 00000000 c00255fc
>> [   16.551178] 5ea0: c02907fc c028c520 eefca010 00000001 00000001 c028c5ac 00000000 01eada00
>> [   16.559381] 5ec0: 00000001 edeada00 edc6124c c01324f0 00000000 00000000 00000800 ee9c6f40
>> [   16.567582] 5ee0: c0132438 b6f07000 ee165f88 c000f7c4 ee164000 00000000 00039388 c00d6bd0
>> [   16.575782] 5f00: 00000001 00000000 0002b2cc c00092f4 00001000 00001000 b6f07000 00000003
>> [   16.583981] 5f20: 00000000 edc22580 00000001 c077ce2c 00000073 c00c3994 000b6f07 00000000
>> [   16.592180] 5f40: beef1270 ffffffff 48400000 ee9c6f40 00000001 b6f07000 ee165f88 c000f7c4
>> [   16.600385] 5f60: ee164000 c00d7414 0002b2cc c00b3a88 ee9c6f40 ee9c6f40 b6f07000 00000001
>> [   16.608588] 5f80: c000f7c4 c00d7c38 00000000 00000000 48400000 00000001 b6f07000 00046c70
>> [   16.616797] 5fa0: 00000004 c000f600 00000001 b6f07000 00000005 b6f07000 00000001 00000000
>> [   16.625003] 5fc0: 00000001 b6f07000 00046c70 00000004 00000001 00000000 00039860 00039388
>> [   16.633208] 5fe0: 00000000 beef181c b6d6bf81 b6da5066 400d0030 00000005 00180011 000022be
>> [   16.641431] [<c0310d60>] (mvneta_percpu_notifier) from [<c003fb44>] (notifier_call_chain+0x44/0x84)
>> [   16.650513] [<c003fb44>] (notifier_call_chain) from [<c0024f68>] (cpu_notify+0x24/0x40)
>> [   16.658544] [<c0024f68>] (cpu_notify) from [<c0025574>] (_cpu_up+0x14c/0x164)
>> [   16.665700] [<c0025574>] (_cpu_up) from [<c00255fc>] (cpu_up+0x70/0x94)
>> [   16.672333] [<c00255fc>] (cpu_up) from [<c028c520>] (device_online+0x64/0x88)
>> [   16.679490] [<c028c520>] (device_online) from [<c028c5ac>] (online_store+0x68/0x74)
>> [   16.687174] [<c028c5ac>] (online_store) from [<c01324f0>] (kernfs_fop_write+0xb8/0x1b4)
>> [   16.695206] [<c01324f0>] (kernfs_fop_write) from [<c00d6bd0>] (__vfs_write+0x1c/0xd8)
>> [   16.703061] [<c00d6bd0>] (__vfs_write) from [<c00d7414>] (vfs_write+0x90/0x16c)
>> [   16.710391] [<c00d7414>] (vfs_write) from [<c00d7c38>] (SyS_write+0x44/0x9c)
>> [   16.717464] [<c00d7c38>] (SyS_write) from [<c000f600>] (ret_fast_syscall+0x0/0x3c)
>> [   16.725057] Code: 3afffff5 e3a00001 e28dd00c e8bd8ff0 (e7f001f2) 
>> [   16.731167] ---[ end trace 1451bd9f24838b0f ]---
>> 
>> 
>> Again, this only happen, if I boot the system with 2 CPUs online.
>> Without this kernel commandline arg (and all 4 CPUs online),
>> mounting the NFS rootfs works just fine.
>> 
>> Is this a known problem? Do you have any quick hints how to fix
>> this issue?
>
>
> can you please try the following patch?

This patch looks good for me. The reason behind using the
for_each_present_cpu macro was to be ready when the CPUs come
online. But this case is already managed by the CPU notifiers.

Once Stefan will have confirmed that it fixed his issue, would you mind
to send a proper patch to the netdev mailing list?

Thanks,

Gregory


>
> Thanks
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index ed622fa..e1242f4 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2446,7 +2446,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
>  	mvneta_port_enable(pp);
>  
>  	/* Enable polling on the port */
> -	for_each_present_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
>  
>  		napi_enable(&port->napi);
> @@ -2472,7 +2472,7 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
>  
>  	phy_stop(pp->phy_dev);
>  
> -	for_each_present_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
>  
>  		napi_disable(&port->napi);
> @@ -2907,7 +2907,7 @@ static int mvneta_stop(struct net_device *dev)
>  	mvneta_stop_dev(pp);
>  	mvneta_mdio_remove(pp);
>  	unregister_cpu_notifier(&pp->cpu_notifier);
> -	for_each_present_cpu(cpu)
> +	for_each_online_cpu(cpu)
>  		smp_call_function_single(cpu, mvneta_percpu_disable, pp, true);
>  	free_percpu_irq(dev->irq, pp->ports);
>  	mvneta_cleanup_rxqs(pp);
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
