From: js1304@gmail.com (JoonSoo Kim)
Date: Thu, 15 Nov 2012 22:22:04 +0900
Subject: [RFC PATCH 0/3] introduce static_vm for ARM-specific static
 mapped area
In-Reply-To: <20121114173928.GK3290@n2100.arm.linux.org.uk>
References: <1352912154-16210-1-git-send-email-js1304@gmail.com>
 <20121114173928.GK3290@n2100.arm.linux.org.uk>
Message-ID: <CAAmzW4Mz_+jeuFSe1f+Z3eY_W65oCXYXD3LL+PT8HtRiTAaFXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.
Thanks for review.

2012/11/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Nov 15, 2012 at 01:55:51AM +0900, Joonsoo Kim wrote:
>> In current implementation, we used ARM-specific flag, that is,
>> VM_ARM_STATIC_MAPPING, for distinguishing ARM specific static mapped area.
>> The purpose of static mapped area is to re-use static mapped area when
>> entire physical address range of the ioremap request can be covered
>> by this area.
>>
>> This implementation causes needless overhead for some cases.
>
> In what cases?

For example, assume that there is only one static mapped area and
vmlist has 300 areas.
Every time we call ioremap, we check 300 areas for deciding whether it
is matched or not.
Moreover, even if there is no static mapped area and vmlist has 300 areas,
every time we call ioremap, we check 300 areas in now.

>> We unnecessarily iterate vmlist for finding matched area even if there
>> is no static mapped area. And if there are some static mapped areas,
>> iterating whole vmlist is not preferable.
>
> Why not?  Please put some explanation into your message rather than
> just statements making unexplained assertions.

If we construct a extra list for static mapped area, we can eliminate
above mentioned overhead.
With a extra list, if there is one static mapped area,
we just check only one area and proceed next operation quickly.

>> Another reason for doing this work is for removing architecture dependency
>> on vmalloc layer. I think that vmlist and vmlist_lock is internal data
>> structure for vmalloc layer. Some codes for debugging and stat inevitably
>> use vmlist and vmlist_lock. But it is preferable that they are used outside
>> of vmalloc.c as least as possible.
>
> The vmalloc layer is also made available for ioremap use, and it is
> intended that architectures hook into this for ioremap support.

Yes.
But, I think that it is preferable to use well-defined vmalloc API rather than
directly manipulating low-level data structure. IMHO, if there is no suitable
vmalloc API, making new one is better than directly manipulating
low-level data structure. It makes vmalloc code more maintainable.

I'm not expert, so please let me know what I missed.

Thanks.
