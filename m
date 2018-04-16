From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 13:24:26 +0100
Subject: [PATCH v3 3/6] pwm: stm32: add capture support
In-Reply-To: <1522404084-24903-4-git-send-email-fabrice.gasnier@st.com>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180416122426.72lhi3hrk2g7y526@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

> Add support for PMW input mode on pwm-stm32. STM32 timers support
> period and duty cycle capture as long as they have at least two PWM
> channels. One capture channel is used for period (rising-edge), one
> for duty-cycle (falling-edge).
> When there's only one channel available, only period can be captured.
> Duty-cycle is simply zero'ed in such a case.
> 
> Capture requires exclusive access (e.g. no pwm output running at the
> same time, to protect common prescaler).
> Timer DMA burst mode (from MFD core) is being used, to take two
> snapshots of capture registers (upon each period rising edge).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes in v3:
> - update stm32_timers_dma_burst_read() call: don't pass ddata structure,
>   use MFD parent device structure instead since MFD core update.
> 
> Changes in v2:
> - DMA handling has been moved to MFD core. Rework capture routines to
>   use it.
> ---
>  drivers/pwm/pwm-stm32.c          | 176 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-timers.h |  11 +++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 187 insertions(+)

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
