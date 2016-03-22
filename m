From: jroedel@suse.de (Joerg Roedel)
Date: Tue, 22 Mar 2016 18:55:49 +0100
Subject: [PATCH 1/2] of: Implement iterator for phandles
In-Reply-To: <CAL_JsqKjaB_YK3JY053BvcDpfr5pMg4-f53L4QYupuP=kQsLuw@mail.gmail.com>
References: <1458146527-1133-1-git-send-email-joro@8bytes.org>
 <1458146527-1133-2-git-send-email-joro@8bytes.org>
 <CAL_JsqKjaB_YK3JY053BvcDpfr5pMg4-f53L4QYupuP=kQsLuw@mail.gmail.com>
Message-ID: <20160322175549.GC3529@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Mar 18, 2016 at 10:54:57AM -0500, Rob Herring wrote:
> This mostly looks fine to me, but it is kind of a lot of functions
> just for this one thing. For example, I think the caller can track the
> index themselves if they care about it. I'd also like to see a more
> standard style for_each type iterator define rather than open coded
> while loops.

Thanks for your feedback. I think I worked everything into the patches
and am about to send a new version.

> > +struct of_phandle_iterator {
> > +       const struct device_node *np;
> > +       const __be32 *list;
> > +       const __be32 *list_end;
> > +       const __be32 *phandle_end;
> > +       phandle phandle;
> > +       struct device_node *node;
> 
> np and node? If you need both, name them based on what they point to.

Yes, 'np' is the parent node, while 'node' is the current node the
iterator points to. The parent node is needed for the error messages
later.

> > +static inline struct device_node *of_phandle_iterator_node(struct of_phandle_iterator *it)
> > +{
> > +       if (!it->node)
> > +               it->node = of_find_node_by_phandle(it->phandle);
> > +
> > +       if (it->node)
> > +               of_node_get(it->node);
> 
> The above function may have already done the get. Not sure offhand.

Yes, it does. But when the iterator moves on the node will be put again.
So when it is returned here we get an extra reference.

But it doesn't matter anymore as I changed the code to unconditionally
get the node in of_phandle_iterator_next now.



	Joerg
