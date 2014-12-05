From: koct9i@gmail.com (Konstantin Khlebnikov)
Date: Fri, 5 Dec 2014 10:39:04 +0400
Subject: [RFC V2] mm:add zero_page _mapcount when mapped into user space
In-Reply-To: <20141204122813.GA523@node.dhcp.inet.fi>
References: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
 <20141202113014.GA22683@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313E6@CNBJMBX05.corpusers.net>
 <20141204122813.GA523@node.dhcp.inet.fi>
Message-ID: <CALYGNiPWw6=tryWn_kCs+6H1uSjApBDnqORxuNEd=DuGCo71qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 4, 2014 at 3:28 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Thu, Dec 04, 2014 at 02:10:53PM +0800, Wang, Yalin wrote:
>> > -----Original Message-----
>> > From: Kirill A. Shutemov [mailto:kirill at shutemov.name]
>> > Sent: Tuesday, December 02, 2014 7:30 PM
>> > To: Wang, Yalin
>> > Cc: 'linux-kernel at vger.kernel.org'; 'linux-mm at kvack.org'; 'linux-arm-
>> > kernel at lists.infradead.org'
>> > Subject: Re: [RFC V2] mm:add zero_page _mapcount when mapped into user
>> > space
>> >
>> > On Tue, Dec 02, 2014 at 05:27:36PM +0800, Wang, Yalin wrote:
>> > > This patch add/dec zero_page's _mapcount to make sure the mapcount is
>> > > correct for zero_page, so that when read from /proc/kpagecount,
>> > > zero_page's mapcount is also correct, userspace process like procrank
>> > > can calculate PSS correctly.

Instead of tweaking mapcount you could mark zero-pages in /proc/kpageflags
and handle them accordingly in userspace. Or mark zero pages with special
magic _mapcount and detect it in /proc/kpagecount.

>> >
>> > I don't have specific code path to point to, but I would expect zero page
>> > with non-zero mapcount would cause a problem with rmap.
>> >
>> > How do you test the change?
>> >
>> I just test it to see the mapcount from /proc/pid/pagemap  and /proc/kpagecount ,
>> It works well,
>
> I took a closer look and your patch is broken in multiple places:
>  - on zap_pte_range() you don't decrement mapcount;
>  - you don't update rss counters for mm;
>  - copy_one_pte() doesn't increase mapcount;
>  - ...
>
> Basically, each and every vm_normal_page() call must be audited. As first
> step. And you totally skip huge zero page.
>
> Proper mapcount handling for zero page would require a lot more work and I
> don't think it worth it. Gain is too small.
>
> NAK.
>
>> The problem is that when I see /proc/pid/smaps ,
>> The Rss / Pss don't calculate zero_page map,
>> Because smaps_pte_entry() --> vm_normal_page( ),
>> Will return NULL for zero_page,
>>
>> But when userspace process cat /proc/pid/pagemap  ,
>> It will see zero_page mapped,
>> And will treat as Rss ,
>> This is weird, should we also omit zero_page in /proc/pid/pagemap ?
>> Or add zero_page as Rss in /proc/pid/smaps ?
>>
>> I think we should add zero_page into Rss ,
>> Because it is really mapped into userspace address space.
>> And will let userspace memory analysis more accurate .
>
> It would be easier for userspace to find out pfn of zero page and take it
> into account.
>
> Note: some architectures have multiple zero page due to coloring.
>
> --
>  Kirill A. Shutemov
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
