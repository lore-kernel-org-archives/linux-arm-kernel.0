From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Aug 2015 15:46:42 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <55C8E12E.6030305@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com>
Message-ID: <20150811144642.GF23307@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 06:36:46PM +0100, Suzuki K. Poulose wrote:
> On 10/08/15 17:06, Catalin Marinas wrote:
> >On Fri, Jul 24, 2015 at 10:43:47AM +0100, Suzuki K. Poulose wrote:
> >>From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> >>
> >>Documentation of the infrastructure
> >>
> >>Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> >
> >The implementation looks fine but I think the main discussion will be
> >around the goal of this feature and the ABI that it introduces. So I'll
> >just write my thoughts on this patch (I could as well have replied to
> >the cover letter).
> >
> >Another question: who's going to use this feature? I know people asked
> >in private but I'd like to have some public statements.
> 
> Right, I am hoping that folks from glibc / JIT / GCC will respond to
> this thread.

Some of them didn't even want to be cc'ed ;)

> >>+ a) Any change to the HWCAPs requires an update to userspace (e.g libc)
> >>+    to detect the new changes, which can take a long time to appear in
> >>+    distributions. Exposing the registers allows applications to get the
> >>+    information without requiring other userspace components to be updated.
> >
> >How does it help if you have a new CPUID field or even a new value in an
> >existing field? Doesn't userspace need to be changed anyway to make use
> >of the new feature? I don't think that's a valid argument.
> 
> Yes, the userspace would need an update to work with the new CPUID field. I understand.
> It is just that, "in the enterprise world" updates to the system libraries provided by
> the distribution might take a bit longer to provide the changes than a software vendor.
> I agree thats not a common case.

What I meant is that for a new CPU feature, the user space needs
updating anyway to make use of (add support for) it, whether it checks
its presence via HWCAP or MRS. Let's say we get new crypto instructions,
existing user space won't even check for it because it doesn't know
there is a new CPUID field (or HWCAP bit).

> >2. We still need features listed in /proc/cpuinfo, at least for humans
> >    reading this file or scripts that can't issue mrs instructions
> 
> Agreed, we still need to provide the features in /proc/cpuinfo. We could do
> this without HWCAP if we decide not to update the list.

I agree, /proc/cpuinfo is doable without HWCAP. But since some software
ends up parsing /proc/cpuinfo anyway, I don't see why we should hide
HWCAP.

> >>+ c) Implementation Defined Features
> >>+    The infrastructure doesn't expose any register which is
> >>+    IMPLEMENTATION DEFINED as per ARMv8-A Architecture and is set to 0.
> >
> >It may be worth adding somewhere the (unwritten; yet) rules of the CPUID
> >fields: original 4-bit signed field is RAZ. When a feature is added or
> >extended, the field is incremented. If an existing feature is removed
> >for which the CPUID field is 0, the field becomes negative (0xf).
> 
> May be I can add it as an 'Notes' section at the end ?

Fine.

> >>+3. Implementation
> >>+--------------------
> >>+
> ...
> >>+The infrastructure emulates only the following system register space:
> >>+	Op0=3, Op1=0, CRn=0
> >>+
> >>+(See Table C5-6 'System instruction encodings for System register accesses'
> >>+ in ARMv8 ARM, for the list of registers).
> >>+
> >>+
> >>+The following rules are applied to the value returned by the infrastructure:
> >>+
> >>+ a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
> >>+ b) The value of a reserved field is set to the reserved value(as
> >>+    defined by the architecture).
> >
> >Do we expose any IMPLEMENTATION DEFINED or reserved field to user?
> 
> We don't. All such fields are marked invisible. The above rules define
> how we fill those 'special' (invisible) fields. We 'emulate' all
> access to the space (as defined above) with Op0=3, Op1=0 & CRn=0.
> Out of this space, there are only a very few 'visible' fields(listed in
> section 4). These rules, define how the values are emulated.

Point b) above is a bit confusing - reserved field is set to the
reserved value. If the reserved value is non-zero, do we expose such
value to user or we return zero as for other invisible fields?

> >>+ c) The value of a field marked as not 'visible', is set to indicate
> >>+    the feature is missing (as defined by the architecture).
> >>+ d) The value of a 'visible' field holds the system wide safe value
> >>+    for the particular feature(except for MIDR_EL1, see section 4)
> >
> >I'm slightly confused by the visible/not-visible definition. GIC for
> >example may be present but we don't want to expose it to user, hence you
> >marked it as "not visible" in the table. But the feature is definitely
> >not missing, it may be present and we just decided not to expose it to
> >EL0 since it is not relevant.
> 
> Thats right. In this case, the userspace will see that 'GIC' is not present
> even though it is available. Btw, the system wide value(exposed to the system
> wide users) could be different from what the user gets. e.g, if all the CPUs
> have GIC system register access, the system view will have 'GIC' available.
> 
> Taking another example to explain rule (d), if all CPUs but one supports CRC32
> instructions, both the system view and the user view will have CRC32 disabled.

OK. I missed the difference between "system wide view" and "user view".
I guess the former is not exposed to user.

As I mentioned in my reply to Ard, we need a HWCAP entry to inform the
user of the MRS emulation. My question is whether to use a single
HWCAP_CPUID or multiple for each ID register (e.g.
HWCAP_ID_AA64ISAR0_EL1 or a shorter HWCAP_ID_ISAR0). The advantage of
the latter is that we can expose new CPUID registers if any of them
appear (or there is a useful feature in a register we don't expose).

-- 
Catalin
