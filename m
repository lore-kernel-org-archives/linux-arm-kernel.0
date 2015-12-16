From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 11:17:30 +0100
Subject: arm-soc boot: 320 boots: 12 failed,
 308 passed (v4.4-rc3-483-gb48b5ceb7227)
In-Reply-To: <567128b4.46b71c0a.17f65.7531@mx.google.com>
References: <567128b4.46b71c0a.17f65.7531@mx.google.com>
Message-ID: <1746045.ErmxH37Pke@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 01:02:44 kernelci. org bot wrote:
> arm-soc boot: 320 boots: 12 failed, 308 passed (v4.4-rc3-483-gb48b5ceb7227)
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
> Full Build Summary: https://kernelci.org/build/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
> 
> Tree: arm-soc
> Branch: local/for-next
> Git Describe: v4.4-rc3-483-gb48b5ceb7227
> Git Commit: b48b5ceb7227a8e6e548dae7a44c80ad85719808
> Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> Tested: 67 unique boards, 18 SoC families, 22 builds out of 135
> 
> Boot Failures Detected: https://kernelci.org/boot/?v4.4-rc3-483-gb48b5ceb7227&fail

We got three regressions in the arm-soc for-next branch today, compared to yesterday:

* I did not merge any rockchip changes, but it looks like multi_v7_defconfig is
  now broken on rk3288-rock2-square and rk3288-veyron-jerry (not in the list below,
  but in the web interface). I put a diff of the defconfig file on
  http://pastebin.com/DHgzz1jr, but I don't anything that may have cause the
  regression.

* bcm4708-smartrg-sr400ac doesn't find its rootfs any more

[   16.670994] No filesystem could mount root, tried:  ext3 ext2 ext4 squashfs vfat msdos ntfs
[   16.679388] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)

  I merged some patches from Florian yesterday, but it could also be a problem with 
  the defconfig changes

* Juno seems to be sick and doesn't like LAVA today:

Connected to serial03.lavalab.
Escape character is '^]'.
Command sent successfully.
Command sent successfully.
ErrorMessage: Failed to boot test image.
Lava failed at action boot_linaro_image with error:Failed to boot test image.
Traceback (most recent call last):
  File "/usr/lib/python2.7/dist-packages/lava_dispatcher/job.py", line 381, in run
    action.run(**params)
  File "/usr/lib/python2.7/dist-packages/lava_dispatcher/actions/boot_control.py", line 156, in run
    raise CriticalError("Failed to boot test image.")
CriticalError: Failed to boot test image.
Command sent successfully.

	Arnd

> arm:
> 
>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y:
>         bcm4708-smartrg-sr400ac: 1 failed lab
>         rk3288-rock2-square: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_LKDTM=y:
>         at91-sama5d3_xplained: 1 failed lab
>         bcm4708-smartrg-sr400ac: 1 failed lab
>         exynos5422-odroidxu3: 1 failed lab
>         rk3288-rock2-square: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=y:
>         rk3288-rock2-square: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_ARM_LPAE=y:
>         rk3288-rock2-square: 1 failed lab
> 
>     multi_v7_defconfig:
>         bcm4708-smartrg-sr400ac: 1 failed lab
>         rk3288-rock2-square: 1 failed lab
>         rk3288-rock2-square_rootfs:nfs: 1 failed lab
> 
> arm64:
> 
>     defconfig+CONFIG_LKDTM=y:
>         juno: 1 failed lab
> 
