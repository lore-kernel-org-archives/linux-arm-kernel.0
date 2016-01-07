From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jan 2016 15:59:58 +0000
Subject: next boot: 564 boots: 59 failed, 448 passed with 57 offline
 (next-20160107)
In-Reply-To: <568e8740.01941c0a.31072.ffffb67b@mx.google.com>
References: <568e8740.01941c0a.31072.ffffb67b@mx.google.com>
Message-ID: <20160107155958.GG6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 07:41:52AM -0800, kernelci.org bot wrote:

> Tree: next
> Branch: local/master
> Git Describe: next-20160107
> Git Commit: 0f023a298a7d2a8e99c54913f7277b3c08c1f5c9
> Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Tested: 95 unique boards, 25 SoC families, 28 builds out of 135
> 
> Boot Failures Detected: https://kernelci.org/boot/?next-20160107&fail

For the past couple of days -next has been failing to boot on various
Tegra platforms, there are failures involving either no kernel output or
(with tegra_defconfig) backtraces during CMA allocation from USB, for
example:

   http://storage.kernelci.org/next/next-20160107/arm-tegra_defconfig/lab-khilman/boot-tegra30-beaver.html

>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y:
>         tegra124-jetson-tk1: 2 failed labs
>         tegra30-beaver: 1 failed lab
> 
>     tegra_defconfig:
>         tegra124-jetson-tk1: 2 failed labs
>         tegra124-jetson-tk1_rootfs:nfs: 1 failed lab
>         tegra124-nyan-big: 1 failed lab
>         tegra30-beaver: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_ARM_LPAE=y:
>         tegra124-jetson-tk1: 1 failed lab
>         tegra124-nyan-big: 1 failed lab
> 
>     multi_v7_defconfig:
>         tegra124-jetson-tk1: 2 failed labs
>         tegra30-beaver: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_LKDTM=y:
>         tegra124-jetson-tk1: 2 failed labs
>         tegra30-beaver: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=y:
>         tegra124-jetson-tk1: 2 failed labs
>         tegra30-beaver: 1 failed lab

I did bisects yesterday but they were a bit inconclusive, showing a
series of skipped commits in the TTY tree as being the culprits:

afd7f88f157796e586fc99d62da13a54024e0731 serial: 8250: move of_serial code to 8250 directory
4e33870b3bb691996354a8f9e8f69458b4fc34d9 serial: of: CONFIG_SERIAL_8250 is always set
d1b5c87fa8058a3f477ae05555916dd1cea934ad serial: remove NWP serial support

which seems more than a little surprising and like they might be false
positives, especially in the cases that do produce output.  The errors
today look the same.  I've not investigated further than the bisects.

Full bisect logs:

 https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/140/console
 https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/141/console
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160107/819e76d9/attachment-0001.sig>
