From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Thu, 4 Dec 2014 14:10:53 +0800
Subject: [RFC V2] mm:add zero_page _mapcount when mapped into user space
In-Reply-To: <20141202113014.GA22683@node.dhcp.inet.fi>
References: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
 <20141202113014.GA22683@node.dhcp.inet.fi>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313E6@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kirill A. Shutemov [mailto:kirill at shutemov.name]
> Sent: Tuesday, December 02, 2014 7:30 PM
> To: Wang, Yalin
> Cc: 'linux-kernel at vger.kernel.org'; 'linux-mm at kvack.org'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: [RFC V2] mm:add zero_page _mapcount when mapped into user
> space
> 
> On Tue, Dec 02, 2014 at 05:27:36PM +0800, Wang, Yalin wrote:
> > This patch add/dec zero_page's _mapcount to make sure the mapcount is
> > correct for zero_page, so that when read from /proc/kpagecount,
> > zero_page's mapcount is also correct, userspace process like procrank
> > can calculate PSS correctly.
> 
> I don't have specific code path to point to, but I would expect zero page
> with non-zero mapcount would cause a problem with rmap.
> 
> How do you test the change?
> 
I just test it to see the mapcount from /proc/pid/pagemap  and /proc/kpagecount ,
It works well,
The problem is that when I see /proc/pid/smaps ,
The Rss / Pss don't calculate zero_page map,
Because smaps_pte_entry() --> vm_normal_page( ),
Will return NULL for zero_page,

But when userspace process cat /proc/pid/pagemap  ,
It will see zero_page mapped,
And will treat as Rss ,  
This is weird, should we also omit zero_page in /proc/pid/pagemap ?
Or add zero_page as Rss in /proc/pid/smaps ? 

I think we should add zero_page into Rss ,
Because it is really mapped into userspace address space.
And will let userspace memory analysis more accurate .

Thanks
