From: toshi.kani@hp.com (Toshi Kani)
Date: Tue, 07 Jul 2015 17:10:58 -0600
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <20150707160703.GR7021@wotan.suse.de>
References: <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
 <20150701062352.GA3739@lst.de>
 <CAMuHMdUO4uSWH1Qc0SfDTLuXbiG2N9fq8Tf6j+3RoqVKdPugbA@mail.gmail.com>
 <20150701065948.GA4355@lst.de>
 <CAMuHMdXqjmo2T3V=msZySVSu2j4YjyE7FnVXWTjySEyfYLSg1A@mail.gmail.com>
 <20150701072828.GA4881@lst.de> <20150707095012.GQ7021@wotan.suse.de>
 <20150707101330.GJ7557@n2100.arm.linux.org.uk>
 <20150707160703.GR7021@wotan.suse.de>
Message-ID: <1436310658.3214.85.camel@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-07 at 18:07 +0200, Luis R. Rodriguez wrote:
> On Tue, Jul 07, 2015 at 11:13:30AM +0100, Russell King - ARM Linux 
> wrote:
  :
> > On ARM, we (probably) have a lot of cases where ioremap() is used 
> > multiple
> > times for the same physical address space, so we shouldn't rule out 
> > having
> > multiple mappings of the same type.
> 
> Why is that done? Don't worry if you are not sure why but only 
> speculate of the
> practice's existence (sloppy drivers or lazy driver developers). FWIW 
> for x86
> IIRC I ended up concluding that overlapping ioremap() calls with the 
> same type
> would work but not if they differ in type.  Although I haven't 
> written a
> grammer rule to hunt down overlapping ioremap() I suspected its use 
> was likely
> odd and likely should be reconsidered. Would this be true for ARM too 
> ? Or are
> you saying this should be a feature ? I don't expect an answer now 
> but I'm
> saying we *should* all together decide on this, and if you're 
> inclined to
> believe that this should ideally be avoided I'd like to hear that. If 
> you feel
> strongly though this should be a feature I would like to know why.

There are multiple mapping interfaces, and overlapping can happen among
them as well.  For instance, remap_pfn_range() (and 
io_remap_pfn_range(), which is the same as remap_pfn_range() on x86)
creates a mapping to user space.  The same physical ranges may be
mapped to kernel and user spaces.  /dev/mem is one example that may
create a user space mapping to a physical address that is already
mapped with ioremap() by other module.  pmem and DAX also create
mappings to the same NVDIMM ranges.  DAX calls vm_insert_mixed(), which
is particularly a problematic since vm_insert_mixed() does not verify
aliasing.  ioremap() and remap_pfn_range() call reserve_memtype() to
verify aliasing on x86.  reserve_memtype() is x86-specific and there is
no arch-generic wrapper for such check.  I think DAX could get a cache
type from pmem to keep them in sync, though.

Thanks,
-Toshi


 
