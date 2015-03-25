From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 25 Mar 2015 11:28:03 -0700
Subject: "ARM: multi_v7_defconfig: Enable shmobile platforms" breaks
 Tegra20 multi_v7_defconfig boot
In-Reply-To: <alpine.DEB.2.02.1503251740130.13341@utopia.booyaka.com>
References: <alpine.DEB.2.02.1503251740130.13341@utopia.booyaka.com>
Message-ID: <CANMBJr7ibVCxQRUG47OT0meNntMjEoVqL7kiEK9DtCfp5NXPgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 25 March 2015 at 11:03, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello Geert,
>
> Looks like commit 4a3a6f86693922b29cf829c63f652b057f14619e ("ARM:
> multi_v7_defconfig: Enable shmobile platforms") breaks Tegra20
> multi_v7_defconfig boot.
>
> Boot log before:
>
> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105514_6af714b069dc278d5d8e1b7afc13568f71d9aba8/20150325105514/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>
> Boot log after:
>
> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105350_4a3a6f86693922b29cf829c63f652b057f14619e/20150325105350/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>
>
> Any ideas?  Stephen Warren thinks there might be an initcall that might
> not check to see what kind of device it's running on.

Can you try to shift your kernel load address around a bit? From
experience with the boards from kernelci.org we find that as the multi
v7 kernel size increases they can clobber memory when they get
decompressed.

>
>
> - Paul
>
> commit 4a3a6f86693922b29cf829c63f652b057f14619e
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Tue Feb 24 15:14:45 2015 +0100
>
>     ARM: multi_v7_defconfig: Enable shmobile platforms
>
>     Enable support for shmobile platforms that became multi-platform aware.
>     Several non-critical drivers and subsystems are built as modules, to keep
>     kernel size reasonable.
>
>     Tested on:
>       - r8a73a4/ape6evm:
>           - U-Boot fails with "Error: unrecognized/unsupported machine ID",
>           - kexec works.
>       - r8a7740/armadillo:
>           - Hermit boot loader fails (larger image, more memory corruption),
>           - kexec works.
>       - r8a7791/koelsch,
>       - sh73a0/kzm9g:
>           - zImage+DTB from U-Boot needs CONFIG_ARM_ATAG_DTB_COMPAT=n,
>           - kexec works.
>       - am335x/boneblack.
>
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Acked-by: Simon Horman <horms+renesas@verge.net.au>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Cheers,

Tyler
