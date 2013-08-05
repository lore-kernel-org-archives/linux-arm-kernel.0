From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 05 Aug 2013 16:28:16 +0100
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
Message-ID: <51FFC490.5090907@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/13 13:12, Vijay Kilari wrote:
> Hi Will,
>
> I am trying to make kexec work on BE kernel on ARM VE TC2.
>
> First, to make KEXEC work with SMP on ARM VE TC2 board,
> I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>
> However, I made below changes to make KEXEC work for BE kernel.
> my question is: why delay is required for board to reboot with kexec?.
> Is it platform issue?.
>
> diff --git a/arch/arm/kernel /machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 4fb074c..0fb0ff9 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -123,6 +123,18 @@ void machine_crash_shutdown(struct pt_regs *regs)
>          printk(KERN_INFO "Loading crashdump kernel...\n");
>   }
>
> +static void byte_copy_relocate_kernel(void *dst, const void *src, int size)
> +{
> +        char *d, *s;
> +        d = (char *) dst;
> +        s = (char *) src;
> +        while (size>  0)
> +        {
> +                *d++ = *s++;
> +                size--;
> +        }
> +}
> +
>   /*
>    * Function pointer to optional machine-specific reinitialization
>    */
> @@ -155,9 +167,8 @@ void machine_kexec(struct kimage *image)
>
>
>          /* copy our kernel relocation code to the control code page */
> -       memcpy(reboot_code_buffer,
> -              relocate_new_kernel, relocate_new_kernel_size);
> -
> +       byte_copy_relocate_kernel(reboot_code_buffer,
> +              relocate_new_kernel, relocate_new_kernel_size);

you should be able to use memcpy() here, as it shouldn't change the
endian-ness of the data being copied.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
