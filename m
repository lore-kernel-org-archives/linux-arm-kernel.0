From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 7 Mar 2013 17:12:58 +0900
Subject: [RFC PATCH] ARM: mm: disable kmap_high_get() for SMP
In-Reply-To: <alpine.LFD.2.03.1303051642110.28820@syhkavp.arg>
References: <1362372667-953-1-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.LFD.2.03.1303051642110.28820@syhkavp.arg>
Message-ID: <20130307081258.GA14839@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Nicolas.

On Tue, Mar 05, 2013 at 05:36:12PM +0800, Nicolas Pitre wrote:
> On Mon, 4 Mar 2013, Joonsoo Kim wrote:
> 
> > With SMP and enabling kmap_high_get(), it makes users of kmap_atomic()
> > sequential ordered, because kmap_high_get() use global kmap_lock().
> > It is not welcome situation, so turn off this optimization for SMP.
> 
> I'm not sure I understand the problem.
> 
> The lock taken by kmap_high_get() is released right away before that 
> function returns and therefore this is not actually serializing 
> anything.

Yes, you understand what I want to say correctly.
Sorry for bad explanation.

Following is reasons why I send this patch with RFC tag.

If we have more cpus, performance degration is possible although
it is very short time to holding the lock in kmap_high_get().

And kmap has maximum 512 entries(512 * 4K = 2M) and some mobile devices 
has 2G memory(highmem 1G>), so probability for finding matched entry
is approximately < 1/512. This probability can be more decreasing
for device which have more memory. So I think that waste time to find
matched entry is more than saved time.

Above is my humble opinion, so please let me know what I am missing.

Thanks.

> 
> 
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
