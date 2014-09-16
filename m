From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 12:56:45 +0100
Subject: Exynos build failure in -next allmodconfig
In-Reply-To: <541822AC.8040805@samsung.com>
References: <E1XTTy1-0000vT-NC@cassiel.sirena.org.uk>
 <20140915163458.GS7960@sirena.org.uk>
 <20140915175709.GE12361@n2100.arm.linux.org.uk>
 <541822AC.8040805@samsung.com>
Message-ID: <20140916115645.GH12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 01:44:44PM +0200, Krzysztof Koz?owski wrote:
> On 15.09.2014 19:57, Russell King - ARM Linux wrote:
>> On Mon, Sep 15, 2014 at 09:34:58AM -0700, Mark Brown wrote:
>>> On Mon, Sep 15, 2014 at 11:57:09AM +0100, Build bot for Mark Brown wrote:
>>>
>>> Today's -next got a build failure in ARM allmodconfig due to platsmp.c:
>>>
>>> | arch/arm/mach-exynos/platsmp.c:198:31: warning: incorrect type in return expression (different address spaces)
>>> | arch/arm/mach-exynos/platsmp.c:198:31:    expected void [noderef] <asn:2>*
>>> | arch/arm/mach-exynos/platsmp.c:198:31:    got void *
>>> | arch/arm/mach-exynos/platsmp.c:198:31: warning: incorrect type in return expression (different address spaces)
>>> | arch/arm/mach-exynos/platsmp.c:198:31:    expected void [noderef] <asn:2>*
>>> | arch/arm/mach-exynos/platsmp.c:198:31:    got void *
>>> |   CC      arch/arm/mach-exynos/platsmp.o
>>> | /tmp/ccC9fkwF.s: Assembler messages:
>>> | /tmp/ccC9fkwF.s:423: Error: selected processor does not support ARM mode `isb '
>>> | /tmp/ccC9fkwF.s:428: Error: selected processor does not support ARM mode `isb '
>>> | /tmp/ccC9fkwF.s:429: Error: selected processor does not support ARM mode `dsb '
>>> | scripts/Makefile.build:257: recipe for target 'arch/arm/mach-exynos/platsmp.o' failed
>>>
>>> Looks like we need a compiler flags override for that file.
>>
>> Or.. the question is why a .c file is not using the proper macros.
>
> Actually I am the one to blame for build failure (commit: "ARM: EXYNOS:  
> Move code from hotplug.c to platsmp.c"). The problem is  
> v7_exit_coherency_flush() which I think does not make sense on ARMv6.
>
> I'll replace the ISB and DSB commands with macros but the real question  
> is whether the mach-exynos/platsmp.c file and mach-exynos directory  
> should be compiled when CONFIG_ARCH_EXYNOS is not defined?

It's entirely possible that a kernel will be configured to support ARMv6
and ARMv7, which can also include exynos support.  In this case, it will
be built using compiler flags for ARMv6, since ARMv7 is compatible with
the ARMv6 ISA (even though a few instructions are deprecated.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
