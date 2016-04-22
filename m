From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Apr 2016 16:23:31 -0700
Subject: [PATCH 6/8] firmware: qcom: scm: Add memory allocation API
In-Reply-To: <1461363432-5730-7-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-7-git-send-email-andy.gross@linaro.org>
Message-ID: <20160422232331.GG3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:

> This patch adds APIs for the scm-32 and scm-64 to use for coherent memory
> allocation.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

This patch must come before the ARM64 implementation.

> ---
>  drivers/firmware/qcom_scm.c | 17 +++++++++++++++++
>  drivers/firmware/qcom_scm.h |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
[..]
> +
> +void qcom_scm_free_buffer(size_t size, void *cpu_addr,
> +				 dma_addr_t dma_addr)
> +{
> +	if (__scm)

This would be quite bad and the caller expects that the memory is
released when you return from here. This should also only happen if the
arch specific implementation is buggy, so just let it go BANG!

> +		dma_free_writecombine(__scm->dev, size, cpu_addr, dma_addr);
> +}
> +

Regards,
Bjorn
