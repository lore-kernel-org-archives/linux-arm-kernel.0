From: GKing@nvidia.com (Gary King)
Date: Mon, 8 Feb 2010 20:00:53 -0800
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <alpine.LFD.2.00.1002082229480.1681@xanadu.home>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
	<A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082229480.1681@xanadu.home>
Message-ID: <A0A1E7539300DF49AA383E614C7827BC048DB10984@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is not a no-op; without this patch I was seeing panics in v7_flush_kern_dcache about 1 time in 3 boots, with it the crash has not reproduced in hundreds of boots.

However, from re-reading the highmem code, I think my original description of the cause of the crash was slightly mistaken:

Kmap zero-flushing is lazy (it happens on the subsequent call to kmap), and the page_address is not set to NULL until the lazy-flush happens. In this case, if page_address is called immediately following a kunmap call which resulted in the pin count dropping to 1, a valid address will be returned.

On SMP or PREEMPT kernels, kmap may be called in one context during cache maintenance on one of these pages in a different context, resulting in flush_all_zero_pkmaps invalidating the PTE (and TLB) of the pages that is actively undergoing maintenance.

- Gary

-----Original Message-----
From: Nicolas Pitre [mailto:nico at fluxnic.net] 
Sent: Monday, February 08, 2010 7:36 PM
To: Gary King
Cc: 'Russell King - ARM Linux'; 'linux-arm-kernel at lists.infradead.org'
Subject: RE: race between kmap shootdown and cache maintenance

On Mon, 8 Feb 2010, Gary King wrote:

> Fixed version attached.
> 
> 
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Sunday, February 07, 2010 7:31 AM
> To: Gary King
> Cc: 'linux-arm-kernel at lists.infradead.org'
> Subject: Re: race between kmap shootdown and cache maintenance
> 
> On Fri, Feb 05, 2010 at 10:13:03AM -0800, Gary King wrote:
> > for highmem pages, flush_dcache_page must pin the kmap mapping in-place
> > using kmap_high_get, to ensure that the cache maintenance does not race
> > with another context calling kunmap_high on the same page and causing the
> > PTE to be zapped.

Is this actually possible?

Any flush_dcache_page() caller must have a reference count on the given 
highmem page since no one is supposed to play with a highmem page 
pointer without having called kmap() on it first.  Therefore any other 
context calling kunmap_high() is never expected to drop the kmap ref 
count to zero.

So unless proven otherwise I think this patch is useless.


Nicolas
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
