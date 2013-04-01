From: nigel@nobiscuit.com (Nigel Roberts)
Date: Mon, 1 Apr 2013 22:39:40 +1100
Subject: [PATCH 2/2] Fix GE0/GE1 init on ix2-200 as GE0 has no PHY
In-Reply-To: <20130331212335.GM13280@titan.lakedaemon.net>
References: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
 <1364703204-14982-3-git-send-email-nigel@nobiscuit.com>
 <20130331212335.GM13280@titan.lakedaemon.net>
Message-ID: <B3DDAAD1-914A-40AE-88FA-590FDD7CE6F3@nobiscuit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013, at 8:23 AM, Jason Cooper <jason@lakedaemon.net> wrote:

> Nigel,
> 
> On Sun, Mar 31, 2013 at 03:13:24PM +1100, Nigel Roberts wrote:
> 
> Please include a description here about the problem and how this fixed
> it.
> 
> Also, please Cc: Alan Butler alanbutty12 at gmail.com, he's the original
> author of the support for this board.  I'd like to know why it
> (hopefully) worked for him, but doesn't work for you.

Thanks Jason. 

With the original version of board-iomega_ix2_200.c provided by Alan, the PHY for GE1 (port 1) is not configured because of the use of MV643XX_ETH_PHY_NONE. The speed and duplex are also forced to 1000/full, which means I can't use a 100mb port on my router. It will work just fine for people who use just 1000Mb switch ports, which is why Alan probably didn't have any problems with it.

If I only attempt to initialise GE01 with the correct address of the PHY without initialising GE00 first, I get a kernel panic. This is probably a bug in arch/arm/plat-orion/common.c, but I haven't figured out how to fix it. I'll keep investigating what other changes I need to make so that initialising only GE1 with the correct PHY address doesn't cause this panic. Maybe this will be fixed once the mv643xx_eth driver works properly with device trees.

[   21.139765] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[   21.146715] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[   21.154859] pgd = c0004000
[   21.157576] [00000008] *pgd=00000000
[   21.161182] Internal error: Oops: 5 [#1] ARM
[   21.165466] Modules linked in:
[   21.168540] CPU: 0    Not tainted  (3.8.5 #9)
[   21.172924] PC is at mv643xx_eth_probe+0x254/0x67c
[   21.177739] LR is at mv643xx_eth_probe+0x234/0x67c
[   21.182555] pc : [<c021d3a4>]    lr : [<c021d384>]    psr: 20000013
[   21.182555] sp : cf83fe78  ip : 00000000  fp : 00000000
[   21.194080] r10: c0425208  r9 : c0448e2c  r8 : c0458848
[   21.199330] r7 : cf861a80  r6 : c0457b48  r5 : cf814440  r4 : cf814000
[   21.205886] r3 : 00000001  r2 : 0000000b  r1 : 00000000  r0 : 00000000
[   21.212445] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   21.219786] Control: 0005397f  Table: 00004000  DAC: 00000017
[   21.225558] Process swapper (pid: 1, stack limit = 0xcf83e1b8)
[   21.231418] Stack: (0xcf83fe78 to 0xcf840000)
[   21.235798] fe60:                                                       cf805bac c0458858
[   21.244018] fe80: cf861f40 00000000 c045888c c0458858 c045888c c0477e8c c0477e8c 0000003d
[   21.252240] fea0: c0448e2c c0425208 00000000 c01deb64 c01deb50 c01ddc5c 00000000 c0458858
[   21.260454] fec0: c045888c c0477e8c 00000000 c01dddf4 c0477e8c cf83fee0 c01ddd94 c01dc738
[   21.268669] fee0: cf805b8c cf834c90 c0477e8c c0477e8c ceabb300 c0472c00 00000000 c01dd3dc
[   21.276891] ff00: c03a8ca2 c03a8cae c0477e8c c043d724 00000000 c0481240 0000003d c01de0a0
[   21.285106] ff20: c01deb88 00000000 c043d724 00000000 c0481240 0000003d c0425208 c043d740
[   21.293318] ff40: 00000006 c0008598 00000006 00000006 00000000 00000006 c0444a90 00000006
[   21.301534] ff60: c0444a94 c0444a74 c0481240 0000003d c0448e2c c0425890 00000006 00000006
[   21.309747] ff80: c0425208 00000000 00000000 c030083c 00000000 00000000 00000000 00000000
[   21.317962] ffa0: 00000000 c0300844 00000000 c0009110 00000000 00000000 00000000 00000000
[   21.326175] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   21.334389] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00210007 00450000
[   21.342621] [<c021d3a4>] (mv643xx_eth_probe+0x254/0x67c) from [<c01deb64>] (platform_drv_probe+0x14/0x18)
[   21.352236] [<c01deb64>] (platform_drv_probe+0x14/0x18) from [<c01ddc5c>] (driver_probe_device+0xb8/0x1f0)
[   21.361938] [<c01ddc5c>] (driver_probe_device+0xb8/0x1f0) from [<c01dddf4>] (__driver_attach+0x60/0x84)
[   21.371382] [<c01dddf4>] (__driver_attach+0x60/0x84) from [<c01dc738>] (bus_for_each_dev+0x50/0x84)
[   21.380477] [<c01dc738>] (bus_for_each_dev+0x50/0x84) from [<c01dd3dc>] (bus_add_driver+0xa8/0x21c)
[   21.389562] [<c01dd3dc>] (bus_add_driver+0xa8/0x21c) from [<c01de0a0>] (driver_register+0x9c/0x138)
[   21.398653] [<c01de0a0>] (driver_register+0x9c/0x138) from [<c043d740>] (mv643xx_eth_init_module+0x1c/0x3c)
[   21.408445] [<c043d740>] (mv643xx_eth_init_module+0x1c/0x3c) from [<c0008598>] (do_one_initcall+0x90/0x168)
[   21.418242] [<c0008598>] (do_one_initcall+0x90/0x168) from [<c0425890>] (kernel_init_freeable+0x118/0x1e4)
[   21.427948] [<c0425890>] (kernel_init_freeable+0x118/0x1e4) from [<c0300844>] (kernel_init+0x8/0xe4)
[   21.437125] [<c0300844>] (kernel_init+0x8/0xe4) from [<c0009110>] (ret_from_fork+0x14/0x24)
[   21.445518] Code: e3520000 1202201f e5931004 13a03001 (e591b008)
[   21.451690] ---[ end trace 1baf370a96a1315c ]---
[   21.456349] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   21.456349]

> 
>> ---
>> arch/arm/mach-kirkwood/board-iomega_ix2_200.c |    7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> index f655b26..e5f7041 100644
>> --- a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> +++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> @@ -20,10 +20,15 @@ static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
>> 	.duplex         = DUPLEX_FULL,
>> };
>> 
>> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
>> +        .phy_addr       = MV643XX_ETH_PHY_ADDR(11),
>> +};
>> +
>> void __init iomega_ix2_200_init(void)
>> {
>> 	/*
>> 	 * Basic setup. Needs to be called early.
>> 	 */
>> -	kirkwood_ge01_init(&iomega_ix2_200_ge00_data);
>> +	kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
>> +	kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
> 
> This looks a lot more legit, have you tried removing .speed and .duplex
> from ge00?  We see that a lot with boards converted from out-of-tree
> legacy board files, I'm not certain those declarations are necessary.

They're used by mv643xx_eth if you don't specify a PHY address, which is necessary as per the above.

Thanks,
Nigel
