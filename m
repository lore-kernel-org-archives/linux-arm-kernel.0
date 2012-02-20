From: joancarles@fqingenieria.es (joancarles)
Date: Mon, 20 Feb 2012 15:40:35 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220135155.GC9921@sapphire.tkos.co.il>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
 <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
 <20120220135155.GC9921@sapphire.tkos.co.il>
Message-ID: <5e2eb160cb46960b705b71145f4d03c4@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch

>> Kernel command line: console=ttymxc0,115200 root=/dev/mtdblock2
>> rootfstype=jffs2 
>> mtdparts=physmap-flash.0:0x100000(u-boot),0x300000(kernel),0x3C00000(jffs2)
>> bootcmd=tftpboot 0x81000000 /v2.1.8-rc/uImage
>
> [snip]
>
>> List of all partitions:
>> No filesystem could mount root, tried:  jffs2
>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
>> [<c00181d0>] (unwind_backtrace+0x0/0xf0) from [<c0325f58>]
>> (panic+0x60/0x198)
>> [<c0325f58>] (panic+0x60/0x198) from [<c041db7c>]
>> (mount_block_root+0x244/0x294)
>> [<c041db7c>] (mount_block_root+0x244/0x294) from [<c041dd4c>]
>> (prepare_namespace+0x11c/0x180)
>> [<c041dd4c>] (prepare_namespace+0x11c/0x180) from [<c041d800>]
>> (kernel_init+0xe8/0x11c)
>> [<c041d800>] (kernel_init+0xe8/0x11c) from [<c0013cf4>]
>> (kernel_thread_exit+0x0/0x8)
>
> MTD support in your kernel seems to be missing.

Yep, kind of, even tough:

$> grep "^CONFIG.MTD" .config
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_PHYSMAP=y

> What kind of flash do you have on your board? NOR? NAND?

That's most probably the culprit, thanks. We have a NOR flash, so I 
need to find a way to enable it. Funny enough, our working 2.6.39.3 
.config has the same settings for MTD:

linux-2.6.39.3$> grep "^CONFIG.MTD" .config
CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_PHYSMAP=y

> Please post your kernel .config file.

Attached is the .config file for the non-working kernel.

Cheers
-- 
Joan C. Abelaira
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: .config
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120220/41b2c97b/attachment-0001.ksh>
