From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 28 May 2010 14:25:41 +0900
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <20100528042029.GS4720@trinity.fluff.org>
References: <20100528023559.GA8174@july>
	<20100528035352.GO4720@trinity.fluff.org>
	<AANLkTikfCdHgzgRjVikeGYg5wK_meh3NyDRCOzs6j6uc@mail.gmail.com>
	<20100528042029.GS4720@trinity.fluff.org>
Message-ID: <AANLkTimBlk4zAA_dwvENfmhr-bUb3VXRjJ5wsxI76Oih@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 1:20 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, May 28, 2010 at 01:02:24PM +0900, Kyungmin Park wrote:
>> On Fri, May 28, 2010 at 12:53 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Fri, May 28, 2010 at 11:35:59AM +0900, Kyungmin Park wrote:
>> >> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
>> >> Assume DMC0 starts with 0x2000'0000 with 128MiB.
>> >> DMC1 starts with 0x4000'0000 with 128MiB.
>> >> Note that DMC1 has to start address 0x4000'0000 at least.
>> >>
>> >> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
>> >>
>> >> To reduce memory waste, the DMC0 start with 0x3000'0000.
>
> but you just said DMC0 starts at 0x2... ? Is this reconfigurable via
> software, if so can it be moved once initialisation si done? how fixed
> is this?

DMC0 can set the its start address at bootloader, it can range from
0x2000'0000 to 0x3fff'ffff.

My goal is that reduce the 256MiB memory area and can use the full
memory without HIGHMEM and 2G/2G split configuration.

>
>> Hi,
>>
>> >
>> > We should be using SPARSEMEM now, is it not reducing any wastage
>> > in virtual memory space?
>>
>> Please consider the older kernel also. and most systems are designed
>> for 0x3000'0000.
>
> Ok, will a kernel with the base-address set to 0x3... work when loaded
> on a system with RAM starting at 0x2... ? I'm not sure the answer to this
> question.

Then can't detect last 2Gib memory, only detect first 2Gib memory at
kernel 2.6.29.

>
> I'd rather try and get one kernel working on all systems with the S5PV210
> if possible instead of havign to pick which ones have certain base addresses
>
>
>> >
>> > How will the user change their board to deal with this change to hte
>> > kernel?
>>
>> Now we got the these memory
>> DMC0 has 128MiB and DMC1 has 512MiB.
>> Then it uses the memory from 0x2000'0000 to 0x5fff'ffff. it used 1GiB
>> memory address space.
>> Of course we can enable thie HIGHMEM but older kernel doesn't support it fully.
>> Also I hope to use the 3G/1G memory scheme.
>
> Given you can only get 1G of real memory into a S5PV210, is it really
> necessary to go to 3G/1G? What problems are there with 2/2 split?

Right it's best but can't. It's hardware problem. DMC0 has different
memory with 166MHz and DMC1 has 200MHz
It can't change it.

>
>> How to you think?
>
> I thought that when the s5pv210 was submitted we enabled the SPARSMEM
> support so that whatever DRAM configuration we could handle it within
> a single kernel.

I also hope to use single kernel for s5p series. and that's reason I
hope to change it.
With some reason. mobile division has different memory types and DMC0
should be used fixed memory.
and only DMC1 can modify form 2Gib to 4Gib.

Thank you,
Kyungmin Park
