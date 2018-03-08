From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 8 Mar 2018 23:49:18 +0000
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
In-Reply-To: <20180308111348.GB6019@sirena.org.uk>
References: <2424862.oPtAVTfrB9@jernej-laptop>
 <20180302124050.GF6255@sirena.org.uk>
 <26212674.B0xcQEiVyd@jernej-laptop>
 <1832733.mujlD9skaR@jernej-laptop>
 <87efkvtldx.wl%kuninori.morimoto.gx@renesas.com>
 <20180308111348.GB6019@sirena.org.uk>
Message-ID: <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark,Jernej

> > Ahh.. indeed. Good catch !
> > How about to add such flag ?
> > This is just idea. No tested, No compiled, but can help you ?
> 
> I think this makes sense as a patch.  We might want to disallow
> allocating components as part of a bigger struct so everything is more
> consistent but that's a bigger thing.
(snip)
> I tested this patch and there is no crash anymore. If you will send it as a 
> fix, you can add:
> 
> Reported-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>

previous my patch used new flag (= .alloced_component),
but I think it is not good idea.
And I noticed that snd_soc_add_component() is
also calling kfree(component) (= has same bug).

So how about below one ?
I want to post it instead of previous.

# I will go to ELC next week, thus posting patch will be
# 2weeks later

------------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac8..4a8de23 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3476,7 +3476,6 @@ int snd_soc_add_component(struct device *dev,
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
-	kfree(component);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_component);
@@ -3488,7 +3487,7 @@ int snd_soc_register_component(struct device *dev,
 {
 	struct snd_soc_component *component;
 
-	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
 	if (!component)
 		return -ENOMEM;
 
@@ -3523,7 +3522,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 
 	if (found) {
 		snd_soc_component_cleanup(component);
-		kfree(component);
 	}
 
 	return found;
------------
