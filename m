From: monstr@monstr.eu (Michal Simek)
Date: Fri, 04 Apr 2014 07:26:46 +0200
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <20140403191120.GW7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk> <533BC56D.4010600@monstr.eu>
 <20140403191120.GW7528@n2100.arm.linux.org.uk>
Message-ID: <533E4296.8090808@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2014 09:11 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 02, 2014 at 10:08:13AM +0200, Michal Simek wrote:
>> Reset values are correctly setup by bootrom to 0x02060000
>> That's why we can even use full mask.
>> For current mainline code just like this
>> 	l2x0_of_init(0x00000000, 0xffffffff);
>> and we will submit the code which change this to
>> 	l2x0_of_init(0x00400000, 0xffffffff);
> 
> If you wish to do that, please use 0xffbfffff as the mask, otherwise
> some of the checks will fire (about possibly corrupted values.)
> 
> Fields you wish to set to a value must have clear bits in the mask.
> This is to stop things like:
> 
> 	l2x0_of_init(0x...246, 0x...fff)
> 
> which if the LSBs of the register are already set to a different value,
> ends up doing this:
> 
> 	new_reg = (old_reg & mask) | val
> 
> and hence ends up ORing the specified value with the existing value in
> the register.  Hence, (val & mask) must be zero.
> 
> I'd rather not force bit 22 on for everyone - this problem /should/ no
> longer be present with CMA since the memory is remapped in place rather
> than having a second mapping setup.

ok. I think reasonable solution is to use
l2x0_of_init(0, ~0); in this patch.
And we will enable L2C_AUX_CTRL_SHARED_OVERRIDE on the top of this series.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/313ffc31/attachment.sig>
