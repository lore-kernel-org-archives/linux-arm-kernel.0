From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 8 Jan 2016 14:33:39 -0800
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
Message-ID: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke, Rafal, Alison,

The kernelci.org bot detected a boot regression[1] in -next/arm-soc
which bisected to b02ec7658c ("ARM: multi_v7_defconfig: Enable some
drivers for LS1021A"). Reverting this patch fixes the issue I was
seeing.

After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
causing the issue and disabling it fixed the boot issue. Essentially,
the kernel cannot find the initrd that has been loaded into memory by
CFE bootloader with this option enabled as I inject the following
command line into the DT before it's loaded over tftp.

Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'

Kernel arguments injected into DT: 'console=ttyS0,115200
initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'

I'm wondering how we should proceed forward here. Alison, Is it a firm
requirement you need CONFIG_BLK_DEV_RAM enabled by default? Hauke,
Rafal, Is there another way to configure this platform to boot a
kernel/ramdisk without passing the initrd option on the command line?

Cheers,

Tyler

[1] http://kernelci.org/boot/bcm4708-smartrg-sr400ac/?fail
