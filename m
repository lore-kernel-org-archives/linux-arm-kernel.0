From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Tue, 16 Sep 2014 13:44:44 +0200
Subject: Exynos build failure in -next allmodconfig
In-Reply-To: <20140915175709.GE12361@n2100.arm.linux.org.uk>
References: <E1XTTy1-0000vT-NC@cassiel.sirena.org.uk>
 <20140915163458.GS7960@sirena.org.uk>
 <20140915175709.GE12361@n2100.arm.linux.org.uk>
Message-ID: <541822AC.8040805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.09.2014 19:57, Russell King - ARM Linux wrote:
> On Mon, Sep 15, 2014 at 09:34:58AM -0700, Mark Brown wrote:
>> On Mon, Sep 15, 2014 at 11:57:09AM +0100, Build bot for Mark Brown wrote:
>>
>> Today's -next got a build failure in ARM allmodconfig due to platsmp.c:
>>
>> | arch/arm/mach-exynos/platsmp.c:198:31: warning: incorrect type in return expression (different address spaces)
>> | arch/arm/mach-exynos/platsmp.c:198:31:    expected void [noderef] <asn:2>*
>> | arch/arm/mach-exynos/platsmp.c:198:31:    got void *
>> | arch/arm/mach-exynos/platsmp.c:198:31: warning: incorrect type in return expression (different address spaces)
>> | arch/arm/mach-exynos/platsmp.c:198:31:    expected void [noderef] <asn:2>*
>> | arch/arm/mach-exynos/platsmp.c:198:31:    got void *
>> |   CC      arch/arm/mach-exynos/platsmp.o
>> | /tmp/ccC9fkwF.s: Assembler messages:
>> | /tmp/ccC9fkwF.s:423: Error: selected processor does not support ARM mode `isb '
>> | /tmp/ccC9fkwF.s:428: Error: selected processor does not support ARM mode `isb '
>> | /tmp/ccC9fkwF.s:429: Error: selected processor does not support ARM mode `dsb '
>> | scripts/Makefile.build:257: recipe for target 'arch/arm/mach-exynos/platsmp.o' failed
>>
>> Looks like we need a compiler flags override for that file.
>
> Or.. the question is why a .c file is not using the proper macros.

Actually I am the one to blame for build failure (commit: "ARM: EXYNOS: 
Move code from hotplug.c to platsmp.c"). The problem is 
v7_exit_coherency_flush() which I think does not make sense on ARMv6.

I'll replace the ISB and DSB commands with macros but the real question 
is whether the mach-exynos/platsmp.c file and mach-exynos directory 
should be compiled when CONFIG_ARCH_EXYNOS is not defined?

Best regards,
Krzysztof
