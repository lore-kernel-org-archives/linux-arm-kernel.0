From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 11 Dec 2017 13:29:16 +0000
Subject: [RESEND PATCH] arm64: v8.4: Support for new floating point
 multiplication variant
In-Reply-To: <4c6d83f1-e8f3-46d7-f3cd-af2db77e3a9c@huawei.com>
References: <1512833322-35503-1-git-send-email-gengdongjiu@huawei.com>
 <20171211115947.GS12608@e103592.cambridge.arm.com>
 <4c6d83f1-e8f3-46d7-f3cd-af2db77e3a9c@huawei.com>
Message-ID: <20171211132914.GJ22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 08:47:00PM +0800, gengdongjiu wrote:
> 
> On 2017/12/11 19:59, Dave P Martin wrote:
> > On Sat, Dec 09, 2017 at 03:28:42PM +0000, Dongjiu Geng wrote:
> >> ARM v8.4 extensions include support for new floating point
> >> multiplication variant instructions to the AArch64 SIMD
> > 
> > Do we have any human-readable description of what the new instructions
> > do?
> > 
> > Since the v8.4 spec itself only describes these as "New Floating
> > Point Multiplication Variant", I wonder what "FHM" actually stands
> > for.
> Thanks for the point out.
> In fact, this feature only adds two instructions:
> FP16 * FP16 + FP32
> FP16 * FP16 - FP32
> 
> The spec call this bit to ID_AA64ISAR0_EL1.FHM, I do not know why it
> will call "FHM", I  think call it "FMLXL" may be better, which can
> stand for FMLAL/FMLSL instructions.

Although "FHM" is cryptic, I think it makes sense to keep this as "FHM"
to match the ISAR0 field name -- we've tended to follow this policy
for other extension names unless there's a much better or more obvious
name available.

For "FMLXL", new instructions might be added in the future that match
the same pattern, and then "FMLXL" could become ambiguous.  So maybe
this is not the best choice.

> > Maybe something like "widening half-precision floating-point multiply
> > accumulate" is acceptable wording consistent with the existing
> > architecture, but I just made that up, so it's not official ;)
> 
> how about something like "performing a multiplication of each FP16
> element of one vector with the corresponding FP16 element of a second
> vector, and to add or subtract this without an intermediate rounding
> to the corresponding FP32 element in a third vector."?

We could have that, I guess.

> > 
> >> instructions set. Let the userspace know about it via a
> >> HWCAP bit and MRS emulation.
> >>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >> My platform supports this feature, so I need to add it.
> >> ---
> >>  Documentation/arm64/cpu-feature-registers.txt | 4 +++-
> >>  arch/arm64/include/asm/sysreg.h               | 1 +
> >>  arch/arm64/include/uapi/asm/hwcap.h           | 1 +
> >>  arch/arm64/kernel/cpufeature.c                | 2 ++
> >>  arch/arm64/kernel/cpuinfo.c                   | 1 +
> >>  5 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
> >> index bd9b3fa..a70090b 100644
> >> --- a/Documentation/arm64/cpu-feature-registers.txt
> >> +++ b/Documentation/arm64/cpu-feature-registers.txt
> >> @@ -110,7 +110,9 @@ infrastructure:
> >>       x--------------------------------------------------x
> >>       | Name                         |  bits   | visible |
> >>       |--------------------------------------------------|
> >> -     | RES0                         | [63-48] |    n    |
> >> +     | RES0                         | [63-52] |    n    |
> >> +     |--------------------------------------------------|
> >> +     | FHM                          | [51-48] |    y    |
> > 
> > You also need to update Documentation/arm64/elf_hwcaps.txt.
> I will update it, thanks for the point out
> 
> > 
> > Otherwise, looks OK.
> Appreciate for your review.

[...]

Cheers
---Dave
