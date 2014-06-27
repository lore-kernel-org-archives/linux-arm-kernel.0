From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Jun 2014 11:41:46 +0200
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140627085705.GC32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal>
 <20140627085705.GC32514@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9NfGT8r8FSYzsuP70r1BRD_pdJw7AZHkc4qLt2_SwanA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2014 10:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Jun 27, 2014 at 10:51:27AM +0200, Jan Glauber wrote:
>> On Sun, Jun 22, 2014 at 10:11:49PM -0500, Nathan Lynch wrote:
>> > Provide fast userspace implementations of gettimeofday and
>> > clock_gettime on systems that implement the generic timers extension
>> > defined in ARMv7.  This follows the example of arm64 in conception but
>> > significantly differs in some aspects of the implementation (C vs
>> > assembly, mainly).
>>
>> Hi Nathan,
>>
>> applying your patches I get the following compile error under Ubuntu 12.04:
>>
>>   CC      arch/arm/kernel/vdso.o
>>   LDS     arch/arm/kernel/vdso/vdso.lds
>>   CC      arch/arm/kernel/vdso/vgettimeofday.o
>>   AS      arch/arm/kernel/vdso/datapage.o
>>   VDSOL   arch/arm/kernel/vdso/vdso.so.raw
>>   HOSTCC  arch/arm/kernel/vdso/vdsomunge
>> arch/arm/kernel/vdso/vdsomunge.c: In function ?main?:
>> arch/arm/kernel/vdso/vdsomunge.c:152:16: error: ?EF_ARM_ABI_FLOAT_HARD? undeclared (first use in this function)
>> arch/arm/kernel/vdso/vdsomunge.c:152:16: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/kernel/vdso/vdsomunge.c:156:34: error: ?EF_ARM_ABI_FLOAT_SOFT? undeclared (first use in this function)
>> make[2]: *** [arch/arm/kernel/vdso/vdsomunge] Error 1
>> make[1]: *** [arch/arm/kernel/vdso] Error 2
>> make: *** [arch/arm/kernel] Error 2
>>
>> Looks like the libc dev is too old (EF_ARM_ABI_FLOAT_* not in
>> /usr/include/elf.h). On a more recent Ubuntu it compiles fine.
>> Not sure how to solve this, maybe disable vdso if the libc is too old?
>

It appears that the EF_ARM_ABI_FLOAT_[SOFT|HARD] defines are just renames of

#define EF_ARM_SOFT_FLOAT       0x200
#define EF_ARM_VFP_FLOAT        0x400

so perhaps use those instead?

> This is what really concerns me about the VDSO.  It adds an additional
> dependence on the C library in order to build the kernel.  What if you
> don't have a C library in your cross-build setup (I don't.)
>

This is a host tool, so this is about the host libc not the target libc.

-- 
Ard.


> Until that is solved, the VDSO support is not going in, as it will
> effectively render the kernel unbuildable for me.
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
