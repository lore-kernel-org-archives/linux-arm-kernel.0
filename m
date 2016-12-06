From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 11:55:08 +0000
Subject: [PATCH 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <1480405463-23165-2-git-send-email-andy.gross@linaro.org>
References: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
 <1480405463-23165-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20161206115507.GD2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, Nov 29, 2016 at 01:44:22AM -0600, Andy Gross wrote:
> This patch adds a quirk parameter to the arm_smccc_smc call.  The quirk
> structure allows for specialized SMC operations due to SoC specific
> requirements.
> 
> This patch also fixes up all the current users of the arm_smccc_smc API.
> 
> This patch and partial implementation was suggested by Will Deacon.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm/kernel/smccc-call.S         |  3 ++-
>  arch/arm/mach-artpec/board-artpec6.c |  2 +-
>  arch/arm64/kernel/asm-offsets.c      |  7 +++++--
>  arch/arm64/kernel/smccc-call.S       |  3 ++-
>  drivers/clk/rockchip/clk-ddr.c       |  6 +++---
>  drivers/devfreq/rk3399_dmc.c         |  6 +++---
>  drivers/firmware/meson/meson_sm.c    |  2 +-
>  drivers/firmware/psci.c              |  2 +-
>  drivers/firmware/qcom_scm-64.c       |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi.c  |  2 +-
>  include/linux/arm-smccc.h            | 18 ++++++++++++++++--
>  11 files changed, 37 insertions(+), 18 deletions(-)

Thanks for respinning this; I'd forgotten about it!

> diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
> index 37669e7..e77950a 100644
> --- a/arch/arm/kernel/smccc-call.S
> +++ b/arch/arm/kernel/smccc-call.S
> @@ -47,7 +47,8 @@ UNWIND(	.fnend)
>  /*
>   * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
>   *		  unsigned long a3, unsigned long a4, unsigned long a5,
> - *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
> + *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
> + *		  struct arm_smccc_quirk *quirk)

I'd not thought of doing it like this -- I envisaged embedding the quirk
structure into arm_smccc_res, but this works too. I wonder if we could avoid
having to pass NULL everywhere if we renamed arm_smccc_{hvc.smc} and added
a default wrapper around them?

For example, rename arm_smccc_smc to __arm_smccc_smc, add a macro called
arm_smccc_smc that passes a NULL argument for the quirk, then finally add
a macro arm_smccc_smc_quirk that takes the additional parameter?

Will
