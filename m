From: vbabka@suse.cz (Vlastimil Babka)
Date: Thu, 17 Mar 2016 16:43:48 +0100
Subject: Suspicious error for CMA stress test
In-Reply-To: <56EA77BC.2090702@huawei.com>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
 <56EA77BC.2090702@huawei.com>
Message-ID: <56EAD0B4.2060807@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2016 10:24 AM, Hanjun Guo wrote:
> On 2016/3/17 14:54, Joonsoo Kim wrote:
>> On Wed, Mar 16, 2016 at 05:44:28PM +0800, Hanjun Guo wrote:
>>> On 2016/3/14 15:18, Joonsoo Kim wrote:
>>>> On Mon, Mar 14, 2016 at 08:06:16AM +0100, Vlastimil Babka wrote:
>>>>> On 03/14/2016 07:49 AM, Joonsoo Kim wrote:
>>>>>> On Fri, Mar 11, 2016 at 06:07:40PM +0100, Vlastimil Babka wrote:
>>>>>>> On 03/11/2016 04:00 PM, Joonsoo Kim wrote:
>>>>>>>
>>>>>>> How about something like this? Just and idea, probably buggy (off-by-one etc.).
>>>>>>> Should keep away cost from <pageblock_order iterations@the expense of the
>>>>>>> relatively fewer >pageblock_order iterations.
>>>>>> Hmm... I tested this and found that it's code size is a little bit
>>>>>> larger than mine. I'm not sure why this happens exactly but I guess it would be
>>>>>> related to compiler optimization. In this case, I'm in favor of my
>>>>>> implementation because it looks like well abstraction. It adds one
>>>>>> unlikely branch to the merge loop but compiler would optimize it to
>>>>>> check it once.
>>>>> I would be surprised if compiler optimized that to check it once, as
>>>>> order increases with each loop iteration. But maybe it's smart
>>>>> enough to do something like I did by hand? Guess I'll check the
>>>>> disassembly.
>>>> Okay. I used following slightly optimized version and I need to
>>>> add 'max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1)'
>>>> to yours. Please consider it, too.
>>> Hmm, this one is not work, I still can see the bug is there after applying
>>> this patch, did I miss something?
>> I may find that there is a bug which was introduced by me some time
>> ago. Could you test following change in __free_one_page() on top of
>> Vlastimil's patch?
>>
>> -page_idx = pfn & ((1 << max_order) - 1);
>> +page_idx = pfn & ((1 << MAX_ORDER) - 1);
>
> I tested Vlastimil's patch + your change with stress for more than half hour, the bug
> I reported is gone :)

Oh, ok, will try to send proper patch, once I figure out what to write 
in the changelog :)
