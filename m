From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 18 Mar 2016 21:58:35 +0100
Subject: Suspicious error for CMA stress test
In-Reply-To: <1458312126.18134.45.camel@pengutronix.de>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
 <56EA77BC.2090702@huawei.com> <56EAD0B4.2060807@suse.cz>
 <CAAmzW4MNdFHSSTpCfWqy7oDtkR_Hfu2dZa_LW97W8J5vr5m4tg@mail.gmail.com>
 <56EC0C41.70503@suse.cz> <1458312126.18134.45.camel@pengutronix.de>
Message-ID: <56EC6BFB.2020107@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2016 03:42 PM, Lucas Stach wrote:
> Am Freitag, den 18.03.2016, 15:10 +0100 schrieb Vlastimil Babka:
>> On 03/17/2016 04:52 PM, Joonsoo Kim wrote:
>> > 2016-03-18 0:43 GMT+09:00 Vlastimil Babka <vbabka@suse.cz>:
>>
>> OK, here it is. Hanjun can you please retest this, as I'm not sure if you had
>> the same code due to the followup one-liner patches in the thread. Lucas, see if
>> it helps with your issue as well. Laura and Joonsoo, please also test and review
>> and check changelog if my perception of the problem is accurate :)
>>
>
> This doesn't help for my case, as it is still trying to merge pages in
> isolated ranges. It even tries extra hard at doing so.
>
> With concurrent isolation and frees going on this may lead to the start
> page of the range to be isolated merging into an higher order buddy page
> if it isn't already pageblock aligned, leading both test_pages_isolated
> and isolate_freepages to fail on an otherwise perfectly fine range.
>
> What I am arguing is that if a page is freed into an isolated range we
> should not try merge it with it's buddies at all, by setting max_order =
> order. If the range is isolated because want to isolate freepages from
> it, the work to do the merging is wasted, as isolate_freepages will
> split higher order pages into order-0 pages again.
>
> If we already finished isolating freepages and are in the process of
> undoing the isolation, we don't strictly need to do the merging in
> __free_one_page, but can defer it to unset_migratetype_isolate, allowing
> to simplify those code paths by disallowing any merging of isolated
> pages at all.

Oh, I think understand now. Yeah, skipping merging for pages in isolated 
pageblocks might be a rather elegant solution. But still, we would have to check 
buddy's migratetype at order >= pageblock_order like my patch does, which is 
annoying. Because even without isolated merging, the buddy might have already 
had order>=pageblock_order when it was isolated.

So what if isolation also split existing buddies in the pageblock immediately 
when it sets the MIGRATETYPE_ISOLATE on the pageblock? Then we would have it 
guaranteed that there's no isolated buddy - a buddy candidate at order >= 
pageblock_order either has a smaller order (so it's not a buddy) or is not 
MIGRATE_ISOLATE so it's safe to merge with.

Does that make sense?
