From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 11 Dec 2012 10:04:03 +0100 (CET)
Subject: question about drivers/pinctrl/pinctrl-at91.c
In-Reply-To: <CACRpkdY_znNHckam+PsysddCib2PP-6Lk4OM8_v34BX+p4pu-A@mail.gmail.com>
References: <alpine.DEB.2.02.1212081643590.1984@hadrien>
 <CACRpkdY_znNHckam+PsysddCib2PP-6Lk4OM8_v34BX+p4pu-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212110958110.2091@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Dec 2012, Linus Walleij wrote:

> On Sat, Dec 8, 2012 at 4:52 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > The function at91_dt_node_to_map in drivers/pinctrl/pinctrl-at91.c contains
> > the following code:
> >
> >        new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num,
> > GFP_KERNEL);
> >         if (!new_map)
> >                 return -ENOMEM;
> >
> >         *map = new_map;
> >         *num_maps = map_num;
> >
> >         /* create mux map */
> >         parent = of_get_parent(np);
> >         if (!parent) {
> >                 kfree(new_map);
> >                 return -EINVAL;
> >         }
> >
> > This is clearly not correct, because the combination of devm_kzalloc and
> > kfree risks creating a double free.
>
> Agreed, probably just some spurious leftover.
>
> > But I am not sure how best to fix it.
> > Is the data structure intended to normally exist until the driver's remove
> > function is called?  If so, perhaps the devm_kzalloc is OK.  If I just
> > remove the kfree, then the structure will persist until the remove function
> > is called, even though there was an error, which is perhaps not good.  So I
> > could change the kfree to devm_kfree?
>
> I was under the impression that if you exit the probe function
> with a negative value anything allocated with devm_* was freed
> immediately, that is atleast how it's described in
> Documentation/driver-model/devres.txt
> atleast that seems to be the intetion with the whole thing.

That is true, but I wasn't sure taht this function was part of the probe
function.  Its only reference is in:

static struct pinctrl_ops at91_pctrl_ops = {
        .get_groups_count       = at91_get_groups_count,
        .get_group_name         = at91_get_group_name,
        .get_group_pins         = at91_get_group_pins,
	.pin_dbg_show           = at91_pin_dbg_show,
        .dt_node_to_map         = at91_dt_node_to_map,
        .dt_free_map            = at91_dt_free_map,
};

Working backwards, one possible call site is pinctrl_get, which is an
exported function.  Is it safe to assume that it will always be called
from within a probe function?

thanks,
julia
