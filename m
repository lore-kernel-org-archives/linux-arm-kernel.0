From: achandran@mvista.com (Arun Chandran)
Date: Wed, 6 Aug 2014 19:24:29 +0530
Subject: Kexec on arm64
In-Reply-To: <1407172869.8971.54.camel@smoke>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <1407172869.8971.54.camel@smoke>
Message-ID: <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 4, 2014 at 10:51 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Mon, 2014-08-04 at 15:46 +0530, Arun Chandran wrote:
>> The latest kexec code is working fine in LE/BE mode in UP configuration.
>>
>> I had to change kexec-tools code a bit to make sure that "kexec -l"
>> is not putting dtb at an area where kernel is building its initial page
>> tables.
>
> OK, I'll add in code to handle this.
>
>> Now before trying SMP configuration I want to know whether the below "kexec -e"
>> scenarios are valid(required)?
>>
>> 1st stage                                  |               2nd stage
>> ---------------------------------------------------------------------------------------------
>> LE UP                                      |               BE UP
>> LE UP                                      |               BE SMP
>> LE UP                                      |               LE SMP
>> LE SMP                                   |               LE UP
>> LE SMP                                   |               BE UP
>> LE SMP                                   |               BE SMP
>
I am testing "kexec -e" with the script below(it will either
reboot the board to BE or LE mode randomly).

This test is done without L3 cache. With L3 I have more troubles.
I think it is best to fix the code without L3 then move
to testing with L3. That fix may solve the problem with L3

###############################
:~$ cat /etc/init.d/S50reboot
#!/bin/sh

sleep 5
i=$RANDOM
j=$(( $i % 2))

if [ $j -eq 0 ] ; then
        mount /dev/mmcblk0p1 /mnt

        count=`cat /mnt/cnt`
        echo "KEXEC rebootng to BE count = $count"
        echo $RANDOM > /mnt/"$count""_BE"

        count=$(( $count + 1 ))
        echo "$count">/mnt/cnt

        kexec -l /mnt/vmlinux_BE.strip
--command-line="console=ttyS0,115200 earlyprintk=uart8
250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=2M"
        umount /mnt
        kexec -e
else
        mount /dev/mmcblk0p1 /mnt

        count=`cat /mnt/cnt`
        echo "KEXEC rebooting to LE count = $count"
        echo $RANDOM > /mnt/"$count""_LE"

        count=$(( $count + 1 ))
        echo "$count">/mnt/cnt

        kexec -l /mnt/vmlinux_LE.strip
--command-line="console=ttyS0,115200 earlyprintk=uart8
250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=2M"
        umount /mnt
        kexec -e
fi

exit $?
#############################

I have managed to run this test till 72 times with the
below changes.

############################
diff --git a/arch/arm64/kernel/machine_kexec.c
b/arch/arm64/kernel/machine_kexec.c
index 363a246..7de11ee 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -623,7 +623,6 @@ static void kexec_list_flush_cb(void *ctx ,
unsigned int flag,
  break;
  case IND_SOURCE:
  __flush_dcache_area(addr, PAGE_SIZE);
- __flush_dcache_area(dest, PAGE_SIZE);
  break;
  default:
  break;
@@ -641,6 +640,8 @@ void machine_kexec(struct kimage *image)
  phys_addr_t reboot_code_buffer_phys;
  void *reboot_code_buffer;
  struct kexec_ctx *ctx = kexec_image_to_ctx(image);
+ unsigned long start, end;
+ int i;

  BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);
  BUG_ON(num_online_cpus() > 1);
@@ -698,6 +699,20 @@ void machine_kexec(struct kimage *image)

  kexec_list_walk(NULL, image->head, kexec_list_flush_cb);

+ start = image->segment[0].mem;
+ end = image->segment[0].mem + image->segment[0].memsz;
+ for (i = 0; i < image->nr_segments; i++) {
+ if (image->segment[i].mem > end)
+ end = image->segment[i].mem + image->segment[i].memsz;
+ }
+
+ start = (unsigned long)phys_to_virt(start);
+ end = (unsigned long)phys_to_virt(end);
+ pr_info("flushing from %lx to %lx size = %lx\n", start, end, end - start);
+ __flush_dcache_area((void *)start, end - start);
+ //flush_icache_range(start, end);
+ //mdelay(10);
+
  soft_restart(reboot_code_buffer_phys);
 }

diff --git a/arch/arm64/kernel/relocate_kernel.S
b/arch/arm64/kernel/relocate_kernel.S
index 4b077e1..a49549e 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -61,13 +61,13 @@ relocate_new_kernel:
  mov x20, x13
  mov x21, x14

- prfm pldl1strm, [x21, #64]
+ /*prfm pldl1strm, [x21, #64] */
 1: ldp x22, x23, [x21]
  ldp x24, x25, [x21, #16]
  ldp x26, x27, [x21, #32]
  ldp x28, x29, [x21, #48]
  add x21, x21, #64
- prfm pldl1strm, [x21, #64]
+ /*prfm pldl1strm, [x21, #64]*/
  stnp x22, x23, [x20]
  stnp x24, x25, [x20, #16]
  stnp x26, x27, [x20, #32]
@@ -115,6 +115,8 @@ relocate_new_kernel:
  mov x3, xzr

  ldr x4, kexec_kimage_start
+ dsb sy
+ isb
  br x4

 .align 3
arun at arun-OptiPlex-9010:~/work/aarch64-kernel/linux-kexec_LE$
###########################

Out of this 72 times it booted 34 LE and 38 BE. It failed
from switching from BE to LE.

Mark,
Do you have any pointers to find the problem?

--Arun
