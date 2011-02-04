From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Feb 2011 16:16:42 +0300
Subject: [PATCH v2 2/3] Kirkwood: enable PCIe before reading device ID
	register
In-Reply-To: <1296684971-10577-2-git-send-email-ecc@cmu.edu>
References: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
	<1296684971-10577-2-git-send-email-ecc@cmu.edu>
Message-ID: <4D4BFC3A.9060505@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-02-2011 1:16, Eric Cooper wrote:

> PCIe may have been disabled (by kirkwood_clock_gate)
> if this kernel was started by kexec.  Make sure PCIe
> is enabled before attempting to access the device ID
> register, otherwise the system will hang.

> Signed-off-by: Eric Cooper<ecc@cmu.edu>
[...]

> diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
> index 513ad31..ca294ff 100644
> --- a/arch/arm/mach-kirkwood/pcie.c
> +++ b/arch/arm/mach-kirkwood/pcie.c
> @@ -18,8 +18,16 @@
>   #include<mach/bridge-regs.h>
>   #include "common.h"
>
> +void kirkwood_enable_pcie(void)
> +{
> +	u32 curr = readl(CLOCK_GATING_CTRL);

    An empty line wouldn't hurt here...

> +	if (!(curr&  CGC_PEX0))
> +		writel(curr | CGC_PEX0, CLOCK_GATING_CTRL);
> +}
> +

WBR, Sergei
