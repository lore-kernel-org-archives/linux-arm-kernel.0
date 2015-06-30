From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 30 Jun 2015 15:57:16 -0700
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <20150622161002.GB8240@lst.de>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
Message-ID: <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 9:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 22, 2015 at 04:24:27AM -0400, Dan Williams wrote:
>> Some archs define the first parameter to ioremap() as unsigned long,
>> while the balance define it as resource_size_t.  Unify on
>> resource_size_t to enable passing ioremap function pointers.  Also, some
>> archs use function-like macros for defining ioremap aliases, but
>> asm-generic/io.h expects object-like macros, unify on the latter.
>>
>> Move all handling of ioremap aliasing (i.e. ioremap_wt => ioremap) to
>> include/linux/io.h.  Add a check to include/linux/io.h to warn at
>> compile time if an arch violates expectations.
>>
>> Kill ARCH_HAS_IOREMAP_WC and ARCH_HAS_IOREMAP_WT in favor of just
>> testing for ioremap_wc, and ioremap_wt being defined.  This arrangement
>> allows drivers to know when ioremap_<foo> are being re-directed to plain
>> ioremap.
>>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hmm, this is quite a bit of churn, and doesn't make the interface lot
> more obvious.
>
> I guess it's enough to get the pmem related bits going, but I'd really
> prefer defining the ioremap* prototype in linux/io.h and requiring
> and out of line implementation in the architectures, it's not like
> it's a fast path.  And to avoid the ifdef mess make it something like:
>
> void __iomem *ioremap_flags(resource_size_t offset, unsigned long size,
>                         unsigned long prot_val, unsigned flags);

Doesn't 'flags' imply a specific 'prot_val'?

> static inline void __iomem *ioremap(resource_size_t offset, unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, 0);
> }
>
> static inline void __iomem *ioremap_prot(resource_size_t offset,
>                 unsigned long size, unsigned long prot_val)
> {
>         return ioremap_flags(offset, size, prot_val, 0);
> }
>
> static inline void __iomem *ioremap_nocache(resource_size_t offset,
>                 unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, IOREMAP_NOCACHE);
> }
>
> static inline void __iomem *ioremap_cache(resource_size_t offset,
>                 unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, IOREMAP_CACHE);
> }
>
> static inline void __iomem *ioremap_uc(resource_size_t offset,
>                 unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, IOREMAP_UC);
> }
>
> static inline void __iomem *ioremap_wc(resource_size_t offset,
>                 unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, IOREMAP_WC);
> }
>
> static inline void __iomem *ioremap_wt(resource_size_t offset,
>                 unsigned long size)
> {
>         return ioremap_flags(offset, size, 0, IOREMAP_WT);
> }
>
> With all wrappers but ioremap() itself deprecated in the long run.
>
> Besides following the one API one prototype guideline this gives
> us one proper entry point for all the variants.  Additionally
> it can reject non-supported caching modes at run time, e.g. because
> different hardware may or may not support it.  Additionally it
> avoids the need for all these HAVE_IOREMAP_FOO defines, which need
> constant updating.

One useful feature of the ifdef mess as implemented in the patch is
that you could test for whether ioremap_cache() is actually
implemented or falls back to default ioremap().  I think for
completeness archs should publish an ioremap type capabilities mask
for drivers that care... (I can imagine pmem caring), or default to
being permissive if something like IOREMAP_STRICT is not set.  There's
also the wrinkle of archs that can only support certain types of
mappings at a given alignment.
