From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Oct 2014 10:31:18 +0000
Subject: [PATCH v2 2/3] ARM: vfp: Fix VFPv3 hwcap detection on CPUID
 based cpus
In-Reply-To: <1413294539-22069-3-git-send-email-sboyd@codeaurora.org>
References: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
 <1413294539-22069-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20141027103118.GA8768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Oct 14, 2014 at 02:48:58PM +0100, Stephen Boyd wrote:
> The subarchitecture field in the fpsid register is 7 bits wide on
> ARM CPUs using the CPUID identification scheme, spanning bits 22
> to 16. The topmost bit is used to designate that the
> subarchitecture designer is not ARM when it is set to 1. On
> non-CPUID scheme CPUs the subarchitecture field is only 4 bits
> wide and the higher bits are used to indicate no double precision
> support (bit 20) and the FTSMX/FLDMX format (bits 21-22).
> 
> The VFP support code only looks at bits 19-16 to determine the
> VFP version. On Qualcomm's processors (Krait and Scorpion) we
> should see that we have HWCAP_VFPv3 but we don't because bit 22
> is set to 1 to indicate that the subarchitecture is not
> implemented by ARM and the rest of the bits are left as 0 because
> this is the first subarchitecture that Qualcomm has designed.
> Unfortunately we can't just widen the FPSID subarchitecture
> bitmask to consider all the bits on a CPUID scheme because there
> may be CPUs without the CPUID scheme that have VFP without double
> precision support and then the version would be a very wrong and
> large number. Instead, update the version detection logic to
> consider if the CPU is using the CPUID scheme.
> 
> If the CPU is using CPUID scheme, use the MVFR registers to
> determine what version of VFP is supported. We already do this
> for VFPv4, so do something similar for VFPv3 and look for single
> or double precision support in MVFR0. Otherwise fall back to
> using FPSID to detect VFP suppport on non-CPUID scheme CPUs. We
> know that VFPv3 is only present in CPUs that have support for the
> CPUID scheme so this should be equivalent.

This looks correct to me, but it raises a bigger question about the
suitability of hwcaps for describing features of the instruction set.

With the extended CPUID scheme, there are a whole bunch of different
instruction set features that are reported and bundling arbitrary subsets of
them into hwcaps such as `VFPv4' doesn't feel like the right thing to do in
the long run. It also doesn't seem to match where the architecture is going.

Perhaps it would be better to consider exposing the ID registers to
userspace in some manner? This could be done either via an undef handler, or
using the vdso. We would add a (final) hwcap advertising this cpuid support.
For big/little systems, the kernel would need to expose a suitable subset of
the features (we already have the sanity checking code from Rutland).

I'd certainly like to explore that route for arm64, before we start adding a
bunch of fine-grained capabilities.

Will
