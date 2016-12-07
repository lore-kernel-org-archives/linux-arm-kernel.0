From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 7 Dec 2016 23:57:43 +1000
Subject: [PATCH 0/4] arm/versatile: no-MMU support
In-Reply-To: <5847D4F8.1080108@arm.com>
References: <1481090912-29835-1-git-send-email-gerg@uclinux.org>
 <5847D4F8.1080108@arm.com>
Message-ID: <a2ab1e0c-d24b-ac8d-fb9a-4ae7271455b9@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 07/12/16 19:23, Vladimir Murzin wrote:
> Hi Greg,
>
> On 07/12/16 06:08, Greg Ungerer wrote:
>> Does the ARM Versatile machine have a maintainer?
>> I have CC'ed this patch set to those names reported by get_maintainer.
>> I had no feedback on the first posting of this series back in August.
>>
>> The following patches support configuring and building the versatile
>> machine with a no-MMU kernel.
>>
>> There is only a few minor changes required. It was previously possible
>> in older kernels to build for versatile with CONFIG_MMU disabled, but
>> the change to devicetree lost that capability. These changes make it
>> possible again.
>>
>> One patch is a fix for address translation (broken in older kernels too),
>> two are build problems when CONFIG_MMU is disabled, and the last is the
>> actuall configuration changes needed.
>>
>> The motivation for this is that the versatile machine is well supported
>> in qemu. And this provides an excellent platform for development and
>> testing no-MMU support on ARM in general. With these patches applied
>> it is possible to build and run a kernel with MMU disabled on qemu.
>
> I'm wondering if my "Allow NOMMU for MULTIPLATFORM" series [1] work for you?
>
> [1] https://www.spinics.net/lists/arm-kernel/msg546823.html

Sorry I hadn't seen these patches before.

Just tried them out. With CONFIG_EXPERT set I can select and
build for the Versatile machine with CONFIG_MMU not set. The
build is successful, but the resulting kernel doesn't boot.

I see that the resulting .config has CONFIG_PLAT_VERSATILE set
but not CONFIG_ARCH_VERSATILE. Is this intentional?

With CONFIG_ARCH_VERSATILE missing the build doesn't traverse
into arch/arm/mach-versatile, and you don't get any device tree
built.

Ultimately to produce a working kernel we will still need my
patch 01/04 ("ARM: versatile: support no-MMU mode addressing").
No surprise here, this was missing in older kernels too.

Regards
Greg


>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>>  arch/arm/Kconfig                       |   10 ++++++++++
>>  arch/arm/Kconfig.debug                 |    3 ++-
>>  arch/arm/include/asm/mach/map.h        |    1 +
>>  arch/arm/mach-versatile/Kconfig        |    3 ++-
>>  arch/arm/mach-versatile/Makefile.boot  |    3 +++
>>  arch/arm/mach-versatile/versatile_dt.c |    4 ++++
>>  6 files changed, 22 insertions(+), 2 deletions(-)
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
