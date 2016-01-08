From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jan 2016 15:33:00 +0000
Subject: [PATCH] arm64: kernel: fix PMUv3 registers unconditional access
In-Reply-To: <1452257667-7967-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1452257667-7967-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20160108153300.GB11228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Fri, Jan 08, 2016 at 12:54:27PM +0000, Lorenzo Pieralisi wrote:
> The Performance Monitors extension is an optional feature of the
> AArch64 architecture, therefore, in order to access Performance
> Monitors registers safely, the kernel should detect the PMUv3 unit
> presence through the ID_AA64DFR0_EL1 register PMUVer field before
> accessing them.
> 
> This patch implements a guard by reading the ID_AA64DFR0_EL1 register
> PMUVer field to detect the PMUv3 presence and prevent accessing PMUv3
> system registers if the Performance Monitors extension is not
> implemented in the core.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> Based on arm64 for-next/perf branch.
> 
> Tested on QEMU and Juno, I checked that the reported PMUVer field
> is correct on both A57 and A53 (ie == 0x1), it should leave behaviour
> unchanged on platforms implementing PMUv3.
> 
>  arch/arm64/kernel/head.S    |  5 +++++
>  arch/arm64/mm/proc-macros.S | 12 ++++++++++++
>  arch/arm64/mm/proc.S        |  4 ++--
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 23cfc08..6146fea 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -512,9 +512,14 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
>  #endif
>  
>  	/* EL2 debug */
> +	mrs	x0, id_aa64dfr0_el1		// Check ID_AA64DFR0_EL1 PMUVer
> +	ubfx	x0, x0, #8, #4
> +	cmp	x0, #1
> +	b.ne	4f				// Skip if no PMUv3 present

This will fail if and when PMUVer gets newer revisions of the PMU
architecture (e.g. value 2 to indicate some extended PMU). It looks like
we should be treating it as a signed 4-bit field, so we can use sbfx to
extract a signed value and then we know the PMU is not present if the
value is (signed) less than 1.

Will
