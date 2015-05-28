From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 28 May 2015 11:16:48 +0100
Subject: [PATCH] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
Message-ID: <20150528101641.GA3657@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 11:36:00AM +0200, Michael van der Westhuizen wrote:
> Fixes the TCM initialisation code to handle TCM banks that are
> present but inaccessible due to TrustZone configuration.  This is
> the default case when enabling the non-secure world.  It may also
> be the case that that the user decided to use TCM for TrustZone.
> 
> This change has exposed a bug in handling of TCM where no TCM bank
> was usable (the 0 size TCM case).  This change addresses the
> resulting hang.

The TCM registers in CP15 are not part of the architecture -- behaviour
is IMP DEF in v7.

This is a problem for multiplatform kernels in particular.  In a v6/v7
multiplatform kernel with a TCM-enabled platform built in, it is
unsafe to probe for TCM by accessing these registers if we are running
on v7.  No Undef exception is guaranteed -- anything might happen.

We could add a DT binding for TCM, but it should only describe whether
the CP15 TCM registers are accessible (node present in DT) or not (node
present, but disabled).

For backwards compatiblity with old DTs we could maybe fall back to
unconditional probing for single-platform kernels only, when no tcm
node is present in the DT.

Cheers
---Dave

[...]
