From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 31 May 2016 09:34:27 +0900
Subject: Help needed with kexec on arm64
In-Reply-To: <DB5PR04MB16887FF10CEA6AA9BF990F0DE6420@DB5PR04MB1688.eurprd04.prod.outlook.com>
References: <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
 <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160511005334.GA8417@linaro.org>
 <DB5PR04MB1688C3F122091109E6BD9B68E6740@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160519110307.GA4941@linaro.org>
 <DB5PR04MB16887FF10CEA6AA9BF990F0DE6420@DB5PR04MB1688.eurprd04.prod.outlook.com>
Message-ID: <574CDC13.9090709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2016 08:51 PM, Harninder Rai wrote:
> Hello Takahiro Akashi,
>
> Please see the following log which I was talking about in my last communication
> Any idea as to what could be wrong just when I move from RAM based rootfs to SD based rootfs?
>
>> I did check /proc/iomem and everything looks there. This is very strange
>> since if I keep everything same and just move the rootfs from RAM based to
>> SD based, I start getting this issue.
>
> root at ls2085ardb:/# kexec -p ./vmlinux.wor --initrd=./initramfs_arm64_busybox1_22_1_with_coremark.cpio.gz --append='console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 memblock=debug maxcpus=1'
> Memory for crashkernel is not reserved
> Please reserve memory by passing"crashkernel=X at Y" parameter to kernel
> Then try to loading kdump kernel
> root at ls2085ardb:/# cat /proc/iomem
> 02000000-0200ffff : /i2c at 2000000
> 02140000-0214ffff : mmc0
> 021c0500-021c05ff : serial
> 021c0600-021c06ff : serial
> 03100000-03107fff : /usb3 at 3100000
> 0310c100-0310ffff : /usb3 at 3100000
> 03110000-03117fff : /usb3 at 3110000
> 0311c100-0311ffff : /usb3 at 3110000
> 05000000-057fffff : /iommu at 5000000
> 80000000-ffffffff : System RAM
>    80080000-80a39333 : Kernel code
>    80af5000-80bd4fff : Kernel data
>    8c000000-8fffffff : Crash kernel
> 80c000000-80c00003f : mc_portal


Please trace is_crashkernel_mem_reserved() and kexec_iomem_for_each_line().

-Takahiro AKASHI

> Regards
> Harry++
>
