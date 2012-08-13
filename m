From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Aug 2012 23:32:44 -0400 (EDT)
Subject: [PATCH v2 03/22] ARM: use late patch framework for phys-virt
 patching
In-Reply-To: <5027E90E.2000604@ti.com>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-4-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208112238270.5231@xanadu.home> <5027E90E.2000604@ti.com>
Message-ID: <alpine.LFD.2.02.1208122320310.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Aug 2012, Cyril Chemparathy wrote:

> On 08/11/12 23:03, Nicolas Pitre wrote:
> > On Fri, 10 Aug 2012, Cyril Chemparathy wrote:
> > 
> > > -extern unsigned long __pv_phys_offset;
> > > -#define PHYS_OFFSET __pv_phys_offset
> [...]
> > > +#define PHYS_OFFSET	__virt_to_phys(PAGE_OFFSET)
> > 
> > What was wrong with the former PHYS_OFFSET = __pv_phys_offset ?
> > 
> > If you really want to have it optimized at run time, you could simply
> > use your new stub to patch a mov instruction instead of going through
> > __virt_to_phys which uses and add on top of a constant.
> > 
> 
> The intent was to optimize out the load(s) on references to PHYS_OFFSET, but
> is it worth it?  If so, we could go with a patched mov (or two) with the
> necessary endian fixups.  If not, we could revert to __pv_phys_offset loads as
> before.

If you want to do better than the load, then you'd better go all the way 
with the patched move.

> > You also should remove the MODULE_ARCH_VERMAGIC_P2V definitions now that
> > the corresponding code is no longer there.
> > 
> 
> Hmm...
> 
> "rt-patch" needs to be in vermagic to prevent modules built against the new
> code from being loaded on older kernels that used the traditional patch code.

Right.

> "p2v" needs to be in there as well, because it should be possible to build
> without PATCH_PHYS_VIRT, but with RUNTIME_PATCH as and when there are other
> users for this.

That doesn't matter if there are other users.  As soon as there is a 
.init.runtime_patch_table that needs to be processed then "rt-patch" 
flags it.  Whether this is used for PATCH_PHYS_VIRT or other purposes is 
irrelevant.

However there isn't any pv_table anymore, so "p2v" should go as there is 
no more code to process those tables if they're ever encountered.


Nicolas
