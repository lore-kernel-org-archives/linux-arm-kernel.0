From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jan 2018 16:29:59 +0000
Subject: [PATCH] arm64: Run enable method for errata work arounds on late
 CPUs
In-Reply-To: <0872cba5-3dcd-3453-947a-481aa0483af0@arm.com>
References: <20180117100556.29270-1-suzuki.poulose@arm.com>
 <20180117122548.GE22781@e103592.cambridge.arm.com>
 <766fe9e9-ff68-c06f-c253-d548a2a3cbcb@arm.com>
 <20180117143816.GF22781@e103592.cambridge.arm.com>
 <0872cba5-3dcd-3453-947a-481aa0483af0@arm.com>
Message-ID: <20180117162959.GI22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 02:52:09PM +0000, Suzuki K Poulose wrote:
> On 17/01/18 14:38, Dave Martin wrote:
> >On Wed, Jan 17, 2018 at 01:22:19PM +0000, Suzuki K Poulose wrote:
> >>On 17/01/18 12:25, Dave Martin wrote:
> >>>On Wed, Jan 17, 2018 at 10:05:56AM +0000, Suzuki K Poulose wrote:

[...]

> >>>>+	for (; caps->matches; caps++) {
> >>>>+		if (cpus_have_cap(caps->capability)) {
> >>>>+			if (caps->enable)
> >>>>+				caps->enable((void *)caps);
> >>>
> >>>Do we really need this cast?
> >>
> >>Yes, otherwise we would be passing a "const *" where a "void *" is expected,
> >>and the compiler warns. Or we could simply change the prototype of the
> >>enable() method to accept a const capability ptr.
> >
> >Hmmm, what is this argument for exactly?  cpufeature.h doesn't explain
> >what it is.
> 
> This was introduced by commit 0a0d111d40fd1 ("arm64: cpufeature: Pass capability
> structure to ->enable callback").
> 
> The idea is to enable multiple entries in the table for a single capability.
> Some capabilities (read errata) could be detected in multiple ways. e.g, different
> MIDR ranges. (e.g, ARM64_HARDEN_BRANCH_PREDICTOR, ARM64_WORKAROUND_QCOM_FALKOR_E1003.
> Now, even though the errata is the same, there might be different work arounds
> for them in each "matching" cases. So, we need the "caps" passed on to the
> enable() method to see if the "specific work around" should be applied
> to the system/CPU (since CPU hwcap could be set by one of the cpu_capabilities
> entry.) (as we invoke enable() for all "available" capabilities.)
> 
> Passing the caps information makes it easier to decide, by using the caps->matches().

This makes sense (it's a common OOP idiom anyway:
object->method(object, ...))

> >
> >Does any enable method use this for anything other than a struct
> >arm64_cpu_capabilities const * ?
> 
> No, we use it only for const struct arm64_cpu_capability *.
> 
> >If not, it would be better to specifiy that.
> 
> Yes, that could be done.

OK, I vote for doing that.

Cheers
---Dave
