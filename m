From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Apr 2016 15:50:46 +0100
Subject: [PATCH v5 0/5] arm64: Fix behavior of maxcpus=n
In-Reply-To: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
References: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160426145046.GB1793@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 03:48:55PM +0100, Suzuki K Poulose wrote:
> This series is an attempt at fixing the maxcpus=n behavior
> on arm64. So far we have disabled hotplugging a CPU > n,
> when maxcpus=n is in effect, due to following reasons.
> 
>  1) Possible cpu feature incompatibilities with the new CPU
>     in heterogeneous systems.
>  2) New CPU requiring an errata work around which was not detected
>     (and the code patched in) at boot time.
>  3) Failure to initialise the PMU in case the supported CPUs are
>     not online while probing the PMU.
> 
> (1) has been mostly solved with our early CPU feature verification
> support. This series tries to address (2) & (3).
> 
> (2) is solved by iterating over the known erratas and checking if
> the new CPU requires an errata not set in the cpu_hwcaps, failing
> which, we kill the CPU. We plan to fix this properly by retaining
> the CPU errata work arounds and apply the required at runtime.
> 
> (3) is ignored and will not be fixed as there is no reliable way of
> knowing if there would be a CPU that will be online to support the
> PMU.
> 
> In the process, also restores the capability to check GIC interface settings
> by the firmware on individual CPUs.
> 
> Tested on Juno with maxcpus=2 (enables A57 cores and A57-PMU) and
> maxcpus=1 (disables both A57 cores and A57-PMU).
> 
> This series applies on aarch64/for-next/core :
> 
> The tree is available here :
> 	git://linux-arm.org/linux-skp.git maxcpus/v5
> 
> Changes since V4:
>  - Address Catalin's comments
>  - Rebased to aarch64 for-next/core
>  - Add Reviewed/Acked bys.

I merged this yesterday onto for-next/core. Please can you check that
I fixed everything up that you expected?

Will
