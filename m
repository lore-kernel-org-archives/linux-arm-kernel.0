From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 14 Nov 2016 10:28:38 -0800
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
In-Reply-To: <20161111134646.GI28701@mwanda>
References: <20161111061531.23507-1-mzoran@crowfest.net>
 <20161111134646.GI28701@mwanda>
Message-ID: <1479148118.22585.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-11-14 at 12:48 +0300, Dan Carpenter wrote:
> On Thu, Nov 10, 2016 at 10:15:31PM -0800, Michael Zoran wrote:
> > +static void *
> > +vchiq_ioctl_kmalloc(struct vchiq_ioctl_call_context *ctxt, size_t
> > size)
> > +{
> > +	void *mem;
> > +
> > +	if (!ctxt->stackmem_used && size < sizeof(ctxt->stackmem)) 
> > {
> > +		ctxt->stackmem_used = true;
> > +		return ctxt->stackmem;
> > +	}
> > +
> > +	mem = kmalloc(size + sizeof(void *), GFP_KERNEL);
> 
> This is a potential integer overflow leading to corruption.??I don't
> understand why we need this complicated memory management anyway...
> 

You could be right.  This patch was very large and it hasn't received
the review that it probably should get.   Also the checkpatch.pl
utility is complaining about obsolete kernel functionality that the old
code had and I really don't have the time to redo.

Perhaps the entire patch should be removed from consideration until I
can possibly work out a V3?

> > +	if (!mem)
> > +		return NULL;
> > +
> > +	*(void **)mem = ctxt->prev_kmalloc;
> > +	ctxt->prev_kmalloc = mem;
> > +
> > +	return mem + sizeof(void *);
> > +}
> 
> regards,
> dan carpenter
