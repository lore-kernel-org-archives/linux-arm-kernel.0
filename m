From: greg@kroah.com (Greg KH)
Date: Fri, 4 May 2018 15:15:08 -0700
Subject: [PATCH] [stable] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
In-Reply-To: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
References: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180504221508.GD20328@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 11:26:04AM +0100, Suzuki K Poulose wrote:
> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
> 
> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> from an erratum 1024718, which causes incorrect updates when DBM/AP
> bits in a page table entry is modified without a break-before-make
> sequence. The work around is to disable the hardware DBM feature
> on the affected cores. The hardware Access Flag management features
> is not affected.
> 
> The hardware DBM feature is a non-conflicting capability, i.e, the
> kernel could handle cores using the feature and those without having
> the features running at the same time. So this work around is detected
> at early boot time, rather than delaying it until the CPUs are brought
> up into the kernel with MMU turned on. This also avoids other complexities
> with late CPUs turning online, with or without the hardware DBM features.
> 
> Note: The upstream commit is on top of a reworked capability
> infrastructure for arm64 heterogeneous systems, which allows
> handling this later in the boot process. This backport
> is based on the original version of the patch [0]. Folded the 3
> patches into this single commit, removing the unncessary bits.
> 
> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose at arm.com
> 
> Cc: stable at vger.kernel.org # v4.3 to v4.16

This only would apply to the 4.16.y tree.  Can you provide working
backports to 4.14.y, 4.9.y, and 4.4.y so I can queue them up there as
well?

thanks,

greg k-h
