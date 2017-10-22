From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun, 22 Oct 2017 09:26:59 +0200
Subject: [PATCH v5 2/2] crypto: stm32 - Support for STM32 CRYP crypto
 module
In-Reply-To: <1508425830-13565-3-git-send-email-fabien.dessenne@st.com>
References: <1508425830-13565-1-git-send-email-fabien.dessenne@st.com>
 <1508425830-13565-3-git-send-email-fabien.dessenne@st.com>
Message-ID: <20171022072659.GB8489@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 05:10:30PM +0200, Fabien Dessenne wrote:
> This module registers block cipher algorithms that make use of the
> STMicroelectronics STM32 crypto "CRYP1" hardware.
> The following algorithms are supported:
> - aes: ecb, cbc, ctr
> - des: ecb, cbc
> - tdes: ecb, cbc
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/crypto/stm32/Kconfig      |    9 +
>  drivers/crypto/stm32/Makefile     |    3 +-
>  drivers/crypto/stm32/stm32-cryp.c | 1172 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1183 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/stm32/stm32-cryp.c
> 
> diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
> +static void stm32_cryp_irq_write_block(struct stm32_cryp *cryp)
> +{
> +	unsigned int i, j;
> +	u32 *src;
> +	u8 d8[4];
> +
> +	src = sg_virt(cryp->in_sg) + _walked_in;
> +
> +	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++) {
> +		if (likely(cryp->total_in >= sizeof(u32))) {
> +			/* Write a full u32 */
> +			stm32_cryp_write(cryp, CRYP_DIN, *src);

Hello

Try also to test your driver with userspace via AF_ALG (libkcapi is a good start).
It should probably crash here.
I have do the same on my first sunxi-ss driver and you should use kmap().

Regards
