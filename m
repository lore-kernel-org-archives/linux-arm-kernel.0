From: paul.chavent@fnac.net (Paul Chavent)
Date: Tue, 08 May 2012 11:11:13 +0200
Subject: [uClinux-dev] Running linux with mmu disabled on arm (AT91).
In-Reply-To: <4FA8A5FE.3080709@snapgear.com>
References: <4FA00040.8000207@fnac.net> <4FA8A5FE.3080709@snapgear.com>
Message-ID: <4FA8E331.1060705@fnac.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg

Le 05/08/2012 06:50 AM, Greg Ungerer a ?crit :
> Hi Paul,
>
> On 02/05/12 01:24, Paul Chavent wrote:
>> I'd like to try linux on an AT91SAM9G20 (i have a linuxstamp board), with MMU disabled (the Hyok-Sung Choi& Hee-Chul Yun paper demonstrate that it could be possible).
>>
>> All the code seems to be present in the kernel...
>> So i would like to share my experience.
>>
>> (1) I had to make two little changes in the kernel code :
>> - I'm not able to change the REMAP_VECTOR_TO_DRAM. I have submitted the problem to the kbuild mailing list (http://www.spinics.net/lists/linux-kbuild/msg06153.html).
>
> Odd. Is it because DRAM_BASE is a numerical value?
>
>
>> - The soc_detect code that init the at91_soc_initdata structure is never called. Later this structure is used unitialized.
>> I'm currently using the joined patch as a workaround. Someone can review it please ?
>
> It looks ok to me.
>
>
>> (2) I used to run the module with a "classic system" based on linux + eglibc, and i needed only one toolchain (arm-xxx-linux-gnueabi) for the kernel and the userspace apps.
>> I found that for the nommu case i wasn't able to build the kernel with the userspace toolchain.
>> So I had to build 2 toolchain, based on binutils 2.22, gcc 4.7, uclibc 0.9.33.1 and linux 3.2.14 :
>> - an arm-xxx-eabi toolchain for the kernel
>> - an arm-xxx-uclinux-uclibceabi for the userspace apps
>> Do you confirm that it is not possible to compile the kernel with arm-xxx-uclinux-uclibceabi ? Or, may i have misconfigured the toolchain (i join the toolchain build procedure) ?
>
> I build non-mmu ARM systems with the same toolchain. What was the failure condition
> when building the kernel with the arm-yyy-uclinux-uclibceabi tool chain?

When i build the kernel with the arm-yyy-uclinux-uclibceabi tool chain it builds without error. But the kernel don't display anything when booting (not even the "decompressing kernel" message).

>
>
>> (3) The arm-xxx-uclinux-uclibceabi with elf2flt seems to produce running bins only if it is build with the uClibc DOPIC not set.
>> Is it required to disable DOPIC ?
>> Moreover, i can't run bins produced with a arm-xxx-linux-uclibceabi toolchain and -Wl,-elf2flt (not uclinux one). Is it the expected behavior ?
>
> Is it actually producing a FLAT format binary?
> Maybe it is silently ignoring the "-Wl,-elf2flt".

Yes it produce flat binaries with the gotpic flag enabled...

>
>
>> (4) The elf2flt needs to be updated to be aware of the exidx section, and some reloc types. I join the patch i currently use.
>
> You shouldn't include a whole new elft2flt.ld for this. It is generated
> (via autoconf) from the elf2flt.ld.in file. You should add your new
> exidx section to that. If you want to generate a new patch with doing
> it that way I can add it to the elf2flt CVS on uclinux.org.

In the previous mail, i joined a patch with an arm specific ld script derived from the generic one.
I added the missing (exidx) sections, but i didn't remove other specific sections. For example, It still contains "microblaze" comments, i'm not sure what we could remove...
The patch would need some reviews.

>
>
>> Given these observations, i've been able to run a linux with an hello world as the /init process.
>>
>> My next tests will be to run threaded programs, c++ programs, then busybox.
>
> A good start at least.
>
> Regards
> Greg

Thanks.
Paul.
