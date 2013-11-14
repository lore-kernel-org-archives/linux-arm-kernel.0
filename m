From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 14 Nov 2013 14:33:33 -0600
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAHCPf3tBOvoeK+ibrA4Hc6iUpVBte+B9BL=-3p8rWz9RmHOfcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 3, 2013 at 2:50 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>

Snip.. I actually reviewed what you're doing since I was
understandably curious as to what the "plan" is for removing
machine_desc and how you'd potentially avoid end up stashing global
variables all over the place for early init code..

> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -199,7 +199,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>         const struct machine_desc *mdesc, *mdesc_best = NULL;
>
>  #ifdef CONFIG_ARCH_MULTIPLATFORM
> -       DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> +       DT_MACHINE_START(GENERIC_DT)
>         MACHINE_END

This machine doesn't have a .dt_compat so...

> +               early_print("%08x\t%s\n", p->nr, p->name ? p->name : *p->dt_compat);

In your case here, isn't this going to print "calxeda,highbank" for
you right now, with a broken tree, since it's the first in your
dt_compat list?

In the generic case, as noted above, the compatibility list usually comes out as

                         ID (hex)       NAME
                         :
                         0xffffffff        Highbank
                         0xffffffff        Generic DT based system

But you've made it say:

                         ID (hex)        NAME
                         :
                         0xffffffff         calxeda,highbank
                         0xffffffff

You didn't fix your customer issue there, at least, if they're messing
with their DT and break it ;)

> @@ -859,7 +859,7 @@ void __init setup_arch(char **cmdline_p)
>         if (!mdesc)
>                 mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>         machine_desc = mdesc;
> -       machine_name = mdesc->name;
> +       machine_name = mdesc->name ? mdesc->name : of_flat_dt_get_machine_name();

Also you missed around line 242 of kernel/devtree.c which prints
mdesc_best->name;

        model = of_get_flat_dt_prop(dt_root, "model", NULL);
        if (!model)
                model = of_get_flat_dt_prop(dt_root, "compatible", NULL);
        if (!model)
                model = "<unknown>";
        pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);

Which is now going to say "Machine: , model: Calxeda Foo Board", isn't it?

Should just use machine_name, if mdesc_best->name isn't set, shouldn't it?

I think there's a bunch of weirdness here.. I just checked the PAPR
and ePAPR specs, and the original IEEE1275 and ARM bindings and
finding board information like you want from the DT is an unholy
crapshoot.

In this case I think we need more information, and to only print it
once per boot if that's the goal here. Why not make machine_name an
argument to setup_machine_fdt (or just don't have it be static in
setup.c) and have that function fill in the right thing rather than
having a DT parsing function in setup_arch where before it was totally
boot-method agnostic?

Ta,
Matt Sealey <neko@bakuhatsu.net>
