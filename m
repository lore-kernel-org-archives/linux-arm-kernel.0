From: riel@redhat.com (Rik van Riel)
Date: Thu, 14 Jul 2016 21:04:18 -0400
Subject: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <20160714232019.GA28254@350D>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
Message-ID: <1468544658.30053.26.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-15 at 09:20 +1000, Balbir Singh wrote:

> > ==
> > +		???((unsigned long)end & (unsigned
> > long)PAGE_MASK)))
> > +		return NULL;
> > +
> > +	/* Allow if start and end are inside the same compound
> > page. */
> > +	endpage = virt_to_head_page(end);
> > +	if (likely(endpage == page))
> > +		return NULL;
> > +
> > +	/* Allow special areas, device memory, and sometimes
> > kernel data. */
> > +	if (PageReserved(page) && PageReserved(endpage))
> > +		return NULL;
> 
> If we came here, it's likely that endpage > page, do we need to check
> that only the first and last pages are reserved? What about the ones
> in
> the middle?

I think this will be so rare, we can get away with just
checking the beginning and the end.

-- 

All Rights Reversed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160714/9ed8313e/attachment-0001.sig>
