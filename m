From: achandran@mvista.com (Arun Chandran)
Date: Tue, 22 Jul 2014 18:55:49 +0530
Subject: Kexec on arm64
In-Reply-To: <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
Message-ID: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Jul 22, 2014 at 3:14 PM, Arun Chandran <achandran@mvista.com> wrote:
> On Thu, Jul 17, 2014 at 4:34 AM, Geoff Levand <geoff@infradead.org> wrote:
>> Hi Feng,
>>
>> On Wed, 2014-07-16 at 10:57 -0700, Feng Kan wrote:
>>> Just following up on the conversation. The cpu return address of 0 should work
>>> in your case. Since thats the _start of the bootloader, it will run
>>> some core init
>>> code and then put the core back in wfe.
>>
>> OK, I fixed up my code so that zero is valid cpu return address.  Arun,
>> could you try my latest I pushed out today?
>>
> Hi Geoff,
>
> Sorry for the late reply I was away.
>
> Yes I tried the new code.
> My dts file has the below change.
>
> ################
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi
> b/arch/arm64/boot/dts/apm-storm.dtsi
> index e0bf91d..b64e549 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -24,64 +24,64 @@
>                         compatible = "apm,potenza", "arm,armv8";
>                         reg = <0x0 0x000>;
>                         enable-method = "spin-table";
> -                       cpu-release-addr = <0x1 0x0000fff8>;
> -                       cpu-return-addr = <0x0 0x0> /* Updated by bootloader */
> +                       cpu-release-addr = <0x40 0x0000fff8>;
> +                       cpu-return-addr = <0x0 0x0>; /* Updated by bootloader */
>                 };
> #################
> All other cpu nodes have similar change.
>

I tried the same dtb with UP configuration. For UP kernel to compile
did the below modifications

##############################
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index 1ccedb4c..c6a2a7e 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -89,6 +89,7 @@ void __init cpu_read_bootcpu_ops(void)
        cpu_read_ops(dn, 0);
 }

+#if 0
 int __init cpu_ops_init(void)
 {
        int result = 0;
@@ -110,3 +111,4 @@ void cpu_ops_shutdown(void)
        if (cpu_operation_psci.shutdown)
                cpu_operation_psci.shutdown();
 }
+#endif
diff --git a/arch/arm64/kernel/machine_kexec.c
b/arch/arm64/kernel/machine_kexec.c
index fba6d50..c3cf246 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -609,7 +609,7 @@ void machine_kexec(struct kimage *image)
        flush_icache_range((unsigned long)reboot_code_buffer,
                (unsigned long)reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);

-       dump_cpus();
+       //dump_cpus();

        pr_info("Bye!\n");

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 31cba91..6bc85f78 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -83,7 +83,7 @@ void soft_restart(unsigned long addr)

        setup_restart();

-       smp_secondary_shutdown();
+       //smp_secondary_shutdown();

        /* Switch to the identity mapping */
        phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
@@ -130,7 +130,7 @@ void arch_cpu_idle_dead(void)
  */
 void machine_shutdown(void)
 {
-       smp_send_stop();
+       //smp_send_stop();
 }

 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c29dde1..14c339c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -73,7 +73,7 @@ ENTRY(cpu_reset)
        bic     x1, x1, #1
        msr     sctlr_el1, x1                   // disable the MMU
        isb
-       bl      secondary_shutdown
+#      bl      secondary_shutdown
        ret     x0
 ENDPROC(cpu_reset)
#####################

With the default target configuration "kexec -e" failed to execute
in UP scenario also.

But I had some luck when I did the same steps with L3 cache
disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
it has an L3 cache. Luckily I was able to disable it in u-boot.

With the L3 cache disabled configuration I am able to
do "kexec -e". Please see the log attached.

Feng,
I doubt kernel is unaware of the presence of L3 cache, this subsequently
makes "kexec -e" to fail.

Do you have any idea how to make the kernel to take control of L3 cache?

--Arun
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kexec_unipro_log
Type: application/octet-stream
Size: 9227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140722/8336d688/attachment-0001.obj>
