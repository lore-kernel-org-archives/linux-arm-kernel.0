From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Dec 2012 16:52:42 +0100 (CET)
Subject: question about drivers/pinctrl/pinctrl-at91.c
Message-ID: <alpine.DEB.2.02.1212081643590.1984@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function at91_dt_node_to_map in drivers/pinctrl/pinctrl-at91.c 
contains the following code:

        new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);
         if (!new_map)
                 return -ENOMEM;

         *map = new_map;
         *num_maps = map_num;

         /* create mux map */
         parent = of_get_parent(np);
         if (!parent) {
                 kfree(new_map);
                 return -EINVAL;
         }

This is clearly not correct, because the combination of devm_kzalloc and 
kfree risks creating a double free.  But I am not sure how best to fix it. 
Is the data structure intended to normally exist until the driver's remove 
function is called?  If so, perhaps the devm_kzalloc is OK.  If I just 
remove the kfree, then the structure will persist until the remove 
function is called, even though there was an error, which is perhaps not 
good.  So I could change the kfree to devm_kfree?

thanks,
julia
