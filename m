From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jan 2013 17:51:06 +0000
Subject: [PATCH v3 0/3] introduce static_vm for ARM-specific static
 mapped area
In-Reply-To: <1358990934-4893-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1358990934-4893-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <20130128175106.GI23470@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 24, 2013 at 01:28:51AM +0000, Joonsoo Kim wrote:
> In current implementation, we used ARM-specific flag, that is,
> VM_ARM_STATIC_MAPPING, for distinguishing ARM specific static mapped area.
> The purpose of static mapped area is to re-use static mapped area when
> entire physical address range of the ioremap request can be covered
> by this area.
> 
> This implementation causes needless overhead for some cases.
> For example, assume that there is only one static mapped area and
> vmlist has 300 areas. Every time we call ioremap, we check 300 areas for
> deciding whether it is matched or not. Moreover, even if there is
> no static mapped area and vmlist has 300 areas, every time we call
> ioremap, we check 300 areas in now.
> 
> If we construct a extra list for static mapped area, we can eliminate
> above mentioned overhead.
> With a extra list, if there is one static mapped area,
> we just check only one area and proceed next operation quickly.
> 
> In fact, it is not a critical problem, because ioremap is not frequently
> used. But reducing overhead is better idea.
> 
> Another reason for doing this work is for removing vm_struct list management,
> entirely. For more information, look at the following link.
> http://lkml.org/lkml/2012/12/6/184

First patch looks good (removing the unused vmregion stuff) but I'm not so
sure about the rest of it. If you really care about ioremap performance,
perhaps it would be better to have a container struct around the vm_struct
for static mappings and then stick them in an augmented rbtree so you can
efficiently find the mapping encompassing a particular physical address?

Will
