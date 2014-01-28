From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Tue, 28 Jan 2014 09:48:16 -0800
Subject: [PATCH] arm64: setup: report non-optional CPU features
In-Reply-To: <20140128172253.GD24617@arm.com>
References: <alpine.DEB.2.02.1401271712340.10177@avanbrunt-dt>
 <20140128172253.GD24617@arm.com>
Message-ID: <EE746E6E9AE0D14088A85BFB257DF432374EB56044@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a large number of Android applications that read "/proc/cpuinfo" to determine what CPU features are available. These applications are delivered as binaries and cannot be easily recompiled. Another example of code is the Android NDK framework. It will separately read "/proc/cpuinfo" and parse the "Features" list to get the list of CPU features.

Are there other architectures that report different information in "/proc/cpuinfo" depending on the personality? x86 doesn't. The problem I have with making this conditional on the personality is that CPU's "Features" list should be listing the features of the CPU not the features of the kernel mode. For example, the CPU does have the "thumb" feature even if the personality doesn't use it.

-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Tuesday, January 28, 2014 9:23 AM
To: Alexander Van Brunt
Cc: Will Deacon; Linux ARM Kernel
Subject: Re: [PATCH] arm64: setup: report non-optional CPU features

On Tue, Jan 28, 2014 at 01:23:41AM +0000, Alex Van Brunt wrote:
> There are a large number of popular applications compiled for ARMv7-A 
> that read /proc/cpuinfo to find out what features the CPU has.

ELF_HWCAP should work fine. Which popular applications are these?

> But, when they are run
> on an arm64 kernel, they fail to run. This is because features that 
> were optional on ARMv7 or earlier but are not optional on ARMv8-A like 
> Thumb are not listed as a CPU feature using the arm64 kernel. To make 
> those applications run, the kernel still needs to print the features in the list.
> 
> This patch changes "cat /proc/cpuinfo" from printing:
> 
> Features        : fp asimd
> 
> To printing:
> 
> Features        : fp asimd wp half thumb fastmult vfp edsp neon vfpv3d16 tlsi vfpv4 idiva idivt

That's not correct, the features reported are for the AArch64 mode, it doesn't make sense to overlap the AArch32 features here. There is COMPAT_ELF_HWCAP and the bits should be passed correctly to AArch32 binaries.

A solution would be to add a check for personality(current->personality) == PER_LINUX32 and report cpuinfo in an AArch32 compatible way and based on COMPAT_ELF_HWCAP.

--
Catalin
