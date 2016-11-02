From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 2 Nov 2016 13:54:58 +0000
Subject: Tegra baseline test results for v4.9-rc1
In-Reply-To: <ff60cb86-a8e3-dc25-ac86-b6e3ccf7ea17@nvidia.com>
References: <ff60cb86-a8e3-dc25-ac86-b6e3ccf7ea17@nvidia.com>
Message-ID: <78f0138e-e447-f777-bdcb-3c39fcccf335@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/11/16 13:39, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.9-rc1.
> Logs and other details at:
>
>     https://nvtb.github.io//linux/test_v4.9-rc1/20161102045959/
>
>
> Test summary
> ------------
>
> Build: zImage:
>     FAIL: ( 1/ 2): multi_v7_defconfig

This issue was exposed by commit 3f0958d8aea7 ("ARM: multi_v7_defconfig: 
enable CONFIG_EFI") because our builder is using an older version on 
bin-utils. This has been fixed by commit b0dddf6c147e ("efi/arm: Fix 
absolute relocation detection for older toolchains").

>     Pass: ( 1/ 2): tegra_defconfig
>
> Build: Image:
>     Pass: ( 1/ 1): defconfig
>
> Boot to userspace: defconfig:
>     Pass: ( 4/ 4): qemu-vexpress64, tegra132-norrin,
> 		   tegra210-p2371-0000, tegra210-smaug
>
> Boot to userspace: tegra_defconfig:
>     Pass: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver
>
> PM: System suspend: tegra_defconfig:
>     FAIL: ( 5/ 5): tegra114-dalmore-a04, tegra124-jetson-tk1,
> 		   tegra124-nyan-big, tegra20-trimslice, tegra30-beaver

These failures are not true/hard failures as suspend is still working. 
Commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing 
continuation lines") exposed a issue with one of the messages seen in 
suspend (which we look for when testing suspend) and caused the suspend 
test to report a failure. This has been fixed by commit 1adb469b9b76 
("PM / suspend: Fix missing KERN_CONT for suspend message").

Jon

-- 
nvpublic
