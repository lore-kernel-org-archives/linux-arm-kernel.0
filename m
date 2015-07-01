From: hch@lst.de (Christoph Hellwig)
Date: Wed, 1 Jul 2015 08:23:52 +0200
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
Message-ID: <20150701062352.GA3739@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 03:57:16PM -0700, Dan Williams wrote:
> > void __iomem *ioremap_flags(resource_size_t offset, unsigned long size,
> >                         unsigned long prot_val, unsigned flags);
> 
> Doesn't 'flags' imply a specific 'prot_val'?

Looks like the values are arch specific.  So as a first step I'd like
to keep them separate.  As a second step we could look into unifying
the actual ioremap implementations which look mostly the same.  Once
that is done we could look into collapsing the flags and prot_val
arguments.

> One useful feature of the ifdef mess as implemented in the patch is
> that you could test for whether ioremap_cache() is actually
> implemented or falls back to default ioremap().  I think for
> completeness archs should publish an ioremap type capabilities mask
> for drivers that care... (I can imagine pmem caring), or default to
> being permissive if something like IOREMAP_STRICT is not set.  There's
> also the wrinkle of archs that can only support certain types of
> mappings at a given alignment.

I think doing this at runtime might be a better idea.  E.g. a
ioremap_flags with the CACHED argument will return -EOPNOTSUP unless
actually implemented.  On various architectures different CPUs or
boards will have different capabilities in this area.
