From: achandran@mvista.com (Arun Chandran)
Date: Thu, 24 Jul 2014 18:19:20 +0530
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
Message-ID: <CAFdej02saQv=SMgV75LrB_5BMH+8DZL8MLdToq1rs577AbO-Vg@mail.gmail.com>
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

I don't have any error log for for this.
If I loop before jumping to relocate_new_kernel and break with
BDI I can see.

CPU#0>state
Core#0: halted 0x0000004000094230 External Debug Request

CPU#0>rd
GPR00: 000000000000003f 0000000034d5d918 0000004000000000 0000000000000004
GPR04: 000000000000001f 000000000000001b 0000000000000000 ffffffffffffffff
GPR08: 0000000000000014 ffffffffffffffff 0000000000000000 0000000000000002
GPR12: ffffffc000085030 aa0e03ed3600004a 9100218cf940018a ffffffffffffffff
GPR16: ffffffc0000cc00c 0000000000434260 0000007ffe514d80 00000043eadd2000
GPR20: ffffffc3eadd2000 ffffffc000cc5000 ffffffc3ea42bf88 00000003eadd2000
GPR24: ffffffc0004ada58 ffffffc0005b2e68 ffffffc0005b2e88 ffffffc0005b2ef0
GPR28: ffffffc000092000 ffffffc3f017bce0 ffffffc000085054 ffffffc3f017bce0

x0 contains a corrupted address in this case

If I do the same without dosabling Dcache
#######
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6bc85f78..61f95a2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -70,10 +70,10 @@ static void setup_restart(void)
        flush_cache_all();

        /* Turn D-cache off */
-       cpu_cache_off();
+//     cpu_cache_off();

        /* Push out any further dirty data, and ensure cache is empty */
-       flush_cache_all();
+//     flush_cache_all();
 }

 void soft_restart(unsigned long addr)
##########
I can see

CPU#0>state
Core#0: halted 0x0000004000094230 External Debug Request

CPU#0>
CPU#0>rd
GPR00: 00000043eae90000 0000000034d5d91c 0000004000000000 0000000000000004
GPR04: 000000000000001f 000000000000001b 0000000000000000 ffffffffffffffff
GPR08: 0000000000000014 ffffffffffffffff 0000000000000000 0000000000000002
GPR12: ffffffc000085028 aa0e03ed3600004a 9100218cf940018a ffffffffffffffff
GPR16: ffffffc0000cc00c 0000000000434260 0000007fe79f31e0 00000043eae90000
GPR20: ffffffc3eae90000 ffffffc000cc5000 ffffffc3ea42ef88 00000003eae90000
GPR24: ffffffc0004ada58 ffffffc0005b2e68 ffffffc0005b2e88 ffffffc0005b2ef0
GPR28: ffffffc000092000 ffffffc3ebad7ce0 ffffffc00008504c ffffffc3ebad7ce0
CPU#0>
CPU#0>go 0x00000043eae90000
CPU#0>
CPU#0>
CPU#0>h
    Core number       : 0
    Core state        : debug (AArch64 EL1)
    Debug entry cause : External Debug Request
    Current PC        : 0xffffffc000083200
    Current CPSR      : 0x600003c5 (EL1h)

In this case x0 contais the correct jump address; but kexeced
goes to " 0xffffffc000083200". It did not print anything at
console.

If you have any other experiments to find the root cause
please tell me I can do it.

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

I will confirm this by booting with L3 cache enabled, reboot to u-boot,
don't flush L3 from u-boot and again boot to linux.

--Arun
