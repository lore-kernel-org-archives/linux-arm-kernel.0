From: panand@redhat.com (Pratyush Anand)
Date: Mon, 01 Jun 2015 11:55:21 +0530
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <55664FD9.1090808@codeaurora.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org> <55653538.8020206@codeaurora.org>
 <2420285.dn5MbvMKXS@wuerfel> <55664FD9.1090808@codeaurora.org>
Message-ID: <556BFAD1.7010907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 28 May 2015 04:44 AM, Timur Tabi wrote:
> On 05/27/2015 11:39 AM, Arnd Bergmann wrote:
>> ACPI support has just been merged and is still experimental. You
>> should be able to boot your system by passing a DT blob at the
>> initial boot that matches your hardware. Can you try if that
>> makes kexec work?
>
> If I had an initial DT blob that matched by hardware, I wouldn't need
> ACPI support!  This is an ARM64 Server system.  There is no device tree
> for the hardware.  Everything is in ACPI.

So what error do you see when you execute kexec.

We had seen a failure with check_cpu_nodes(), when booting with ACPI 
without any DTB.

If you see the similar failure, then can you pl try following:

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7b219097dfff..8e085212d8a5 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -640,7 +640,7 @@ int arm64_load_other_segments(struct kexec_info *info,
         result =  check_cpu_nodes(&dtb_1, &dtb_2);

         if (result)
-               return result;
+               fprintf(stderr, "kexec: Warning: No device tree 
available.\n");

         /*
          * Put the DTB after the kernel with an alignment of 128 KiB, 
giving

~Pratyush
