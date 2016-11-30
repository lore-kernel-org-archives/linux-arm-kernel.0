From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 30 Nov 2016 11:02:01 +0800
Subject: [PATCH V2 fix 5/6] mm: hugetlb: add a new function to allocate a
 new gigantic page
In-Reply-To: <777f7e0c-c04b-77c3-b866-0787bad32aa8@suse.cz>
References: <1479107259-2011-6-git-send-email-shijie.huang@arm.com>
 <1479279304-31379-1-git-send-email-shijie.huang@arm.com>
 <f6fc93b4-5c1c-bbab-7c74-a0d60d4afc84@suse.cz>
 <20161129090322.GB16569@sha-win-210.asiapac.arm.com>
 <777f7e0c-c04b-77c3-b866-0787bad32aa8@suse.cz>
Message-ID: <20161130030159.GA18502@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:50:37AM +0100, Vlastimil Babka wrote:
> > > > +	if (!vma) {
> > > > +		if (nid == NUMA_NO_NODE) {
> > > > +			if (!init_nodemask_of_mempolicy(nodes_allowed)) {
> > > > +				NODEMASK_FREE(nodes_allowed);
> > > > +				nodes_allowed = &node_states[N_MEMORY];
> > > > +			}
> > > > +		} else if (nodes_allowed) {
> > The check is here.
> 
> It's below a possible usage of nodes_allowed as an argument of
> init_nodemask_of_mempolicy(mask). Which does
Sorry, I missed that.
> 
>         if (!(mask && current->mempolicy))
>                 return false;
> 
> which itself looks like an error at first sight :)
Yes. I agree.
> 
> > Do we really need to re-arrange the code here for the explicit check? :)
> 
> We don't need it *now* to be correct, but I still find it fragile. Also it
> mixes up the semantic of NULL as a conscious "default" value, and NULL as
> a side-effect of memory allocation failure. Nothing good can come from that
> in the long term :)
Okay, I think we do have the need to do the NULL check for
@nodes_allowed. :)

Thanks
Huang Shijie
