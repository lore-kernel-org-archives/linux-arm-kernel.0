From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 16 Dec 2015 11:34:30 -0800
Subject: arm-soc boot: 320 boots: 12 failed,
 308 passed (v4.4-rc3-483-gb48b5ceb7227)
In-Reply-To: <1746045.ErmxH37Pke@wuerfel>
References: <567128b4.46b71c0a.17f65.7531@mx.google.com>
 <1746045.ErmxH37Pke@wuerfel>
Message-ID: <CANMBJr6oi5mrUnzTG8J=C69K5ra93MQDjoVP7ef+1oB1RPpGuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2015 at 02:17, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 December 2015 01:02:44 kernelci. org bot wrote:
>> arm-soc boot: 320 boots: 12 failed, 308 passed (v4.4-rc3-483-gb48b5ceb7227)
>>
>> Full Boot Summary: https://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
>> Full Build Summary: https://kernelci.org/build/arm-soc/kernel/v4.4-rc3-483-gb48b5ceb7227/
>>
>> Tree: arm-soc
>> Branch: local/for-next
>> Git Describe: v4.4-rc3-483-gb48b5ceb7227
>> Git Commit: b48b5ceb7227a8e6e548dae7a44c80ad85719808
>> Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
>> Tested: 67 unique boards, 18 SoC families, 22 builds out of 135
>>
>> Boot Failures Detected: https://kernelci.org/boot/?v4.4-rc3-483-gb48b5ceb7227&fail
>
> We got three regressions in the arm-soc for-next branch today, compared to yesterday:

I had the bot bisect these failures, results below.

>
> * I did not merge any rockchip changes, but it looks like multi_v7_defconfig is
>   now broken on rk3288-rock2-square and rk3288-veyron-jerry (not in the list below,
>   but in the web interface). I put a diff of the defconfig file on
>   http://pastebin.com/DHgzz1jr, but I don't anything that may have cause the
>   regression.

The bisection pointed d2318f340253 ("arm64: dts: berlin4ct: add
watchdog nodes") which is clearly a red herring. kernelci.org inserts
the modules from the build into the ramdisk, and eudev will probe
them. With the modules inserted into the ramdisk, it fails to reach a
user space prompt. If I remove the modules from the ramdisk it boots
fine[1]. I may manually bisect if we cannot spot the issue easily.

> * bcm4708-smartrg-sr400ac doesn't find its rootfs any more
>
> [   16.670994] No filesystem could mount root, tried:  ext3 ext2 ext4 squashfs vfat msdos ntfs
> [   16.679388] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
>
>   I merged some patches from Florian yesterday, but it could also be a problem with
>   the defconfig changes

The bisection pointed to b02ec7658c98 ("ARM: multi_v7_defconfig:
Enable some drivers for LS1021A")

I've rebased my tree with arm-soc for-next, and reverted the commits
listed above. Should know shortly if the reverts fix the boot issues.

> * Juno seems to be sick and doesn't like LAVA today:
>
> Connected to serial03.lavalab.
> Escape character is '^]'.
> Command sent successfully.
> Command sent successfully.
> ErrorMessage: Failed to boot test image.
> Lava failed at action boot_linaro_image with error:Failed to boot test image.
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/dist-packages/lava_dispatcher/job.py", line 381, in run
>     action.run(**params)
>   File "/usr/lib/python2.7/dist-packages/lava_dispatcher/actions/boot_control.py", line 156, in run
>     raise CriticalError("Failed to boot test image.")
> CriticalError: Failed to boot test image.
> Command sent successfully.

Indeed, I'll look into this. Thanks for reporting.

Cheers,

Tyler

[1] http://nwdrone.com/scheduler/job/13662/log_file
