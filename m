From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Sep 2013 10:15:32 -0700
Subject: [PATCH v4] dt: update PSCI binding documentation for v0.2
In-Reply-To: <20130920102015.GH17453@e106331-lin.cambridge.arm.com>
References: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
 <CAOesGMjNhYTfPOr5NPEC9GWym-nuFE0hX_6+LW9bTv_E3iXbcQ@mail.gmail.com>
 <20130920102015.GH17453@e106331-lin.cambridge.arm.com>
Message-ID: <CAOesGMid5pgcVD+oCjUr_75tv+C5QtVZt=Vt9kdiT_QPFOrzrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 3:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Sep 20, 2013 at 05:36:51AM +0100, Olof Johansson wrote:
>> Hi,
>
> Hi Olof,
>
>>
>> Just a quick drive-by. Sorry, I don't know the history of previous
>> review cycles.
>>
>>
>> On Thu, Sep 19, 2013 at 2:24 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>> >  Main node optional properties:
>> >
>> > - - cpu_suspend   : Function ID for CPU_SUSPEND operation
>> > + - cpu_suspend[-<32|64]   : Function ID for CPU_SUSPEND operation
>> > +
>> > + - cpu_off                : Function ID for CPU_OFF operation
>> > +
>> > + - cpu_on[-<32|64]        : Function ID for CPU_ON operation
>> > +
>> > + - affinity_info[-<32|64] : Function ID for AFFINITY_INFO operation
>> >
>> > - - cpu_off       : Function ID for CPU_OFF operation
>> > + - migrate[-<32|64]       : Function ID for MIGRATE operation
>> >
>> > - - cpu_on        : Function ID for CPU_ON operation
>> > + - migrate_info_type      : Function ID for MIGRATE_INFO_TYPE operation
>> >
>> > - - migrate       : Function ID for MIGRATE operation
>> > + - migrate_info_up_cpu[-<32|64] : Function ID for MIGRATE_INFO_UP_CPU operation
>> >
>> > + - system_reset           : Function ID for SYSTEM_RESET operation
>> > +
>> > + - system_off             : Function ID for SYSTEM_OFF operation
>>
>> All of these should use dashes instead of underscores.
>
> I also don't like the underscores, but they're an unfortunate historical
> artifact that we can't get rid of (at least for cpu_on, cpu_off, and
> cpu_suspend).

We need to keep those three old ones supported in the driver, but the
newer binding can use dashes instead, as long as the kernel also
handles the old binding.

> Both Xen and kvmtool are already passing DTs to guests which have
> underscores in the property names, so it's both a boot ABI and a
> userspace ABI.

Again, as mentioned on IRC: We've said that bindings are not yet
stable until we lock them down, so we will need to adjust accordingly.
Once we lock them down, they are stable and part of ABI. But we really
don't want to deal with the bad bindings that people came up with
without much review, and that's what the whole idea behind cleaning up
and then locking them down is all about.

> One aim with this update is to ensure that the new binding maintains a
> level of forward compatibility for OSs -- the PSCI 0.2 binding needs to
> be a superset of the existing PSCI binding to allow Xen and KVM to
> provide PSCI 0.2 functionality without sacrificing the ability to boot
> older guests (kvmtool could be given a flag to choose what version of
> PSCI to provide, but I'm not sure that can be done for Xen).

I strongly disagree. The very fact that you don't have the guts to
call it 1.0 or 2.0 means it's nowhere near stable. :) So, let's take
this opportunity to clean up the binding and be done with it. Existing
software that can handle the old binding can do so in the future too,
but new software (and new device trees) should use the newer binding.

> Given that, I'm not sure if it makes sense to force the rest to have
> dashes rather than underscores -- it'll leave the binding more
> inconsistent.

Again, don't mix -- switch everyone over. But make the kernel
implementation handle dashes for the three legacy properties.


>> I also wonder if it would be better to move them into a subnode to
>> keep the namespace a bit cleaner.
>
> For the compatibility reasons above, I don't think we can do this. At
> least the existing IDs (cpu_on, cpu_off, and cpu_suspend) would need to
> be described in the psci node rather than a child.

Again, we can change the binding as long as the kernel and the tools
know what to do with the old bad binding.

>> > +Some functions have have separate IDs for 32-bit and 64-bit calling
>> > +conventions. These separate function IDs are described with function names with
>> > +"-64" and "-32" suffixes (e.g. cpu_on-64). Where a function name does not have
>> > +a suffix, the ID may be used with either calling convention depending on the
>> > +CPU state -- AArch32 callers should use the 32-bit calling convention, and
>> > +AArch64 callers should use the 64-bit calling convention.
>>
>> Why not just make them a possible two-element property with <32 64>,
>> or if only one element, same on both? Seems cleaner.
>
> A 64-bit platform may not have 32-bit call support, and we wouldn't be
> able to describe that with a <32 64> property format. As it is valid for
> a 64-bit OS to make 32-bit calls, we need to not describe a 32-bit call
> ID in that case.

Unless you declare one call id value to mean invalid, and use that to
indicate where it's not supported. Seems slightly cleaner but I'm not
going to pick a fight over it. ;-) Either way is fine.


-Olof
