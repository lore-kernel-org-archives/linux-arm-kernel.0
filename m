From: robherring2@gmail.com (Rob Herring)
Date: Tue, 15 Nov 2011 17:02:45 -0600
Subject: [PATCH 2/2] ARM: topdown mmap support
In-Reply-To: <alpine.LFD.2.02.1111141316440.3307@xanadu.home>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <1320709421-14469-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141237080.3307@xanadu.home> <4EC15882.7070909@gmail.com>
 <alpine.LFD.2.02.1111141316440.3307@xanadu.home>
Message-ID: <4EC2EF95.4050205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 11/14/2011 12:22 PM, Nicolas Pitre wrote:
> On Mon, 14 Nov 2011, Rob Herring wrote:
> 
>> On 11/14/2011 11:41 AM, Nicolas Pitre wrote:
>>> On Mon, 7 Nov 2011, Rob Herring wrote:
>>>
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Similar to other architectures, this adds topdown mmap support in user
>>>> process address space allocation policy. This allows mmap sizes greater
>>>> than 2GB. This support is largely copied from MIPS and the generic
>>>> implementations.
>>>>
>>>> The address space randomization is moved into arch_pick_mmap_layout.
>>>
>>> This is a problem by effectively weakening the randomization greatly.  
>>> Now you get a random starting point but all mmaps are otherwise fixed 
>>> relative to each other, whereas you had random distances between each 
>>> mmaps before.
>>>
>>
>> You mean within a single process the mmap's are not randomized? 
> 
> With regard to each other: not anymore with your patch.
> 
>> Couldn't that end up wasting a lot of virtual space if you have a lot 
>> of mmaps?
> 
> That is what we have now without this patch.  The Potential for wasted 
> space is 8 bits on a page level, i.e. 1MB max or 512 KB on average, per 
> mmap.  I don't think this is that bad.
> 

No one cared about or noticed this issue until recently. That is
changing as we start to see ARM systems with more memory and I'm sure
we'll see more issues like this. Someone may care that they get less
memory than other 32-bit arches. Can you really trust that apps don't do
a large number of mmaps.

>> It is aligned with other arch's and the generic implementation. The
>> generic implementation doesn't even do randomization for legacy layouts.
> 
> Only x86 does complete ASLR besides ARM.

x86 does not do per mmap randomization. Here's the output of a test
program which does 1 to 23 MB size mmaps in 1MB steps. The gap is the
last address - current address. I'm not sure what's going on with the
2nd mmap gap though, but otherwise the gap matches the mmap size.

mmap at 0x7f74bd1b7000, gap = 42e49000
mmap at 0x7f74bcb1e000, gap = 699000
mmap at 0x7f74bc81e000, gap = 300000
mmap at 0x7f74bc41e000, gap = 400000
mmap at 0x7f74bbf1e000, gap = 500000
mmap at 0x7f74bb91e000, gap = 600000
mmap at 0x7f74bb21e000, gap = 700000
mmap at 0x7f74baa1e000, gap = 800000
mmap at 0x7f74ba11e000, gap = 900000
mmap at 0x7f74b971e000, gap = a00000
mmap at 0x7f74b8c1e000, gap = b00000
mmap at 0x7f74b801e000, gap = c00000
mmap at 0x7f74b731e000, gap = d00000
mmap at 0x7f74b651e000, gap = e00000
mmap at 0x7f74b561e000, gap = f00000
mmap at 0x7f74b461e000, gap = 1000000
mmap at 0x7f74b351e000, gap = 1100000
mmap at 0x7f74b231e000, gap = 1200000
mmap at 0x7f74b101e000, gap = 1300000
mmap at 0x7f74afc1e000, gap = 1400000
mmap at 0x7f74ae71e000, gap = 1500000
mmap at 0x7f74ad11e000, gap = 1600000

My patch exceeds 32-bit x86 functionality which does no randomization
for legacy layouts. It matches 32-bit and 64-bit x86 for topdown layout.

I'm happy to revert the legacy part of my patch, but it's a bit mute
point as legacy is not used by default.

Rob
