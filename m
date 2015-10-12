From: yang.shi@linaro.org (Shi, Yang)
Date: Mon, 12 Oct 2015 10:38:25 -0700
Subject: Run armv7 32 bit userspace on aarch64
In-Reply-To: <561BED2C.8080008@linaro.org>
References: <5615A0E1.1050402@linaro.org> <56184079.1040905@linaro.org>
 <56185B98.2060400@linaro.org> <6978725.cJktLf4M1X@wuerfel>
 <561BED2C.8080008@linaro.org>
Message-ID: <561BF011.80205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 10:26 AM, Shi, Yang wrote:
> On 10/10/2015 2:25 PM, Arnd Bergmann wrote:
>> On Friday 09 October 2015 17:28:08 Shi, Yang wrote:
>>> On 10/9/2015 3:32 PM, Shi, Yang wrote:
>>>> On 10/8/2015 4:12 AM, Will Deacon wrote:
>>>>> On Wed, Oct 07, 2015 at 03:46:57PM -0700, Shi, Yang wrote:
>>>>>> I'm trying to run armv7 little endian userspace on qemu aarch64 with
>>>>>> 4.1.x
>>>>>> kernel. I was told by someone such usecase is valid and I have
>>>>>> CONFIG_COMPAT
>>>>>> enabled in my kernel.
>>>>>>
>>>>>> But, I ran into the below error. It looks the userspace
>>>>>> application is
>>>>>> trying to write a readonly page. I got the similar failure on arm vfp
>>>>>> with
>>>>>> Linaro images (4.1 kernel) too.
>>>>>>
>>>>>> Did anyone have tried it recently?
>>>>>
>>>>> -rc4 seems to be working fine with Debian Jessie armhf on my Juno
>>>>> boards.
>>>>>
>>>>> Do you have a good way of reproducing this with a mainline kernel?
>>>>
>>>> It seems a qemu's bug. I can get both ubuntu and openembedded userspace
>>>> bootup on my LS2085 board with 4.1 kernel.
>>>
>>> Some new findings pointed me to another direction.
>>>
>>> I just tried to build OE userspace with gcc 5.2 (default toolchain in OE
>>> now), it fails to boot up with the same error.
>>>
>>> Then I tried the below test on 4.1 kernel:
>>>
>>> Linaro OE userspace image (4.9 toolchain)       Failed
>>> My OE build with 4.9.3 toolchain                Success
>>> My OE build with 5.2 toolchain                  Failed
>>> Ubuntu image                                    Success
>>
>> Does your kernel have 64KB pages enabled? If it does, most 32-bit user
>> space
>> won't run, except when building it with relatively new toolchains.
>

BTW, it may be related to unaligned address.

init[1]: unhandled level 3 translation fault (11) at 0x43acfad3, esr 
0x92000047
pgd = ffff80007b8be000
[43acfad3] *pgd=00000000fb8c5003, *pud=00000000fb8c1003, 
*pmd=00000000fb8c2003, *pte=0000000000000000

The userspace is trying to write to 0x43acfad3, the permission is readonly.

Thanks,
Yang

> No, I just use the default 4KB pages, but is is using 48 bits VA. The
> below is my kernel config (kernel features section)
>
> #
> # Kernel Features
> #
>
> #
> # ARM errata workarounds via the alternatives framework
> #
> CONFIG_ARM64_ERRATUM_826319=y
> CONFIG_ARM64_ERRATUM_827319=y
> CONFIG_ARM64_ERRATUM_824069=y
> CONFIG_ARM64_ERRATUM_819472=y
> CONFIG_ARM64_ERRATUM_832075=y
> CONFIG_ARM64_ERRATUM_845719=y
> CONFIG_ARM64_ERRATUM_843419=y
> CONFIG_ARM64_4K_PAGES=y
> # CONFIG_ARM64_64K_PAGES is not set
> # CONFIG_ARM64_VA_BITS_39 is not set
> CONFIG_ARM64_VA_BITS_48=y
> CONFIG_ARM64_VA_BITS=48
> # CONFIG_CPU_BIG_ENDIAN is not set
> CONFIG_SMP=y
> # CONFIG_SCHED_MC is not set
> # CONFIG_SCHED_SMT is not set
> CONFIG_NR_CPUS=8
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_HZ=100
> CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_HAVE_ARCH_PFN_VALID=y
> CONFIG_HW_PERF_EVENTS=y
> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_NO_BOOTMEM=y
> # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
> CONFIG_PAGEFLAGS_EXTENDED=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_ZONE_DMA_FLAG=1
> CONFIG_BOUNCE=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> # CONFIG_CMA is not set
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> # CONFIG_ZSMALLOC is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_SECCOMP is not set
> # CONFIG_XEN is not set
> CONFIG_FORCE_MAX_ZONEORDER=11
> CONFIG_ARMV8_DEPRECATED=y
> CONFIG_SWP_EMULATION=y
> # CONFIG_CP15_BARRIER_EMULATION is not set
> # CONFIG_SETEND_EMULATION is not set
>
> #
> # Boot options
> #
> CONFIG_CMDLINE="console=ttyAMA0"
> # CONFIG_CMDLINE_FORCE is not set
> CONFIG_EFI_STUB=y
> CONFIG_EFI=y
> CONFIG_DMI=y
>
> #
> # Userspace binary formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_HAVE_AOUT is not set
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> CONFIG_COMPAT=y
> CONFIG_SYSVIPC_COMPAT=y
>
>
> And, I also checked my busybox build flags for both 4.9.3 and 5.2,
> actually, they are using the same flags:
>
> arm-linux-gnueabi-gcc  -march=armv7-a -marm  -mthumb-interwork
> -mfloat-abi=softfp
> --sysroot=/home/yshi/workspace/test-4.1/qemuarma9/bitbake_build/tmp/sysroots/qemuarma9
> -Wp,-MD,archival/libarchive/.filter_accept_all.o.d   -std=gnu99
> -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
> -D"BB_VER=KBUILD_STR(1.23.2)" -DBB_BT=AUTOCONF_TIMESTAMP  -Wall -Wshadow
> -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter
> -Wunused-function -Wunused-value -Wmissing-prototypes
> -Wmissing-declarations -Wno-format-security
> -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strlen
> -finline-limit=0 -fomit-frame-pointer -ffunction-sections
> -fdata-sections -fno-guess-branch-probability -funsigned-char
> -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1
> -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -Os
> -O2 -pipe -g  -O2 -pipe -g   -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(filter_accept_all)"
> -D"KBUILD_MODNAME=KBUILD_STR(filter_accept_all)" -c -o
> archival/libarchive/filter_accept_all.o
> archival/libarchive/filter_accept_all.c
>
>
> Thanks,
> Yang
>
>>
>> Try running with the default 4KB page size if that is the problem.
>>
>>     Arnd
>>
>
