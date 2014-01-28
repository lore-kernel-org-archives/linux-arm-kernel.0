From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jan 2014 17:22:53 +0000
Subject: [PATCH] arm64: setup: report non-optional CPU features
In-Reply-To: <alpine.DEB.2.02.1401271712340.10177@avanbrunt-dt>
References: <alpine.DEB.2.02.1401271712340.10177@avanbrunt-dt>
Message-ID: <20140128172253.GD24617@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:23:41AM +0000, Alex Van Brunt wrote:
> There are a large number of popular applications compiled for ARMv7-A that read
> /proc/cpuinfo to find out what features the CPU has.

ELF_HWCAP should work fine. Which popular applications are these?

> But, when they are run
> on an arm64 kernel, they fail to run. This is because features that were
> optional on ARMv7 or earlier but are not optional on ARMv8-A like Thumb are not
> listed as a CPU feature using the arm64 kernel. To make those applications run,
> the kernel still needs to print the features in the list.
> 
> This patch changes "cat /proc/cpuinfo" from printing:
> 
> Features        : fp asimd
> 
> To printing:
> 
> Features        : fp asimd wp half thumb fastmult vfp edsp neon vfpv3d16 tlsi vfpv4 idiva idivt

That's not correct, the features reported are for the AArch64 mode, it
doesn't make sense to overlap the AArch32 features here. There is
COMPAT_ELF_HWCAP and the bits should be passed correctly to AArch32
binaries.

A solution would be to add a check for personality(current->personality)
== PER_LINUX32 and report cpuinfo in an AArch32 compatible way and based
on COMPAT_ELF_HWCAP.

-- 
Catalin
