From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Apr 2013 14:21:27 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410104002.GF14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
Message-ID: <20130410132126.GD26992@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Apr 10, 2013 at 11:40:02AM +0100, Russell King - ARM Linux wrote:
> I have just committed a patch to remove the arch/arm/nwfpe code from
> the kernel, and the VFP code emulating the FP operations.

[...]

I just had a play with your for-next branch, and noticed a couple of issues
arising from this:

	1. Removing vfpinstr.h leads to a couple of build failures, as it is
	   still included by arch/arm/kvm/coproc.c (for fmrx, which we should
	   continue to provide) and arch/arm/vfp/vfpmodule.c (similarly, but
	   also fmxr).

	2. vfp.h now contains a bunch of dead function declarations (e.g.
	   vfp_double_normaliseround) which should probably be removed. In
	   fact, the inline functions are unused too, so they could also go.

Will
