From: james.morse@arm.com (James Morse)
Date: Wed, 14 Dec 2016 11:16:17 +0000
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com>
Message-ID: <58512A01.70101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 14/12/16 10:12, Pratyush Anand wrote:
> On Wednesday 14 December 2016 03:08 PM, Pratyush Anand wrote:
>>> I would go as far as to generate the page tables at 'kexec -l' time,
>>> and only if
>>
>> Ok..So you mean that I create a new section which will have page table
>> entries mapping physicalmemory represented by remaining section, and
>> then purgatory can just enable mmu with page table from that section,
>> right? Seems doable. can do that.
> 
> I see a problem here. If we create  page table as a new segment then, how can we
> verify in purgatory that sha for page table is correct? We need page table
> before sha verification start,and we can not rely the page table created by
> first kernel until it's sha is verified. So a chicken-egg problem.

There is more than one of those! What happens if your sha256 calculation code is
corrupted? You have to run it before you know. The same goes for all the
purgatory code.

This is why I think its better to do this in the kernel before we exit to
purgatory, but obviously that doesn't work for kdump.


> I think, creating page table will just take fraction of second and should be
> good even in purgatory, What do you say?

If it's for kdump its best-effort. I think its easier/simpler to generate and
debug them at 'kexec -l' time, but if you're worried about the increased area
that could be corrupted then do it in purgatory.


Thanks,

James
