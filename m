From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 22:42:33 +0000
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c: calculate
 zone_start_pfn at zone_spanned_pages_in_node()"
Message-ID: <20160104224233.GU16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 20151231 -next has been failing to boot on a wide range of ARM
platforms in the kernelci.org boot tests[1].  Doing bisections with
Arndale and BeagleBone Black identifies 904769ac82ebf (mm/page_alloc.c:
calculate zone_start_pfn at zone_spanned_pages_in_node()) from the akpm
tree as the first broken commit[2,3].  An example bootlog from the
failure is:

   http://storage.kernelci.org/next/next-20151231/arm-multi_v7_defconfig/lab-cambridge/boot-exynos5250-arndale.html

which shows no output on the console once we start the kernel, a brief
sampling of failing boards suggests this is the normal failure mode.
x86 and arm64 targets seem fine (juno shows up as failing but the boot
log seems fine so it's probably a false positive, Mustang was failing
already) and there are a small number of ARM platforms that boot.  I've
not yet had any time to investigate further than that (including trying
a revert of that commit), sorry.

[1] http://kernelci.org/boot/all/job/next/kernel/next-20151231/
[2] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/135/console
[3] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/136/console
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/4feed3d4/attachment-0001.sig>
