From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 17:05:06 +0000
Subject: [PATCH 4/4] efi/arm64: unmap the kernel while executing UEFI
 services
In-Reply-To: <20180125103131.19168-5-ard.biesheuvel@linaro.org>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
 <20180125103131.19168-5-ard.biesheuvel@linaro.org>
Message-ID: <20180126170505.GE16008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 10:31:31AM +0000, Ard Biesheuvel wrote:
> Now that all UEFI runtime service wrappers ensure that byref
> arguments are moved into the UEFI marshalling buffer (which
> is not part of the kernel mapping), we can proceed and unmap
> the kernel while UEFI runtime service calls are in progress.
> 
> This is done by setting the EPD1 bit and flushing the TLB of
> the local CPU. This makes it independent of KPTI or whether
> non-global mappings are being used.

One snag with this is that it will break SPE, so I'd prefer this behaviour
to be predicated on kpti so that the arm64_kernel_unmapped_at_el0() check
in drivers/perf/arm_spe_pmu.c remains valid.

Will
