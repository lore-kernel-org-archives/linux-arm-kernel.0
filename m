From: achandran@mvista.com (Arun Chandran)
Date: Fri, 25 Jul 2014 15:56:46 +0530
Subject: Kexec on arm64
In-Reply-To: <20140724093603.GC4079@leverpostej>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
Message-ID: <CAFdej02Ty82_0BHFqizbs2DWr5mC5KWjq8CdcPemsayGM9pjjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 3:06 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jul 24, 2014 at 01:38:07AM +0100, Geoff Levand wrote:
>> Hi Arun,
>>
>> On Tue, 2014-07-22 at 18:55 +0530, Arun Chandran wrote:
>>
>> > I tried the same dtb with UP configuration. For UP kernel to compile
>> > did the below modifications
>>
>> I'll test and fixup the kexec UP build in the next few days.
>>
>> ...
>>
>> > With the default target configuration "kexec -e" failed to execute
>> > in UP scenario also.
>
> It would be helpful to know _how_ it failed. Do you have any log output?
>
>> >
>> > But I had some luck when I did the same steps with L3 cache
>> > disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
>> > it has an L3 cache. Luckily I was able to disable it in u-boot.
>> >
>> > With the L3 cache disabled configuration I am able to
>> > do "kexec -e". Please see the log attached.
>
> Hmm. We don't expect the kernel to do any L3 management. It seems that
> memory subsystems with L3 caches respecting cache maintenance by VA are
> going to become relatively common, and we expect to handle them all by
> performing maintenance by VA. See commit c218bca74eea (arm64: Relax the
> kernel cache requirements for boot) for what we do at boot time.
>
>>
>> All memory management for the main cpu is done by the arch code.  Kexec
>> and cpu hot plug only work with the secondary cpus, so the problem would
>> be in the arch memory code, either in setup_restart() for shutdown, or
>> in the startup code.
>
> It's possible that soft_restart and setup_restart are a little dodgy, as
> they also rely on the compiler being smart and not touching the stack
> after setup_restart().
>
Could you please explain why this is required?


This is my disassembled output of  soft_restart()
With the latest code from
https://git.linaro.org/people/geoff.levand/linux-kexec.git

