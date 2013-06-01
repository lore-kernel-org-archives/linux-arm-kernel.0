From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 1 Jun 2013 18:27:38 +0800
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130531185414.GA19061@schnuecks.de>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <CACVXFVOo6HNXeZ95QqAXU64aAmXXrTVsHJ9TvgirWKOWmwnSfA@mail.gmail.com>
 <20130531185414.GA19061@schnuecks.de>
Message-ID: <CACVXFVMU+pHrtezStKRNzhhJWg7L1NTBQKwhwLe+-9Yh5JhgiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 1, 2013 at 2:54 AM, Simon Baatz <gmbnomis@gmail.com> wrote:
> On Fri, May 31, 2013 at 05:07:22PM +0800, Ming Lei wrote:
>> On Sun, May 12, 2013 at 1:35 PM, Simon Baatz <gmbnomis@gmail.com> wrote:
>> > +void flush_kernel_dcache_page(struct page *page)
>> > +{
>> > +       if (cache_is_vivt() || cache_is_vipt_aliasing()) {
>> > +               struct address_space *mapping;
>> > +
>> > +               mapping = page_mapping(page);
>> > +
>> > +               if (!mapping || mapping_mapped(mapping))
>>
>> It is better to replace mapping_mapped(mapping) with page_mapped(page).
>
> Good point. I did not have the time to look into your proposed change
> for flush_dcache_page() yet.
>
> However, this patch here is a fix for a long standing bug, which
> should also be applied to stable in one form or another.  I would not
> like to mix it with a separate performance improvement.

OK, got it, so you should have added "CC: stable", and it is better to add
the bug fix description in your change log, :-)

>
> But, of course, if we decide to change the respective condition in
> flush_dcache_page(), we should also change it in
> flush_kernel_dcache_page() at the same time (provided this patch gets
> accepted).
>
>> > +                       __flush_kernel_dcache_page(page);
>>
>> I am wondering if I-cache should be flushed here since the user mapping
>> on the page may be executable and I/D coherency should be maintained.
>
> Me too. In fact, I wondered so much that I proposed it myself in a
> previous version of the patch (see [1]) :-) However, this has never
> been part of flush_kernel_dcache_page() and it is not clear whether
> the flush for I/D-cache coherency is really needed here (or in
> flush_dcache_page() for that matter) or whether it is sufficient to
> do it when mapping the page into user space.

After reading cachetlb.txt again, looks your patch is correct, because
this kernel API is called in the situations:

        It is assumed here that the user has no incoherent cached copies
       (i.e. the original page was obtained from a mechanism like
get_user_pages()).

So only flushing kernel mapping for the page is correct if callers of the API
obey the rule.


Thanks,
-- 
Ming Lei
