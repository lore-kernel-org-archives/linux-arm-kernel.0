From: james.morse@arm.com (James Morse)
Date: Mon, 02 Oct 2017 15:11:18 +0100
Subject: undefined instruction d5380001 (arm64 mrs emulation)
In-Reply-To: <20171002112433.GM3611@e103592.cambridge.arm.com>
References: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
 <20171002112433.GM3611@e103592.cambridge.arm.com>
Message-ID: <59D24906.4060104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matwey,

On 02/10/17 12:24, Dave Martin wrote:
> On Fri, Sep 29, 2017 at 10:23:54PM +0300, Matwey V. Kornilov wrote:
>> I am running 4.13.3 on rockchip 3328 platform(aarch64) with glibc 2.26
>> and see the following at booting:
>>
>> [   11.152061] modprobe[93]: undefined instruction: pc=0000ffff8ca48ff4
>> [   11.152707] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
>> [   11.154347] modprobe[94]: undefined instruction: pc=0000ffff94243ff4
>> [   11.154991] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
>> [   11.157070] modprobe[97]: undefined instruction: pc=0000ffff839a0ff4
>> [   11.157715] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
>> [   11.159265] modprobe[98]: undefined instruction: pc=0000ffffb0591ff4
>> [   11.159908] Code: d503201f 8a180320 92750001 365ffc20 (d5380001)
>>
>> As far as I understand d5380001 should be emulated in cpufeature.c but
>> it is not. What could be wrong here?
> 
> The whole sequence is
> 
>    0:   d503201f        nop
>    4:   8a180320        and     x0, x25, x24
>    8:   92750001        and     x1, x0, #0x800
>    c:   365ffc20        tbz     w0, #11, 0xffffffffffffff90
>   10:*  d5380001        mrs     x1, midr_el1            <-- trapping instruction

This looks the same as:
https://bugzilla.redhat.com/show_bug.cgi?id=1496209

[...]

> What should happen here is that the do_undefinstr() in
> arch/arm64/kernel/traps.c should call registered undef hooks until it
> finds one that accepts the faulting instruction.
> 
> So, either the cpufeatures undef hook is not getting called, or it is
> failing the instruction somewhere, possibly in
> cpufeatures.c:emulate_id_reg() or emulate_sys_reg().
> 
> 
> Can you add some trace to those functions to see what's happening?

I couldn't reproduce this with linux-stable's v4.13.3 defconfig on Seattle or Juno.

What distribution are you running? Could you also try [0] to see if this is
something specific to your version of modprobe?


Thanks,

James

[0] works for me:
---------------------%<---------------------
#include <stdio.h>
#include <sys/auxv.h>

#ifndef HWCAP_CPUID
#define HWCAP_CPUID (1 << 11)
#endif

int main(int argc, char **argv)
{
        register unsigned int midr asm ("r1") = 0;
        unsigned long hwcaps = getauxval(AT_HWCAP);

        if (!(hwcaps & HWCAP_CPUID)) {
                fprintf(stderr, "mrs emulation not supported\n");
                return 1;
        }

        asm("mrs %0, midr_el1" : "=r"(midr));

        fprintf(stderr, "mrs x1, midr_el1; x1=0x%x\n", midr);

        return 0;
}
---------------------%<---------------------
