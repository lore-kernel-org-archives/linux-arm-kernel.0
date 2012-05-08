From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 8 May 2012 22:01:02 +1000
Subject: [uClinux-dev] Running linux with mmu disabled on arm (AT91).
In-Reply-To: <4FA8E331.1060705@fnac.net>
References: <4FA00040.8000207@fnac.net> <4FA8A5FE.3080709@snapgear.com>
 <4FA8E331.1060705@fnac.net>
Message-ID: <4FA90AFE.9080908@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 05/08/2012 07:11 PM, Paul Chavent wrote:
> Le 05/08/2012 06:50 AM, Greg Ungerer a ??crit :
>> On 02/05/12 01:24, Paul Chavent wrote:
[snip]
>>> (2) I used to run the module with a "classic system" based on linux + eglibc, and i needed only one toolchain (arm-xxx-linux-gnueabi) for the kernel and the userspace apps.
>>> I found that for the nommu case i wasn't able to build the kernel with the userspace toolchain.
>>> So I had to build 2 toolchain, based on binutils 2.22, gcc 4.7, uclibc 0.9.33.1 and linux 3.2.14 :
>>> - an arm-xxx-eabi toolchain for the kernel
>>> - an arm-xxx-uclinux-uclibceabi for the userspace apps
>>> Do you confirm that it is not possible to compile the kernel with arm-xxx-uclinux-uclibceabi ? Or, may i have misconfigured the toolchain (i join the toolchain build procedure) ?
>>
>> I build non-mmu ARM systems with the same toolchain. What was the failure condition
>> when building the kernel with the arm-yyy-uclinux-uclibceabi tool chain?
>
> When i build the kernel with the arm-yyy-uclinux-uclibceabi tool chain it builds without error. But the kernel don't display anything when booting (not even the "decompressing kernel" message).

Can you compare the disassembled output of the code in each case?


>>> (3) The arm-xxx-uclinux-uclibceabi with elf2flt seems to produce running bins only if it is build with the uClibc DOPIC not set.
>>> Is it required to disable DOPIC ?
>>> Moreover, i can't run bins produced with a arm-xxx-linux-uclibceabi toolchain and -Wl,-elf2flt (not uclinux one). Is it the expected behavior ?
>>
>> Is it actually producing a FLAT format binary?
>> Maybe it is silently ignoring the "-Wl,-elf2flt".
>
> Yes it produce flat binaries with the gotpic flag enabled...

I would suspect that the code generation for the uclinux configured case
may be slightly different. You would need to dig into gcc and see what
it does when the target is set as uclinux.


>>> (4) The elf2flt needs to be updated to be aware of the exidx section, and some reloc types. I join the patch i currently use.
>>
>> You shouldn't include a whole new elft2flt.ld for this. It is generated
>> (via autoconf) from the elf2flt.ld.in file. You should add your new
>> exidx section to that. If you want to generate a new patch with doing
>> it that way I can add it to the elf2flt CVS on uclinux.org.
>
> In the previous mail, i joined a patch with an arm specific ld script derived from the generic one.
> I added the missing (exidx) sections, but i didn't remove other specific sections. For example, It still contains "microblaze" comments, i'm not sure what we could remove...
> The patch would need some reviews.

Well, I am reviewing it :-)
What I am saying is that it isn't really useful putting the generated
arm-elf2flt.ld in the patch. Your changes for the linker script need
to go into elf2flt.ld.in. You don't remove anything from it, it is good
for all architectures supported by elf2flt.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
