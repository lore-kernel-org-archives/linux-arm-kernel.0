From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 09:51:04 +0100
Subject: question about drivers/pinctrl/pinctrl-at91.c
In-Reply-To: <alpine.DEB.2.02.1212081643590.1984@hadrien>
References: <alpine.DEB.2.02.1212081643590.1984@hadrien>
Message-ID: <CACRpkdY_znNHckam+PsysddCib2PP-6Lk4OM8_v34BX+p4pu-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 8, 2012 at 4:52 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> The function at91_dt_node_to_map in drivers/pinctrl/pinctrl-at91.c contains
> the following code:
>
>        new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num,
> GFP_KERNEL);
>         if (!new_map)
>                 return -ENOMEM;
>
>         *map = new_map;
>         *num_maps = map_num;
>
>         /* create mux map */
>         parent = of_get_parent(np);
>         if (!parent) {
>                 kfree(new_map);
>                 return -EINVAL;
>         }
>
> This is clearly not correct, because the combination of devm_kzalloc and
> kfree risks creating a double free.

Agreed, probably just some spurious leftover.

> But I am not sure how best to fix it.
> Is the data structure intended to normally exist until the driver's remove
> function is called?  If so, perhaps the devm_kzalloc is OK.  If I just
> remove the kfree, then the structure will persist until the remove function
> is called, even though there was an error, which is perhaps not good.  So I
> could change the kfree to devm_kfree?

I was under the impression that if you exit the probe function
with a negative value anything allocated with devm_* was freed
immediately, that is atleast how it's described in
Documentation/driver-model/devres.txt
atleast that seems to be the intetion with the whole thing.

So just delete the kfree() oneliner.

Yours,
Linus Walleij
