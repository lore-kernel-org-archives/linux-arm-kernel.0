From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 7 Dec 2016 14:13:03 +0000
Subject: [PATCH 0/4] arm/versatile: no-MMU support
In-Reply-To: <a2ab1e0c-d24b-ac8d-fb9a-4ae7271455b9@uclinux.org>
References: <1481090912-29835-1-git-send-email-gerg@uclinux.org>
 <5847D4F8.1080108@arm.com> <a2ab1e0c-d24b-ac8d-fb9a-4ae7271455b9@uclinux.org>
Message-ID: <584818EF.5020905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/16 13:57, Greg Ungerer wrote:
> Hi Vladimir,
> 
> On 07/12/16 19:23, Vladimir Murzin wrote:
>> Hi Greg,
>>
>> On 07/12/16 06:08, Greg Ungerer wrote:
>>> Does the ARM Versatile machine have a maintainer?
>>> I have CC'ed this patch set to those names reported by get_maintainer.
>>> I had no feedback on the first posting of this series back in August.
>>>
>>> The following patches support configuring and building the versatile
>>> machine with a no-MMU kernel.
>>>
>>> There is only a few minor changes required. It was previously possible
>>> in older kernels to build for versatile with CONFIG_MMU disabled, but
>>> the change to devicetree lost that capability. These changes make it
>>> possible again.
>>>
>>> One patch is a fix for address translation (broken in older kernels too),
>>> two are build problems when CONFIG_MMU is disabled, and the last is the
>>> actuall configuration changes needed.
>>>
>>> The motivation for this is that the versatile machine is well supported
>>> in qemu. And this provides an excellent platform for development and
>>> testing no-MMU support on ARM in general. With these patches applied
>>> it is possible to build and run a kernel with MMU disabled on qemu.
>>
>> I'm wondering if my "Allow NOMMU for MULTIPLATFORM" series [1] work for you?
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg546823.html
> 
> Sorry I hadn't seen these patches before.
> 
> Just tried them out. With CONFIG_EXPERT set I can select and
> build for the Versatile machine with CONFIG_MMU not set. The
> build is successful, but the resulting kernel doesn't boot.

It is why "no guarantee" there ;)

> 
> I see that the resulting .config has CONFIG_PLAT_VERSATILE set
> but not CONFIG_ARCH_VERSATILE. Is this intentional?

No.

> 
> With CONFIG_ARCH_VERSATILE missing the build doesn't traverse
> into arch/arm/mach-versatile, and you don't get any device tree
> built.
> 

I've just done:

$ make ARCH=arm versatile_defconfig nommu.config
...
$ grep VERSATILE .config                                                                                                                                                                                                                                                   1 CONFIG_ARCH_VERSATILE=y
CONFIG_PLAT_VERSATILE=y
CONFIG_I2C_VERSATILE=y
CONFIG_POWER_RESET_VERSATILE=y
CONFIG_PLAT_VERSATILE_CLCD=y
# CONFIG_LEDS_VERSATILE is not set
CONFIG_COMMON_CLK_VERSATILE=y
CONFIG_CLKSRC_VERSATILE=y
CONFIG_VERSATILE_FPGA_IRQ=y
CONFIG_VERSATILE_FPGA_IRQ_NR=4
CONFIG_DEBUG_VERSATILE=y

$ cat arch/arm/configs/nommu.config                                                                                                                                                                                                                                          
CONFIG_EXPERT=y
# CONFIG_MMU is not set

I didn't submit nommu config fragment, but it is is what I've been using to
simplify defconfigs and randconfig builds.

> Ultimately to produce a working kernel we will still need my
> patch 01/04 ("ARM: versatile: support no-MMU mode addressing").
> No surprise here, this was missing in older kernels too.

Agreed.

Cheers
Vladimir

> 
> Regards
> Greg
> 
> 
>>>
>>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>>> ---
>>>  arch/arm/Kconfig                       |   10 ++++++++++
>>>  arch/arm/Kconfig.debug                 |    3 ++-
>>>  arch/arm/include/asm/mach/map.h        |    1 +
>>>  arch/arm/mach-versatile/Kconfig        |    3 ++-
>>>  arch/arm/mach-versatile/Makefile.boot  |    3 +++
>>>  arch/arm/mach-versatile/versatile_dt.c |    4 ++++
>>>  6 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>>
> 
