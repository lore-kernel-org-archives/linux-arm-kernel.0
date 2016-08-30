From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Aug 2016 11:34:10 -0500
Subject: [PATCH v24 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20160822042832.GJ20080@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015747.28591-1-takahiro.akashi@linaro.org>
 <20160819132641.GA12709@rob-hp-laptop>
 <20160822042832.GJ20080@linaro.org>
Message-ID: <CAL_JsqJ5SqesEL5QWX_NJj+gL2jpne4NN_WzADiH+1VB7CkvOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 11:28 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Rob,
> [Cc: Mark]
>
> On Fri, Aug 19, 2016 at 08:26:41AM -0500, Rob Herring wrote:
>> On Tue, Aug 09, 2016 at 10:57:47AM +0900, AKASHI Takahiro wrote:
>> > From: James Morse <james.morse@arm.com>
>> >
>> > Add documentation for
>> >     linux,crashkernel-base and crashkernel-size,
>> >     linux,usable-memory-range, and
>> >     linux,elfcorehdr
>> > used by arm64 kexec/kdump to decribe the kdump reserved area, and
>> > the elfcorehdr's location within it.
>> >
>> > Signed-off-by: James Morse <james.morse@arm.com>
>> > [takahiro.akashi at linaro.org:
>> >     renamed "usable-memory" to "usable-memory-range",
>> >     added "linux,crashkernel-base" and "-size" ]
>> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
>> >  1 file changed, 50 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>> > index 6ae9d82..236188a 100644
>> > --- a/Documentation/devicetree/bindings/chosen.txt
>> > +++ b/Documentation/devicetree/bindings/chosen.txt
>> > @@ -52,3 +52,53 @@ This property is set (currently only on PowerPC, and only needed on
>> >  book3e) by some versions of kexec-tools to tell the new kernel that it
>> >  is being booted by kexec, as the booting environment may differ (e.g.
>> >  a different secondary CPU release mechanism)
>> > +
>> > +linux,crashkernel-base
>> > +linux,crashkernel-size
>> > +----------------------
>> > +These properties (currently used on PowerPC and arm64) indicates
>> > +the base address and the size, respectively, of the reserved memory
>> > +range for crash dump kernel.
>> > +e.g.
>> > +
>> > +/ {
>> > +   chosen {
>> > +           linux,crashkernel-base = <0x9 0xf0000000>;
>> > +           linux,crashkernel-size = <0x0 0x10000000>;
>> > +   };
>> > +};
>> > +
>> > +linux,usable-memory-range
>> > +-------------------------
>> > +
>> > +This property (currently used only on arm64) holds the memory range,
>> > +the base address and the size, which can be used as system ram on
>> > +the *current* kernel. Note that, if this property is present, any memory
>> > +regions under "memory" nodes in DT blob or ones marked as "conventional
>> > +memory" in EFI memory map should be ignored.
>> > +e.g.
>> > +
>> > +/ {
>> > +   chosen {
>> > +           linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
>> > +   };
>> > +};
>>
>> I've read the discussion on this. I think you should use the existing
>> linux,usable-memory property in the memory nodes. If UEFI systems don't
>> have memory nodes, then you can find an UEFI way to describe this. DT is
>> not the dumping ground for what doesn't fit in UEFI. How do x86 systems
>> work?
>
> Kdump for x86 passes the range of usable memory to crash dump kernel
> either via:
> (a) "memmap=nn at ss" command line parameter, or
> (b) faked BIOS e820 map (a sort of memory map table)
>
> (a) was rejected by Mark [1], and (b) is x86-specific.
>
> I believe that my approach is better because it works in the same way
> either on UEFI systems or DT-based systems.

So we have a new way for both UEFI and DT. If UEFI folks can't come up
with a standard way to do things in the UEFI standard, then we just
dump them into DT? I'd rather see alignment with existing DT systems
(PPC) and in particular the tools.

Rob
