From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 28 May 2010 23:17:19 +0900
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <20100528070937.GW4720@trinity.fluff.org>
References: <20100528023559.GA8174@july>
	<20100528035352.GO4720@trinity.fluff.org>
	<AANLkTikfCdHgzgRjVikeGYg5wK_meh3NyDRCOzs6j6uc@mail.gmail.com>
	<20100528042029.GS4720@trinity.fluff.org>
	<AANLkTimBlk4zAA_dwvENfmhr-bUb3VXRjJ5wsxI76Oih@mail.gmail.com>
	<20100528060223.GU4720@trinity.fluff.org>
	<AANLkTil1lYz4qXtxQF1zjBTUzLHiFvMpKXCKh94kN5-5@mail.gmail.com>
	<20100528070937.GW4720@trinity.fluff.org>
Message-ID: <AANLkTils1sTRga53I_Jxl_IsVbfIRQiFR43kGZrTNMQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 4:09 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, May 28, 2010 at 03:19:43PM +0900, Kyungmin Park wrote:
>> On Fri, May 28, 2010 at 3:02 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Fri, May 28, 2010 at 02:25:41PM +0900, Kyungmin Park wrote:
>> >> On Fri, May 28, 2010 at 1:20 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> >> > On Fri, May 28, 2010 at 01:02:24PM +0900, Kyungmin Park wrote:
>> >> >> On Fri, May 28, 2010 at 12:53 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> >> >> > On Fri, May 28, 2010 at 11:35:59AM +0900, Kyungmin Park wrote:
>> >> >> >> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
>> >> >> >> Assume DMC0 starts with 0x2000'0000 with 128MiB.
>> >> >> >> DMC1 starts with 0x4000'0000 with 128MiB.
>> >> >> >> Note that DMC1 has to start address 0x4000'0000 at least.
>> >> >> >>
>> >> >> >> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
>> >> >> >>
>> >> >> >> To reduce memory waste, the DMC0 start with 0x3000'0000.
>> >> >
>> >> > but you just said DMC0 starts at 0x2... ? Is this reconfigurable via
>> >> > software, if so can it be moved once initialisation si done? how fixed
>> >> > is this?
>> >>
>> >> DMC0 can set the its start address at bootloader, it can range from
>> >> 0x2000'0000 to 0x3fff'ffff.
>> >>
>> >> My goal is that reduce the 256MiB memory area and can use the full
>> >> memory without HIGHMEM and 2G/2G split configuration.
>> >
>> > If I remember correctly, te device has 4x256MiB banks, of which the
>> > population is external on S5PV210 or packaging with the S5PC1xx series.
>> >
>> > On the split situation, is it really that bad to have a 2G/2G split,
>> > are you currently running into a situation where a single process
>> > really needs that much address space (especially given the fact that
>> > there can only ever be 1GiB of real memory in the system)?
>>
>> By reduce the 256MiB memory from 0x2000'0000 to 0x3000'0000,
>> we can use 128MiB + (128MiB hole) + 512MiB without any memory changes
>> and configurations.
>>
>> we got several boards which has 2Gib, 3Gib, and 4Gib. So to use these board
>> with one kernel. it's best way to use 0x3000'0000 and we used it from
>> first time.
>> but the problem is that mainline codes are committed as 0x2000'0000.
>
> ok, but if we change the base to 0x3... then will we end up breaking the
> kernel for someone else? ie, booting on an smdkv210?
>
> I may have been confused with getting the sparsemem support in, as it
> definetly deal with the case of memory holes, I also thought it would
> allow the kernel to run with a non-hole'd virtual memory space.
>
> The current kernel defconfig has 2:2, so not sure why the importance
> of 1:3 split.
>
>> >
>> > On the higmem issue, I don't think we've ever had to bother with HIGMEM
>> > even on a SMDKV210 with 1GiB of memory fitted when we first did the support.
>> >
>> >> >
>> >> >> Hi,
>> >> >>
>> >> >> >
>> >> >> > We should be using SPARSEMEM now, is it not reducing any wastage
>> >> >> > in virtual memory space?
>> >> >>
>> >> >> Please consider the older kernel also. and most systems are designed
>> >> >> for 0x3000'0000.
>> >> >
>> >> > Ok, will a kernel with the base-address set to 0x3... work when loaded
>> >> > on a system with RAM starting at 0x2... ? I'm not sure the answer to this
>> >> > question.
>> >>
>> >> Then can't detect last 2Gib memory, only detect first 2Gib memory at
>> >> kernel 2.6.29.
>> >
>> > Not sure how to deal with this one.
>> >
>> >> >
>> >> > I'd rather try and get one kernel working on all systems with the S5PV210
>> >> > if possible instead of havign to pick which ones have certain base addresses
>> >> >
>> >> >
>> >> >> >
>> >> >> > How will the user change their board to deal with this change to hte
>> >> >> > kernel?
>> >> >>
>> >> >> Now we got the these memory
>> >> >> DMC0 has 128MiB and DMC1 has 512MiB.
>> >> >> Then it uses the memory from 0x2000'0000 to 0x5fff'ffff. it used 1GiB
>> >> >> memory address space.
>> >> >> Of course we can enable thie HIGHMEM but older kernel doesn't support it fully.
>> >> >> Also I hope to use the 3G/1G memory scheme.
>> >> >
>> >> > Given you can only get 1G of real memory into a S5PV210, is it really
>> >> > necessary to go to 3G/1G? What problems are there with 2/2 split?
>> >>
>> >> Right it's best but can't. It's hardware problem. DMC0 has different
>> >> memory with 166MHz and DMC1 has 200MHz
>> >> It can't change it.
>> >
>> > Yes, but that's an allocation issue not a layout issue. Whatever is
>> > allocating pages needs to know to prefer the DMC1 memory.
>>
>> No it's hardware issue. when connect the 166MHz memory we need to
>> async bridge to work on 200MHz.
>> In this case, we can't use DMC0 CS1 for 200MHz memory device. that's
>> reason we put the 4Gib memory to DMC1.
>
> Ok, but you're still giving all the memory to the kernel? If i've
> calculated correctly then the kernel is still in the DMC0 area
> with the 166MHz memory?

Right, kernel located at 0x30xx'xxxx, Is it possible to locate the
kernel at 0x40xx'xxxx and use the 0x30xx'xxxx for free memory. I mean
does the kernel locate in the middle of memory?
If possible, it's best.

One note it's impossible to swap the DMC0 memory to DMC1. it's hardware wired.

Thank you,
Kyungmin Park
>
>> Thank you,
>> Kyungmin Park
>>
>> >
>> >> >
>> >> >> How to you think?
>> >> >
>> >> > I thought that when the s5pv210 was submitted we enabled the SPARSMEM
>> >> > support so that whatever DRAM configuration we could handle it within
>> >> > a single kernel.
>> >>
>> >> I also hope to use single kernel for s5p series. and that's reason I
>> >> hope to change it.
>> >> With some reason. mobile division has different memory types and DMC0
>> >> should be used fixed memory.
>> >> and only DMC1 can modify form 2Gib to 4Gib.
>
> --
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
