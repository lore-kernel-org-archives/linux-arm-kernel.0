From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 08 Feb 2010 22:35:34 -0500 (EST)
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
	<A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.00.1002082229480.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
