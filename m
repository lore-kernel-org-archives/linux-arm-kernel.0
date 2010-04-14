From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 14 Apr 2010 15:40:02 -0700
Subject: [PATCH 05/11] ARM: add generic PrimeCell interface to COH 901 318
	v5
In-Reply-To: <1270681973-5763-1-git-send-email-linus.walleij@stericsson.com>
References: <1270681973-5763-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <r2re9c3a7c21004141540o90fcbb07ja92dffcd71364f8b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Apr 7, 2010 at 4:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the DMA engine driver for the COH 901 318 used in the
> U300 platform with the generic PrimeCell interface.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?drivers/dma/coh901318.c ? ? | ?146 +++++++++++++++++++++++++++++++++++++++++++
> ?drivers/dma/coh901318_lli.c | ? 78 ++++++++++++++++++++++-
> ?2 files changed, 221 insertions(+), 3 deletions(-)
>
[..]
> diff --git a/drivers/dma/coh901318_lli.c b/drivers/dma/coh901318_lli.c
> index 9f7e0e6..f37db49 100644
> --- a/drivers/dma/coh901318_lli.c
> +++ b/drivers/dma/coh901318_lli.c
> @@ -153,6 +153,39 @@ coh901318_lli_fill_memcpy(struct coh901318_pool *pool,
> ? ? ? ?lli->src_addr = src;
> ? ? ? ?lli->dst_addr = dst;
>
> + ? ? ? /*
> + ? ? ? ?* The DMA hardware will increase its pointer by 1,
> + ? ? ? ?* 2 or 4 bytes at a time depending on configuration.
> + ? ? ? ?* If using som oddly-aligned buffer this will cause

s/som/some/

> + ? ? ? ?* performance problems.
> + ? ? ? ?*/
> +#if 0
> + ? ? ? ctrl_chained &= ~COH901318_CX_CTRL_SRC_BUS_SIZE_MASK;
> + ? ? ? ctrl_eom &= ~COH901318_CX_CTRL_SRC_BUS_SIZE_MASK;
> + ? ? ? ctrl_chained &= ~COH901318_CX_CTRL_DST_BUS_SIZE_MASK;
> + ? ? ? ctrl_eom &= ~COH901318_CX_CTRL_DST_BUS_SIZE_MASK;
> + ? ? ? if (src & 0x01) {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_SRC_BUS_SIZE_8_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_SRC_BUS_SIZE_8_BITS;
> + ? ? ? } else if (src & 0x02) {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_SRC_BUS_SIZE_16_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_SRC_BUS_SIZE_16_BITS;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS;
> + ? ? ? }
> + ? ? ? if (dst & 0x01) {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_DST_BUS_SIZE_8_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_SRC_DST_SIZE_8_BITS;
> + ? ? ? } else if (dst & 0x02) {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_DST_BUS_SIZE_16_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_DST_BUS_SIZE_16_BITS;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? ctrl_chained |= COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS;
> + ? ? ? ? ? ? ? ctrl_eom |= COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS;
> + ? ? ? }
> +#endif

It looks like this bit twiddling code is duplicated three times.  Can
it be moved to a static inline in a header file and hide the #if 0
there as well.  I assume you want it for documentation purposes in
case someone in the future has an unaligned usage model?

--
Dan
