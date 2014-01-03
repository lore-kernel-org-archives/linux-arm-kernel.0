From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Jan 2014 19:24:19 +0100
Subject: [PATCH] arm/smp: Make boot_secondary() static
In-Reply-To: <201401031804.34124.arnd@arndb.de>
References: <1388763959-27491-1-git-send-email-geert@linux-m68k.org>
 <201401031804.34124.arnd@arndb.de>
Message-ID: <CAMuHMdXoZJEgMXH0K1d5kDs+XSM_KMkigUq+mKYVQezdxZ929g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 6:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 03 January 2014, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> After becoming a mandatory function, boot_secondary() is no longer used
>> outside arch/arm/kernel/smp.c. Hence make it static.
>> The code is reshuffled a bit to avoid a forward declaration.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> How about taking it one step further by removing the function entirely?
> Like this:
>
> @@ -92,6 +92,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  {
>         int ret;
>
> +       if (!smp_ops.smp_boot_secondary)
> +               return -ENOSYS;
> +
>         /*
>          * We need to tell the secondary core where to find
>          * its stack and the page tables.
> @@ -111,7 +114,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>         /*
>          * Now bring the CPU into our world.
>          */
> -       ret = boot_secondary(cpu, idle);
> +       ret = smp_ops.smp_boot_secondary(cpu, idle);
>         if (ret == 0) {
>                 /*
>                  * CPU was successfully started, wait for it

Fine for me.

Do you want me to fold this into my patch, or will you apply this on top?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
