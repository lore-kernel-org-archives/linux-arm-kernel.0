From: tj@kernel.org (Tejun Heo)
Date: Thu, 4 May 2017 12:00:32 -0400
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170504120314.lfmcv4cpsuz2igte@lukather>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <20170504120314.lfmcv4cpsuz2igte@lukather>
Message-ID: <20170504160032.GA5147@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 04, 2017 at 02:03:14PM +0200, Maxime Ripard wrote:
> > @@ -704,6 +704,7 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
> >  		radix_tree_delete(&pctldev->pin_group_tree, indices[i]);
> >  		devm_kfree(pctldev->dev, group);
> >  	}
> > +	kfree(indices);
> 
> We use devm_kfree for other allocations done here, maybe we can just
> have the same thing here? We would be consistant, and we would still
> keep the resource tracking.

It doesn't make any sense to use the managed functions from the
release functions and if you're always matching devm_kmalloc() with
devm_kfree(), the only thing it'd do is confusing its readers.

And the function in question just looks weird to me - give up on
freeing resources if memory allocation fails?  And why call
devm_kfree() on objects which are being released anyway?  Or if the
group can be released w/o the device being detached, why use devm
allocations on the members at all?

As for removal, can't it just call radix_tree_iter_delete() while
iterating?  Why allocate memory to iterate and store all indices and
to look them up again and delete them?

Thanks.

-- 
tejun
