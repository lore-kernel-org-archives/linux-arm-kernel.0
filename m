From: geoff@infradead.org (Geoff Levand)
Date: Thu, 07 Aug 2014 13:07:38 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke> <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej> <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej> <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <1407172869.8971.54.camel@smoke>
 <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
Message-ID: <1407442058.8971.106.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Wed, 2014-08-06 at 19:24 +0530, Arun Chandran wrote:

> I have managed to run this test till 72 times with the
> below changes.
> 
> ############################
> diff --git a/arch/arm64/kernel/machine_kexec.c
> b/arch/arm64/kernel/machine_kexec.c
> index 363a246..7de11ee 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -623,7 +623,6 @@ static void kexec_list_flush_cb(void *ctx ,
> unsigned int flag,
>   break;
>   case IND_SOURCE:
>   __flush_dcache_area(addr, PAGE_SIZE);
> - __flush_dcache_area(dest, PAGE_SIZE);
>   break;
>   default:
>   break;
> @@ -641,6 +640,8 @@ void machine_kexec(struct kimage *image)
>   phys_addr_t reboot_code_buffer_phys;
>   void *reboot_code_buffer;
>   struct kexec_ctx *ctx = kexec_image_to_ctx(image);
> + unsigned long start, end;
> + int i;
> 
>   BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);
>   BUG_ON(num_online_cpus() > 1);
> @@ -698,6 +699,20 @@ void machine_kexec(struct kimage *image)
> 
>   kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
> 
> + start = image->segment[0].mem;
> + end = image->segment[0].mem + image->segment[0].memsz;
> + for (i = 0; i < image->nr_segments; i++) {
> + if (image->segment[i].mem > end)
> + end = image->segment[i].mem + image->segment[i].memsz;
> + }
> +
> + start = (unsigned long)phys_to_virt(start);
> + end = (unsigned long)phys_to_virt(end);
> + pr_info("flushing from %lx to %lx size = %lx\n", start, end, end - start);
> + __flush_dcache_area((void *)start, end - start);
> + //flush_icache_range(start, end);
> + //mdelay(10);
> +
>   soft_restart(reboot_code_buffer_phys);
>  }

Doing the flush in kexec_list_flush_cb() is almost the same
as using the image->segment to flush.  Did you see a
difference on your system?

> diff --git a/arch/arm64/kernel/relocate_kernel.S
> b/arch/arm64/kernel/relocate_kernel.S
> index 4b077e1..a49549e 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S

I think these changes are good.  I'll add them in.

-Geoff
