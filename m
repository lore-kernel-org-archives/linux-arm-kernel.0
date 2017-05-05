From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 May 2017 21:55:18 +0200
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170504160032.GA5147@htj.duckdns.org>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <20170504120314.lfmcv4cpsuz2igte@lukather>
 <20170504160032.GA5147@htj.duckdns.org>
Message-ID: <20170505195518.xbn5n7uzo2xherah@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 12:00:32PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 04, 2017 at 02:03:14PM +0200, Maxime Ripard wrote:
> > > @@ -704,6 +704,7 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
> > >  		radix_tree_delete(&pctldev->pin_group_tree, indices[i]);
> > >  		devm_kfree(pctldev->dev, group);
> > >  	}
> > > +	kfree(indices);
> > 
> > We use devm_kfree for other allocations done here, maybe we can just
> > have the same thing here? We would be consistant, and we would still
> > keep the resource tracking.
> 
> It doesn't make any sense to use the managed functions from the
> release functions and if you're always matching devm_kmalloc() with
> devm_kfree(), the only thing it'd do is confusing its readers.

I wouldn't say that being able to recover and free whatever memory
leak we might have not making sense, but ok. That was one of the
options, let's discard it.

The other one is: refactor the rest of the allocations so that you
don't have a mix of devm_kmalloc / devm_kfree and kmalloc / kfree for
the same purpose in the same function.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170505/cf11918c/attachment-0001.sig>
