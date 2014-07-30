From: achandran@mvista.com (Arun Chandran)
Date: Wed, 30 Jul 2014 12:31:40 +0530
Subject: Kexec on arm64
In-Reply-To: <20140729133557.GQ2576@leverpostej>
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
Message-ID: <CAFdej03wBf1JszKX-vUrFKxvk0kCAOAfZarWOzkwJ097Y0-SSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 7:05 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
>
>> The default code did not work.
>>
>> It is working with the change below
>>
>> ###############
>> diff --git a/arch/arm64/kernel/machine_kexec.c
>> b/arch/arm64/kernel/machine_kexec.c
>> index 5632473..7c5f859 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -147,12 +147,17 @@ static bool kexec_is_dtb_user(const dtb_t *dtb)
>>  /**
>>   * kexec_list_walk - Helper to walk the kimage page list.
>>   */
>> -
>> +static int kexec_kernel_size;
>> +#define IMG_SIZE_NONE  0
>> +#define KERN_SIZE_FLAG 1
>> +#define DTB_SIZE_FLAG  2
>>  static void kexec_list_walk(void *ctx, unsigned long kimage_head,
>>         void (*cb)(void *ctx, unsigned int flag, void *addr, void *dest))
>>  {
>>         void *dest;
>>         unsigned long *entry;
>> +       int imgsize_flag = IMG_SIZE_NONE;
>> +
>>
>>         for (entry = &kimage_head, dest = NULL; ; entry++) {
>>                 unsigned int flag = *entry & IND_FLAGS;
>> @@ -164,10 +169,18 @@ static void kexec_list_walk(void *ctx, unsigned
>> long kimage_head,
>>                         cb(ctx, flag, addr, NULL);
>>                         break;
>>                 case IND_DESTINATION:
>> +                       if (imgsize_flag == IMG_SIZE_NONE) {
>> +                               kexec_kernel_size = 0;
>> +                               imgsize_flag = KERN_SIZE_FLAG;
>> +                       } else if (imgsize_flag == KERN_SIZE_FLAG) {
>> +                               imgsize_flag = DTB_SIZE_FLAG;
>> +                       }
>>                         dest = addr;
>>                         cb(ctx, flag, addr, NULL);
>>                         break;
>>                 case IND_SOURCE:
>> +                       if (imgsize_flag == KERN_SIZE_FLAG)
>> +                               kexec_kernel_size++;
>>                         cb(ctx, flag, addr, dest);
>>                         dest += PAGE_SIZE;
>>                         break;
>> @@ -693,5 +706,20 @@ void machine_kexec(struct kimage *image)
>>
>>         kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
>>
>> +       /*
>> +        * Make sure virtual addresses of new kernel are flushed
>> +        * SZ_512K = TEXT_OFFSET
>
> TEXT_OFFSET is not guaranteed to be 512K. The TEXT_OFFSET area also
> shouldn't need to be flushed.
>
> Since c218bca74eea (arm64: Relax the kernel cache requirements for
> boot), the kernel will flush the cache for anything outside of the Image
> that it writes to before enabling the MMU and caches (e.g. the idmap and
> swapper page tables). Once caches are up we shouldn't care.
>
> Assuming that the existing kernel code is correct, the only region we
> should need to flush out to the PoC is the region from _text to _edata
> (i.e. just the contents of the Image).

I think we missed the dtb part. dtb is placed below the
kernel. We need to flush that also.

Geoff's new code manages that also. It is now
working for me.

--Arun
>
>> +        * kexec_kernel = kexec_kernel_size * PAGE_SIZE
>> +        * Don't know = (SZ_4M + SZ_1M)
>> +        * SZ_4M = not working
>> +        * SZ_6M = working
>> +        * SZ_8M = working
>> +        *
>> +        * so chose SZ_4M + SZ_1M; Don't know why this is required
>> +        * BSS, stack ??
>> +        *
>> +        */
>> +       __flush_dcache_area((void *)PAGE_OFFSET, SZ_512K +
>> (kexec_kernel_size * PAGE_SIZE) + SZ_4M + SZ_1M);
>> +
>>         soft_restart(reboot_code_buffer_phys);
>>  }
>
> How big exactly is the kernel Image you're trying to kexec?
>
> Mark.
