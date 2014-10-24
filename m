From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 24 Oct 2014 15:47:09 +0100
Subject: [PATCH 06/10] arm64: Update booting.txt to reserved-memory nodes
In-Reply-To: <20141024141007.GJ24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
 <20141024105432.GE24265@leverpostej>
 <CACxGe6tpKMk7e6OZSG2O-JWGT_jUTE3-4u_4Nn=d4QNccJd+-Q@mail.gmail.com>
 <20141024121844.GG24265@leverpostej>
 <CACxGe6s3W1U_5rz9gpvjxXJQenw21sum6oJ7o1ZhGLmzgN8U4Q@mail.gmail.com>
 <20141024141007.GJ24265@leverpostej>
Message-ID: <CACxGe6vLOSJ9356VtDiGh-E_Xg4mVF7D=aGpUgJBzOBcJvX5rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 3:10 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 24, 2014 at 02:54:02PM +0100, Grant Likely wrote:
>> On Fri, Oct 24, 2014 at 1:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Oct 24, 2014 at 12:04:00PM +0100, Grant Likely wrote:
>> >> On Fri, Oct 24, 2014 at 11:54 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> >
>> >> > On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
>> >> > > Change any reference of device tree '/memreserve/' entries in the arm64
>> >> > > booting.txt to refer to 'reserved-memory nodes'.  Reserved-memory nodes
>> >> > > are the preferred method of specifying reserved memory.
>> >> >
>> >> > Per my comments on patch 5, I don't think this change is sufficient.
>> >> >
>> >> > However, we should probably update the document to allow reserved-memory
>> >> > nodes.
>> >> >
>> >> > On an unrelated note we probably need to work out how reserved-memory
>> >> > interacts with the UEFI memory map -- unmappable regions shouldn't be
>> >> > described by UEFI and I hope people don't use reserved-memory as a
>> >> > workaround for broken UEFI tables.
>> >>
>> >>
>> >> When booting with UEFI, the boot stub will clear out all memory nodes
>> >> and (should) clear out reserved regions so that the kernel can use the
>> >> UEFI memory map as authoritative.
>> >
>> > We clear memory nodes and memreserves currently.
>> >
>> > I was thinking about reserved-memory nodes (for CMA and such), which we
>> > don't currently clear.
>>
>> We should either clear them, or make sure that they will coexist
>> happily with the UEFI map. I can think of a few situations, like CMA,
>> where still having the reserved-memory node would be a good idea.
>
> My thinking would be that reservations which the kernel could choose to
> ignore for whatever reason and use for general allocation (e.g. CMA)
> make sense, but anything else is nonsense if it overlaps with available
> memory in the UEFI memory map -- it shouldn't have been there to begin
> with.
>
> I don't know what the best thing to do in that case is. I'd like to
> explode very loudly during bringup to get vendors to fix their UEFI
> tables, but in the long run we might just have to reconcile the two and
> align with the most stringent requirement. Good luck getting another OS
> working in that case...

On ACPI platforms this is a non-issue. On UEFI+FDT platforms there are
unlikely to be any other operating systems significantly affected by
this.

g.
