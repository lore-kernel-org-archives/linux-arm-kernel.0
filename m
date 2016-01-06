From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 5 Jan 2016 16:22:01 -0800
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160104224233.GU16023@sirena.org.uk>
References: <20160104224233.GU16023@sirena.org.uk>
Message-ID: <20160106002201.GA16273@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 10:42:33PM +0000, Mark Brown wrote:
> Since 20151231 -next has been failing to boot on a wide range of ARM
> platforms in the kernelci.org boot tests[1].  Doing bisections with
> Arndale and BeagleBone Black identifies 904769ac82ebf (mm/page_alloc.c:
> calculate zone_start_pfn at zone_spanned_pages_in_node()) from the akpm
> tree as the first broken commit[2,3].  An example bootlog from the
> failure is:
> 
>    http://storage.kernelci.org/next/next-20151231/arm-multi_v7_defconfig/lab-cambridge/boot-exynos5250-arndale.html
> 
> which shows no output on the console once we start the kernel, a brief
> sampling of failing boards suggests this is the normal failure mode.
> x86 and arm64 targets seem fine (juno shows up as failing but the boot
> log seems fine so it's probably a false positive, Mustang was failing
> already) and there are a small number of ARM platforms that boot.  I've
> not yet had any time to investigate further than that (including trying
> a revert of that commit), sorry.
> 
I see the same problem with my qemu tests for arm.

Reverting the offending commit together with cd31fe16b585 ("mm/page_alloc.c:
set a zone_start_pfn value in zone_spanned_pages_in_node") fixes the problem.

Guenter
