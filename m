From: veli-pekka.peltola@bluegiga.com (Veli-Pekka Peltola)
Date: Mon, 13 Aug 2012 13:44:11 +0300
Subject: Problem: CONFIG_KALLSYMS is not set + kernel/module.c
In-Reply-To: <50155655.9070002@gmail.com>
References: <50155655.9070002@gmail.com>
Message-ID: <5028DA7B.4010901@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 07/29/2012 06:27 PM, Mark Hinds wrote:
>
> In linux-3.2.xx I've been getting kernel dumps when I modprobe some
> modules with CONFIG_KALLSYMS diabled - nls_base.ko for example.
> I traced the problem to kernel/module.c, line 2607 or there about.
>
> Starting with:
> ptr = module_alloc_update_bounds(mod->init_size);
>
> If mod->init_size == 0 then foobar happens. I assume that there is
> no init section in some modules when CONFIG_KALLSYMS is disabled.

A while ago I hit the same problem I guess. Could you check out if my 
fix[1] does the job for you?

--
Veli-Pekka Peltola

[1] https://lkml.org/lkml/2012/3/7/193

> Here is my fix:
>
> Index: kernel/module.c
> ===================================================================
> --- kernel/module.c    (.../linux-3.2.24/kernel/module.c)    (revision
> 9084)
> +++ kernel/module.c    (.../linux-3.2.24-ces/kernel/module.c)
> (working copy)
> @@ -2604,20 +2604,24 @@
>       memset(ptr, 0, mod->core_size);
>       mod->module_core = ptr;
>
> -    ptr = module_alloc_update_bounds(mod->init_size);
> -    /*
> -     * The pointer to this block is stored in the module structure
> -     * which is inside the block. This block doesn't need to be
> -     * scanned as it contains data and code that will be freed
> -     * after the module is initialized.
> -     */
> -    kmemleak_ignore(ptr);
> -    if (!ptr && mod->init_size) {
> -        module_free(mod, mod->module_core);
> -        return -ENOMEM;
> +#warning ### CES/zoro fix problem with mod->init_size == 0
> +    if (mod->init_size) {
> +        ptr = module_alloc_update_bounds(mod->init_size);
> +        /*
> +         * The pointer to this block is stored in the module structure
> +         * which is inside the block. This block doesn't need to be
> +         * scanned as it contains data and code that will be freed
> +         * after the module is initialized.
> +         */
> +        kmemleak_ignore(ptr);
> +        if (!ptr) {
> +            module_free(mod, mod->module_core);
> +            return -ENOMEM;
> +        }
> +        memset(ptr, 0, mod->init_size);
> +        mod->module_init = ptr;
>       }
> -    memset(ptr, 0, mod->init_size);
> -    mod->module_init = ptr;
> +    else mod->module_init = NULL;
>
>       /* Transfer each section which specifies SHF_ALLOC */
>       DEBUGP("final section addresses:\n");
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
