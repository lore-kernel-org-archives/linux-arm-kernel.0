From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 9 Feb 2018 18:04:48 +0000
Subject: [PATCH v3 00/21] arm64: Rework cpu capabilities handling
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
Message-ID: <50a7c88f-b8bb-163e-b1c9-919c723fb05c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/18 17:54, Suzuki K Poulose wrote:
> This series reworks the arm64 CPU capabilities handling (which
> manages the system features and errata). The current infrastructure
> doesn't allow fine control for handling different features or errata.
> There is one rule for features and another rule for errata.
> 
> * Features are checked only once, after all the boot time CPUs are
>    activated. Any new CPU that is brought up is prevented from booting
>    if it misses a feature already established. If the new CPU has a
>    feature not enabled already, it is allowed to boot.
> 
> * Errata checks are performed on all the CPUs and any new CPU is
>    OK to miss the capability. However if a late CPU requires a work around,
>    then we fail the CPU.
> 
>    This doesn't always apply to some features. e.g, KPTI is a security
>    feature which should be applied when at least one CPU needs it. So,
>    the tests should be performed on all the booting CPUs individually.
>    Also, if a CPU that needs this security feature is brought up later,
>    when the system has not enabled it, the CPU can boot making the system
>    insecure. Another exception is the hardware DBM for page tables. The
>    kernel can safely run with a mix of CPUs that have the feature turned
>    on and off. This again causes problem when a new CPU is brought up
>    which may not have the feature, which is killed.
> 
>    Also there are other features like, GICV3 system register access,
>    which now need to be enabled very early based on the boot CPU to
>    allow the use of Priority handling to implement NMI.
> 
> This calls for finer level of control per capability and the series
> implements the same by defining how to deal with a conflict of a
> given capability on a CPU with that of the system level state. It
> also consolidates the handling of features and errata into generic
> helpers. The table of features and errata are left as they are to
> allow easier look up for a given type.
> 
> The series also gets rid of duplicate entries for a single capability
> by introducing a wrapper entry which takes care of managing a list
> of entries with distinct matches/enable pair.
> 
> We also cleans up the MIDR range handling and cleans up some of the
> errata checks where the entries were duplicated for checking different
> CPU models. Finally it also implements a work around for Arm Cortex-A55
> erratum 1024718 based on the new infrastructure.
> 
> Applies on arm64 for-next/core. The tree is available at :
> 
> 	git://linux-arm.org/linux-skp.git cpu-cap-rework/v3

Apologies for the mess... obviously I messed up my folder.
If anyone needs the patches for testing, the branch above is sane.

Apologies..
Suzuki
