From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Aug 2017 10:06:28 +0100
Subject: [PATCH 03/14] resource: add walk_system_ram_res_rev()
In-Reply-To: <20170824081811.19299-4-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-4-takahiro.akashi@linaro.org>
Message-ID: <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
>
> It will be used in kexec_file implementation on arm64.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6230064d7f95..9a212266299f 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -271,6 +271,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>                     int (*func)(u64, u64, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +                       int (*func)(u64, u64, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>                     void *arg, int (*func)(u64, u64, void *));
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9b5f04404152..1d6d734c75ac 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -23,6 +23,7 @@
>  #include <linux/pfn.h>
>  #include <linux/mm.h>
>  #include <linux/resource_ext.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>
>
> @@ -469,6 +470,53 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>         return ret;
>  }
>
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +                               int (*func)(u64, u64, void *))
> +{
> +       struct resource res, *rams;
> +       u64 orig_end;
> +       int count, i;
> +       int ret = -1;
> +
> +       count = 16; /* initial */
> +again:
> +       /* create a list */
> +       rams = vmalloc(sizeof(struct resource) * count);
> +       if (!rams)
> +               return ret;
> +
> +       res.start = start;
> +       res.end = end;
> +       res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +       orig_end = res.end;
> +       i = 0;
> +       while ((res.start < res.end) &&
> +               (!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> +               if (i >= count) {
> +                       /* unlikely but */
> +                       vfree(rams);
> +                       count += 16;

If the count is likely to be < 16, why are we using vmalloc() here?

> +                       goto again;
> +               }
> +
> +               rams[i].start = res.start;
> +               rams[i++].end = res.end;
> +
> +               res.start = res.end + 1;
> +               res.end = orig_end;
> +       }
> +
> +       /* go reverse */
> +       for (i--; i >= 0; i--) {
> +               ret = (*func)(rams[i].start, rams[i].end, arg);
> +               if (ret)
> +                       break;
> +       }
> +
> +       vfree(rams);
> +       return ret;
> +}
> +
>  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
>
>  /*
> --
> 2.14.1
>
