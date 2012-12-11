From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 11 Dec 2012 09:06:59 +0000
Subject: question about drivers/pinctrl/pinctrl-at91.c
In-Reply-To: <alpine.DEB.2.02.1212081643590.1984@hadrien>
References: <alpine.DEB.2.02.1212081643590.1984@hadrien>
Message-ID: <20121211090659.DAC4C3E076D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Dec 2012 16:52:42 +0100 (CET), Julia Lawall <julia.lawall@lip6.fr> wrote:
> The function at91_dt_node_to_map in drivers/pinctrl/pinctrl-at91.c 
> contains the following code:
> 
>         new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);
>          if (!new_map)
>                  return -ENOMEM;
> 
>          *map = new_map;
>          *num_maps = map_num;
> 
>          /* create mux map */
>          parent = of_get_parent(np);
>          if (!parent) {
>                  kfree(new_map);
>                  return -EINVAL;
>          }
> 
> This is clearly not correct, because the combination of devm_kzalloc and 
> kfree risks creating a double free.  But I am not sure how best to fix it. 
> Is the data structure intended to normally exist until the driver's remove 
> function is called?  If so, perhaps the devm_kzalloc is OK.  If I just 
> remove the kfree, then the structure will persist until the remove 
> function is called, even though there was an error, which is perhaps not 
> good.  So I could change the kfree to devm_kfree?

Hi Julia,

I don't have that file in my tree. Is it in linux-next? (I'm too lazy to
go and look)

Yes, devm_kfree() is the right thing to call, but I'd be tempted to just
drop the free entirely. If it fails there is something wrong and it will
get cleaned up when the probe returns a fail code... but look at the
code; if failing there is a valid way for the driver to operate, then
doing the cleanup is the right thing....

Alternately the of_get_parent() call could simply be moved above the
devm_kzalloc() and then the issue becomes moot.  :-)

g.
