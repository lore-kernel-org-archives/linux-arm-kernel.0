From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 13:54:21 +0000
Subject: [PATCH v2 1/2] [ARM] Kirkwood: enhance TCLK detection
In-Reply-To: <1287654149-8743-1-git-send-email-simon@sequanux.org>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287654149-8743-1-git-send-email-simon@sequanux.org>
Message-ID: <20101021135421.GP29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lennert and Nicolas,

This patch is my best attempt to fix the tclk detection. Unfortunately,
I can't test it on machines I don't have.

Let me know if I can do something else.

Simon

On Thu, Oct 21, 2010 at 11:42:28AM +0200, Simon Guinot wrote:
> From: Simon Guinot <sguinot@lacie.com>
> 
> According to the Marvell LSP, the Sample at Reset regiter bit 21 can be
> used to detect TCLK on 6281 and 6282 devices.
> 
> This patch has only been tested on LaCie boards.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> ---
>  arch/arm/mach-kirkwood/common.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 1c82d42..ee99a5a 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -854,10 +854,9 @@ int __init kirkwood_find_tclk(void)
>  
>  	kirkwood_pcie_id(&dev, &rev);
>  
> -	if ((dev == MV88F6281_DEV_ID && (rev == MV88F6281_REV_A0 ||
> -					rev == MV88F6281_REV_A1)) ||
> -	    (dev == MV88F6282_DEV_ID))
> -		return 200000000;
> +	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
> +		if (((readl(SAMPLE_AT_RESET) >> 21) & 1) == 0)
> +			return 200000000;
>  
>  	return 166666667;
>  }
> -- 
> 1.6.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/40fea5a5/attachment.sig>
