From: boaz@plexistor.com (Boaz Harrosh)
Date: Wed, 27 May 2015 14:52:34 +0300
Subject: [PATCH 0/8] ARM: mvebu: Add support for RAID6 PQ offloading
In-Reply-To: <CAPcyv4i06Mwis_CSrKV1Yo6crD1vrjb9it6RtYdtwbgOOY9a4g@mail.gmail.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>	<CAPcyv4gshyaji2HarAeOg3XOiNnmGwnSOMuFGWpuDu8ZTGg=jw@mail.gmail.com>	<20150513091733.GW10961@lukather>	<CAPcyv4jv=xWHbrO=rKhnWt9zFn8vkhS2J5mJiCBKKwESdUk5tg@mail.gmail.com>	<20150518091454.GP4004@lukather>	<CAPcyv4jbW=B_mYfx5HfKckLYeWctfC-9jYeDf0Z1APvQZfHj6Q@mail.gmail.com>	<20150526094511.GP8557@lukather>
 <CAPcyv4i06Mwis_CSrKV1Yo6crD1vrjb9it6RtYdtwbgOOY9a4g@mail.gmail.com>
Message-ID: <5565B002.5090404@plexistor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 07:31 PM, Dan Williams wrote:
> [ adding Boaz as this discussion has implications for ore_raid ]
> 
<>
>> You're not talking about deprecating it, you're talking about removing
>> it entirely.
> 
> True, and adding more users makes that removal more difficult.  I'm
> willing to help out on the design and review for this work, I just
> can't commit to doing the implementation and testing.
> 
<>

Hi

So for ore_raid, Yes it uses both xor and pq functions, and I expect
that to work also after the API changes.

That said, I never really cared for the HW offload engines of these
APIs. Actually I never met any. On a modern machine I always got
the DCE/MMX kick in or one of the other CPU variants. With preliminary
testing of XOR I got an almost memory speed for xor (read n pages
+ write one) So with multy-core CPUs I fail to see how an HW do
better, memory caching and all. The PQ was not that far behind.

All I need is an abstract API that gives me the best implementation
on any ARCH / configuration. Actually the async_tx API is a pain
and a sync API would make things simple. I do not use the concurrent
async submit, wait later at all. I submit then wait.

So anything you change this to, as long as you keep the wonderful
dce implementation is good with me, just that the code keeps running
after the new API is fine with me.

(And the common structures between XOR and PQ was also nice, but I
 can also use a union, its always either or in ore_raid)

Once you make API changes and modify code, CC me I'll run tests

good luck
Boaz
