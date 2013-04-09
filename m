From: linfeng@cn.fujitsu.com (Lin Feng)
Date: Tue, 09 Apr 2013 09:58:55 +0800
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <20130408135553.2f60518d923b6920bdf1931f@linux-foundation.org>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
 <20130408135553.2f60518d923b6920bdf1931f@linux-foundation.org>
Message-ID: <516375DF.3080602@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 04/09/2013 04:55 AM, Andrew Morton wrote:
> On Mon, 8 Apr 2013 11:40:11 -0700 Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> On Mon, Apr 8, 2013 at 2:56 AM, Lin Feng <linfeng@cn.fujitsu.com> wrote:
>>> In hot add node(memory) case, vmemmap pages are always allocated from other
>>> node,
>>
>> that is broken, and should be fixed.
>> vmemmap should be on local node even for hot add node.
>>
> 
> That would be nice.
> 
> I don't see much value in the added warnings, really.  Because there's
> nothing the user can *do* about them, apart from a) stop using NUMA, b)
> stop using memory hotplug, c) become a kernel MM developer or d) switch
> to Windows.
> 
> 

I agree that we can't do anything helpful to response to such warnings for
the moment, but maybe someone can at least take your c) measure if it's 
what he really cares. ;-)

This patch sent because we found that on a old kernel we get such warnings
but we don't on latest kernel, it appears that it has been fixed by someone
but in fact it is due to sizeof(struct page) is 64bytes aligned now but not
on the old kernel. Now the struct pages for a section is always 2MB in size, 
every time we populate vmemmap for a section we get a new pmd, so the 
vmemmap_verify() check is just ignored. Such phenomenon is misleading.

struct page {
	...
}
#ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
      __aligned(2 * sizeof(unsigned long))
#endif
; 

Anyway the current logic for vmemmap_verify() is broken :(

thanks,
linfeng
