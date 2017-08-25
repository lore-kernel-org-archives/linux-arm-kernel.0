From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 25 Aug 2017 13:16:06 -0300
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <20170825102250.GA3127@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
 <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825102250.GA3127@leverpostej>
Message-ID: <878ti7fws9.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Fri, Aug 25, 2017 at 10:00:59AM +0900, AKASHI Takahiro wrote:
>> On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
>> > On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
>> > > This is a basic purgtory, or a kind of glue code between the two kernel,
>> > > for arm64. We will later add a feature of verifying a digest check against
>> > > loaded memory segments.
>> > > 
>> > > arch_kexec_apply_relocations_add() is responsible for re-linking any
>> > > relative symbols in purgatory. Please note that the purgatory is not
>> > > an executable, but a non-linked archive of binaries so relative symbols
>> > > contained here must be resolved at kexec load time.
>> > > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
>> > > variables now, arch_kexec_apply_relocations_add() can manage more various
>> > > types of relocations.
>> > 
>> > Why does the purgatory code need to be so complex?
>> > 
>> > Why is it not possible to write this as position-independent asm?
>> 
>> I don't get your point, but please note that these values are also
>> re-written by the 1st kernel when it loads the 2nd kernel and so
>> they must appear as globals.
>
> My fear about complexity is that we must "re-link" the purgatory.
>
> I don't understand why that has to be necessary. Surely we can have the
> purgatory code be position independent, and store those globals in a
> single struct purgatory_info that we can fill in from the host?
>
> i.e. similar to what we do for values shared with the VDSO, where we
> just poke vdso_data->field, no re-linking required.

Right. I'm not sure why it is a partially linked object. I believe that
the purgatory could be linked at build time into a PIE executable with
exported symbols for the variables that need to be filled in from the
host.

On some architectures (e.g., powerpc), this would greatly reduce the
number of relocation types that the kernel needs to know how to process.
On x86 it make less of a difference because the partially linked object
already has just a handful of relocation types.

> Otherwise, why can't the purgatory code be written in assembly? AFAICT,
> the only complex part is the hashing code, which I don't beleive is
> strictly necessary.

When I posted a similar series for powerpc with similar changes to
handle a partially linked purgatory in the kernel, Michael Ellerman
preferred to go for a purgatory written in assembly, partially based on
the one from kexec-lite. That purgatory doesn't do the checksum
verification of the segments.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
