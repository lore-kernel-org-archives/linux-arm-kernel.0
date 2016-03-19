From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 19 Mar 2016 15:24:28 +0800
Subject: Suspicious error for CMA stress test
In-Reply-To: <56EC0C41.70503@suse.cz>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
 <56EA77BC.2090702@huawei.com> <56EAD0B4.2060807@suse.cz>
 <CAAmzW4MNdFHSSTpCfWqy7oDtkR_Hfu2dZa_LW97W8J5vr5m4tg@mail.gmail.com>
 <56EC0C41.70503@suse.cz>
Message-ID: <56ECFEAC.3010606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/18 22:10, Vlastimil Babka wrote:
> On 03/17/2016 04:52 PM, Joonsoo Kim wrote:
>> 2016-03-18 0:43 GMT+09:00 Vlastimil Babka <vbabka@suse.cz>:
>>>>>>> Okay. I used following slightly optimized version and I need to
>>>>>>> add 'max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1)'
>>>>>>> to yours. Please consider it, too.
>>>>>> Hmm, this one is not work, I still can see the bug is there after
>>>>>> applying
>>>>>> this patch, did I miss something?
>>>>> I may find that there is a bug which was introduced by me some time
>>>>> ago. Could you test following change in __free_one_page() on top of
>>>>> Vlastimil's patch?
>>>>>
>>>>> -page_idx = pfn & ((1 << max_order) - 1);
>>>>> +page_idx = pfn & ((1 << MAX_ORDER) - 1);
>>>>
>>>> I tested Vlastimil's patch + your change with stress for more than half
>>>> hour, the bug
>>>> I reported is gone :)
>>>
>>> Oh, ok, will try to send proper patch, once I figure out what to write in
>>> the changelog :)
>> Thanks in advance!
>>
> OK, here it is. Hanjun can you please retest this, as I'm not sure if you had

I tested this new patch with stress for more than one hour, and it works!
Since Lucas has comments on it, I'm willing to test further versions if needed.

One minor comments below,

> the same code due to the followup one-liner patches in the thread. Lucas, see if
> it helps with your issue as well. Laura and Joonsoo, please also test and review
> and check changelog if my perception of the problem is accurate :)
>
> Thanks
>
[...]
> +	if (max_order < MAX_ORDER) {
> +		/* If we are here, it means order is >= pageblock_order.
> +		 * We want to prevent merge between freepages on isolate
> +		 * pageblock and normal pageblock. Without this, pageblock
> +		 * isolation could cause incorrect freepage or CMA accounting.
> +		 *
> +		 * We don't want to hit this code for the more frequent
> +		 * low-order merging.
> +		 */
> +		if (unlikely(has_isolate_pageblock(zone))) {

In the first version of your patch, it's

+		if (IS_ENABLED(CONFIG_CMA) &&
+				unlikely(has_isolate_pageblock(zone))) {

Why remove the IS_ENABLED(CONFIG_CMA) in the new version?

Thanks
Hanjun
