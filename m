From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 18:35:42 -0500 (EST)
Subject: [PATCH v3 0/3] introduce static_vm for ARM-specific static mapped
 area
In-Reply-To: <20130129065656.GC5131@lge.com>
References: <1358990934-4893-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20130128175106.GI23470@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301281300250.6300@xanadu.home>
 <20130129065656.GC5131@lge.com>
Message-ID: <alpine.LFD.2.02.1301291833580.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Joonsoo Kim wrote:

> On Mon, Jan 28, 2013 at 01:04:24PM -0500, Nicolas Pitre wrote:
> > On Mon, 28 Jan 2013, Will Deacon wrote:
> > 
> > > Hello,
> > > 
> > > On Thu, Jan 24, 2013 at 01:28:51AM +0000, Joonsoo Kim wrote:
> > > > In current implementation, we used ARM-specific flag, that is,
> > > > VM_ARM_STATIC_MAPPING, for distinguishing ARM specific static mapped area.
> > > > The purpose of static mapped area is to re-use static mapped area when
> > > > entire physical address range of the ioremap request can be covered
> > > > by this area.
> > > > 
> > > > This implementation causes needless overhead for some cases.
> > > > For example, assume that there is only one static mapped area and
> > > > vmlist has 300 areas. Every time we call ioremap, we check 300 areas for
> > > > deciding whether it is matched or not. Moreover, even if there is
> > > > no static mapped area and vmlist has 300 areas, every time we call
> > > > ioremap, we check 300 areas in now.
> > > > 
> > > > If we construct a extra list for static mapped area, we can eliminate
> > > > above mentioned overhead.
> > > > With a extra list, if there is one static mapped area,
> > > > we just check only one area and proceed next operation quickly.
> > > > 
> > > > In fact, it is not a critical problem, because ioremap is not frequently
> > > > used. But reducing overhead is better idea.
> > > > 
> > > > Another reason for doing this work is for removing vm_struct list management,
> > > > entirely. For more information, look at the following link.
> > > > http://lkml.org/lkml/2012/12/6/184
> > > 
> > > First patch looks good (removing the unused vmregion stuff) but I'm not so
> > > sure about the rest of it. If you really care about ioremap performance,
> > > perhaps it would be better to have a container struct around the vm_struct
> > > for static mappings and then stick them in an augmented rbtree so you can
> > > efficiently find the mapping encompassing a particular physical address?
> > 
> > How can ioremap performance be a problem is the question I had since the 
> > beginning.
> > 
> > Firstly, ioremap is _not_ meant to be used in performance critical 
> > paths.
> > 
> > Secondly, there shouldn't be _that_ many entries on the vmlist such as 
> > 300.  That sounds a bit excessive.
> > 
> > So please, can we discuss the reasons that motivated those patches in 
> > the first place?  Maybe that's where the actual problem is.
> 
> Hello, Wiil and Nicolas.
> First of all, thanks for reviewing.
> 
> There is another reason for doing this work.
> As mentioned above, I try to remove list management for vm_struct(vmlist),
> entirely. For that purpose, removing architecture dependency against vmlist
> is needed. Below link is for my RFC patch trying to remove list management
> for vm_struct.
> 
> http://lkml.org/lkml/2012/12/6/184

OK,  I get it now.

I do have comments on your patches.  I'll provide them as a reply to 
them.


Nicolas
