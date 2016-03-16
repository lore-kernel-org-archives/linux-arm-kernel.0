From: vbabka@suse.cz (Vlastimil Babka)
Date: Wed, 16 Mar 2016 13:03:21 +0100
Subject: Suspicious error for CMA stress test
In-Reply-To: <CAAmzW4OKQHJ06Bi86jqVFGxqWsW7h_EWeGPAFB9K1aY754C4aQ@mail.gmail.com>
References: <56D93ABE.9070406@huawei.com>
 <20160307043442.GB24602@js1304-P5Q-DELUXE> <56DD38E7.3050107@huawei.com>
 <56DDCB86.4030709@redhat.com> <56DE30CB.7020207@huawei.com>
 <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E6AED1.6060703@suse.cz>
 <CAAmzW4OKQHJ06Bi86jqVFGxqWsW7h_EWeGPAFB9K1aY754C4aQ@mail.gmail.com>
Message-ID: <56E94B89.80706@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 03:10 PM, Joonsoo Kim wrote:
> 2016-03-14 21:30 GMT+09:00 Vlastimil Babka <vbabka@suse.cz>:
>
> Now I see why this happen. I enabled CONFIG_DEBUG_PAGEALLOC
> and it makes difference.
>
> I tested on x86_64, gcc (Ubuntu 4.8.4-2ubuntu1~14.04.1) 4.8.4.
>
> With CONFIG_CMA + CONFIG_DEBUG_PAGEALLOC
> ./scripts/bloat-o-meter page_alloc_base.o page_alloc_vlastimil_orig.o
> add/remove: 0/0 grow/shrink: 2/0 up/down: 510/0 (510)
> function                                     old     new   delta
> free_one_page                               1050    1334    +284
> free_pcppages_bulk                          1396    1622    +226
>
> ./scripts/bloat-o-meter page_alloc_base.o page_alloc_mine.o
> add/remove: 0/0 grow/shrink: 2/0 up/down: 351/0 (351)
> function                                     old     new   delta
> free_one_page                               1050    1230    +180
> free_pcppages_bulk                          1396    1567    +171
>
>
> With CONFIG_CMA + !CONFIG_DEBUG_PAGEALLOC
> (pa_b is base, pa_v is yours and pa_m is mine)
>
> ./scripts/bloat-o-meter pa_b.o pa_v.o
> add/remove: 0/0 grow/shrink: 1/1 up/down: 88/-23 (65)
> function                                     old     new   delta
> free_one_page                                761     849     +88
> free_pcppages_bulk                          1117    1094     -23
>
> ./scripts/bloat-o-meter pa_b.o pa_m.o
> add/remove: 0/0 grow/shrink: 2/0 up/down: 329/0 (329)
> function                                     old     new   delta
> free_one_page                                761    1031    +270
> free_pcppages_bulk                          1117    1176     +59
>
> Still, it has difference but less than before.
> Maybe, we are still using different configuration. Could you
> check if CONFIG_DEBUG_VM is enabled or not? In my case, it's not

It's disabled here.

> enabled. And, do you think this bloat isn't acceptable?

Well, it is quite significant. But given that Hanjun sees the errors 
still, it's not the biggest issue now :/

> Thanks.
>