ffffffc000085014 <soft_restart>:
ffffffc000085014:       a9be7bfd        stp     x29, x30, [sp,#-32]!
ffffffc000085018:       910003fd        mov     x29, sp
ffffffc00008501c:       f9000fa0        str     x0, [x29,#24]
ffffffc000085020:       94003c49        bl      ffffffc000094144
<setup_mm_for_reboot>
ffffffc000085024:       94003a6b        bl      ffffffc0000939d0
<flush_cache_all>
ffffffc000085028:       94003cde        bl      ffffffc0000943a0 <cpu_cache_off>
ffffffc00008502c:       94003a69        bl      ffffffc0000939d0
<flush_cache_all>
ffffffc000085030:       90006201        adrp    x1, ffffffc000cc5000
<reset_devices>
ffffffc000085034:       f9400fa0        ldr     x0, [x29,#24]
ffffffc000085038:       f940fc22        ldr     x2, [x1,#504]
ffffffc00008503c:       f0000061        adrp    x1, ffffffc000094000
<arch_pick_mmap_layout+0x150>
ffffffc000085040:       910f0021        add     x1, x1, #0x3c0
ffffffc000085044:       8b010041        add     x1, x2, x1
ffffffc000085048:       d2c00802        mov     x2, #0x4000000000
         // #274877906944
ffffffc00008504c:       8b020021        add     x1, x1, x2
ffffffc000085050:       d63f0020        blr     x1
ffffffc000085054:       f0002940        adrp    x0, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc000085058:       f0002941        adrp    x1, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc00008505c:       90002143        adrp    x3, ffffffc0004ad000
<__start_rodata>
ffffffc000085060:       91128000        add     x0, x0, #0x4a0
ffffffc000085064:       913de021        add     x1, x1, #0xf78
ffffffc000085068:       52800c22        mov     w2, #0x61
         // #97
ffffffc00008506c:       91072063        add     x3, x3, #0x1c8
ffffffc000085070:       941071d0        bl      ffffffc0004a17b0 <printk>
ffffffc000085074:       f0002940        adrp    x0, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc000085078:       91134000        add     x0, x0, #0x4d0
ffffffc00008507c:       9410712c        bl      ffffffc0004a152c <panic>

If I single step the code,

This is how my stack looks like @ffffffc00008501c
CPU#0>mdd 0xffffffc3eb83fcf0
ffffffc3_eb83fcf0 : ffffffc3eb83fd10  ........
ffffffc3_eb83fcf8 : ffffffc000092778  ......'x
ffffffc3_eb83fd00 : ffffffc000cc9f70  .......p
ffffffc3_eb83fd08 : 00000043eae32000  ...C.. .
ffffffc3_eb83fd10 : ffffffc3eb83fd70  .......p
ffffffc3_eb83fd18 : ffffffc0000fc018  ........
ffffffc3_eb83fd20 : ffffffc000c95000  ......P.
ffffffc3_eb83fd28 : 0000000000000000  ........
ffffffc3_eb83fd30 : ffffffc000cd06a0  ........
ffffffc3_eb83fd38 : 0000000000000000  ........
ffffffc3_eb83fd40 : 0000000080000000  ........
ffffffc3_eb83fd48 : 0000000000000015  ........
ffffffc3_eb83fd50 : 0000000000000115  ........
ffffffc3_eb83fd58 : 000000000000008e  ........
ffffffc3_eb83fd60 : ffffffc000c8b000  ........
ffffffc3_eb83fd68 : ffffffc3eb83c000  ........

And this is how it looks like @ffffffc000085030
CPU#0>mdd 0xffffffc3eb83fcf0
ffffffc3_eb83fcf0 : 0000000000000115  ........
ffffffc3_eb83fcf8 : 000000000000003f  .......?
ffffffc3_eb83fd00 : ffffffc3eb83fd30  .......0
ffffffc3_eb83fd08 : ffffffc000120360  .......`
ffffffc3_eb83fd10 : 0000000000000002  ........
ffffffc3_eb83fd18 : ffffffbcedb611c0  ........
ffffffc3_eb83fd20 : ffffffbcedb611c0  ........
ffffffc3_eb83fd28 : ffffffc3eae08000  ........
ffffffc3_eb83fd30 : ffffffc3000200d0  ........
ffffffc3_eb83fd38 : ffffffc000120708  ........
ffffffc3_eb83fd40 : 0000000000000000  ........
ffffffc3_eb83fd48 : 72a00040528f8fe0  r.. at R...
ffffffc3_eb83fd50 : 540002a16a00003f  T...j..?
ffffffc3_eb83fd58 : 3627fe60f8538260  6'.`.S.`
ffffffc3_eb83fd60 : 97fff80daa1303e0  ........
ffffffc3_eb83fd68 : 97fc01ffaa1403e0  ........

It is clearly getting corrupted.

Now with keeping caches on
######
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 786daa6..6ff3d9f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -76,10 +76,10 @@ static void setup_restart(void)
        flush_cache_all();

        /* Turn D-cache off */
-       cpu_cache_off();
+       //cpu_cache_off();

        /* Push out any further dirty data, and ensure cache is empty */
-       flush_cache_all();
+       //flush_cache_all();
 }

 void soft_restart(unsigned long addr)
#######

ffffffc000085014 <soft_restart>:
ffffffc000085014:       a9be7bfd        stp     x29, x30, [sp,#-32]!
ffffffc000085018:       910003fd        mov     x29, sp
ffffffc00008501c:       f9000fa0        str     x0, [x29,#24]
ffffffc000085020:       94003c49        bl      ffffffc000094144
<setup_mm_for_reboot>
ffffffc000085024:       94003a6b        bl      ffffffc0000939d0
<flush_cache_all>
ffffffc000085028:       90006201        adrp    x1, ffffffc000cc5000
<reset_devices>
ffffffc00008502c:       f9400fa0        ldr     x0, [x29,#24]
ffffffc000085030:       f940fc22        ldr     x2, [x1,#504]
ffffffc000085034:       f0000061        adrp    x1, ffffffc000094000
<arch_pick_mmap_layout+0x150>
ffffffc000085038:       910f0021        add     x1, x1, #0x3c0
ffffffc00008503c:       8b010041        add     x1, x2, x1
ffffffc000085040:       d2c00802        mov     x2, #0x4000000000
         // #274877906944
ffffffc000085044:       8b020021        add     x1, x1, x2
ffffffc000085048:       d63f0020        blr     x1
ffffffc00008504c:       f0002940        adrp    x0, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc000085050:       f0002941        adrp    x1, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc000085054:       90002143        adrp    x3, ffffffc0004ad000
<__start_rodata>
ffffffc000085058:       91128000        add     x0, x0, #0x4a0
ffffffc00008505c:       913de021        add     x1, x1, #0xf78
ffffffc000085060:       52800c22        mov     w2, #0x61
         // #97
ffffffc000085064:       91072063        add     x3, x3, #0x1c8
ffffffc000085068:       941071d2        bl      ffffffc0004a17b0 <printk>
ffffffc00008506c:       f0002940        adrp    x0, ffffffc0005b0000
<kallsyms_token_table+0x200>
ffffffc000085070:       91134000        add     x0, x0, #0x4d0
ffffffc000085074:       9410712e        bl      ffffffc0004a152c <panic>

Now my stack @ffffffc00008501c and @ffffffc000085028 are same.
It is

CPU#0>mdd 0xffffffc3eae27cf0
ffffffc3_eae27cf0 : ffffffc3eae27d10  ......}.
ffffffc3_eae27cf8 : ffffffc000092778  ......'x
ffffffc3_eae27d00 : ffffffc000cc9f70  .......p
ffffffc3_eae27d08 : 00000043f0171000  ...C....
ffffffc3_eae27d10 : ffffffc3eae27d70  ......}p
ffffffc3_eae27d18 : ffffffc0000fc018  ........
ffffffc3_eae27d20 : ffffffc000c95000  ......P.
ffffffc3_eae27d28 : 0000000000000000  ........
ffffffc3_eae27d30 : ffffffc000cd06a0  ........
ffffffc3_eae27d38 : 0000000000000000  ........
ffffffc3_eae27d40 : 0000000080000000  ........
ffffffc3_eae27d48 : 0000000000000015  ........
ffffffc3_eae27d50 : 0000000000000115  ........
ffffffc3_eae27d58 : 000000000000008e  ........
ffffffc3_eae27d60 : ffffffc000c8b000  ........
ffffffc3_eae27d68 : ffffffc3eae24000  ...... at .

--Arun
