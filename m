From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Jun 2016 17:01:35 +0200
Subject: Boot failure on emev2/kzm9d (was: Re: [PATCH v2 11/11] mm/slab:
 lockless decision to grow cache)
In-Reply-To: <20160622005208.GB25106@js1304-P5Q-DELUXE>
References: <20160614062456.GB13753@js1304-P5Q-DELUXE>
 <CAMuHMdWipquaVFKYLd=2KhTx6djwH7NXpzL-RjtikCE=G8KTbA@mail.gmail.com>
 <20160614081125.GA17700@js1304-P5Q-DELUXE>
 <CAMuHMdXc=XN4z96vr_FNcUzFb0203ovHgcfD95Q5LPebr1z0ZQ@mail.gmail.com>
 <20160615022325.GA19863@js1304-P5Q-DELUXE>
 <CAMuHMdVi-F0n-GjnUqEEd58UcWxw67g8ZJO838fvo31Ttr5E1g@mail.gmail.com>
 <20160620063942.GA13747@js1304-P5Q-DELUXE>
 <20160620131254.GO3923@linux.vnet.ibm.com>
 <20160621064302.GA20635@js1304-P5Q-DELUXE>
 <20160621125406.GF3923@linux.vnet.ibm.com>
 <20160622005208.GB25106@js1304-P5Q-DELUXE>
Message-ID: <CAMuHMdW-wSxASozhmPh0b+9UJFFVbYHqTqH5e9P1oO7T59YE7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 2:52 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> Could you try below patch to check who causes the hang?
>
> And, if sysalt-t works when hang, could you get sysalt-t output? I haven't
> used it before but Paul could find some culprit on it. :)
>
> Thanks.
>
>
> ----->8-----
> diff --git a/mm/slab.c b/mm/slab.c
> index 763096a..9652d38 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -964,8 +964,13 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
>          * guaranteed to be valid until irq is re-enabled, because it will be
>          * freed after synchronize_sched().
>          */
> -       if (force_change)
> +       if (force_change) {
> +               if (num_online_cpus() > 1)
> +                       dump_stack();
>                 synchronize_sched();
> +               if (num_online_cpus() > 1)
> +                       dump_stack();
> +       }

I've only added the first one, as I would never see the second one. All of
this happens before the serial console is activated, earlycon is not supported,
and I only have remote access.

Brought up 2 CPUs
SMP: Total of 2 processors activated (2132.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.7.0-rc4-kzm9d-00404-g4a235e6dde4404dd-dirty #89
Hardware name: Generic Emma Mobile EV2 (Flattened Device Tree)
[<c010de68>] (unwind_backtrace) from [<c010a658>] (show_stack+0x10/0x14)
[<c010a658>] (show_stack) from [<c02b5cf8>] (dump_stack+0x7c/0x9c)
[<c02b5cf8>] (dump_stack) from [<c01cfa4c>] (setup_kmem_cache_node+0x140/0x170)
[<c01cfa4c>] (setup_kmem_cache_node) from [<c01cfe3c>]
(__do_tune_cpucache+0xf4/0x114)
[<c01cfe3c>] (__do_tune_cpucache) from [<c01cff54>] (enable_cpucache+0xf8/0x148)
[<c01cff54>] (enable_cpucache) from [<c01d0190>]
(__kmem_cache_create+0x1a8/0x1d0)
[<c01d0190>] (__kmem_cache_create) from [<c01b32d0>]
(kmem_cache_create+0xbc/0x190)
[<c01b32d0>] (kmem_cache_create) from [<c070d968>] (shmem_init+0x34/0xb0)
[<c070d968>] (shmem_init) from [<c0700cc8>] (kernel_init_freeable+0x98/0x1ec)
[<c0700cc8>] (kernel_init_freeable) from [<c049fdbc>] (kernel_init+0x8/0x110)
[<c049fdbc>] (kernel_init) from [<c0106cb8>] (ret_from_fork+0x14/0x3c)
devtmpfs: initialized

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
