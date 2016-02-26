From: vincent.abriou@st.com (Vincent ABRIOU)
Date: Fri, 26 Feb 2016 09:18:58 +0100
Subject: [PATCH, RESEND] drm/sti: use u32 to store DMA addresses
In-Reply-To: <1456434711-48393-1-git-send-email-arnd@arndb.de>
References: <1456434711-48393-1-git-send-email-arnd@arndb.de>
Message-ID: <56D00A72.10007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


Your patch will be part of the next pull request for the STI driver that 
will be done by the end of next week.

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

On 02/25/2016 10:11 PM, Arnd Bergmann wrote:
> The STi drm driver correctly warns about invalid format strings
> when built with 64-bit dma_addr_t:
>
> sti_hqvdp.c: In function 'sti_hqvdp_vtg_cb':
> sti_hqvdp.c:605:119: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> sti_hqvdp.c: In function 'sti_hqvdp_atomic_update':
> sti_hqvdp.c:931:118: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
>
> This could be changed to using the %pad format string, but that
> does not work when printing an rvalue, so instead I'm changing
> the type in the sti_hqvdp structure to u32, which is what gets
> written into the registers anyway.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/sti/sti_hqvdp.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> I originally submitted this on Tue, 08 Dec 2015, but got no reply,
> so resending the same patch now.
>
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 1d3c3d029603..7818d47bea43 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -349,7 +349,7 @@ struct sti_hqvdp {
>   	unsigned int curr_field_count;
>   	unsigned int last_field_count;
>   	void *hqvdp_cmd;
> -	dma_addr_t hqvdp_cmd_paddr;
> +	u32 hqvdp_cmd_paddr;
>   	struct sti_vtg *vtg;
>   	bool xp70_initialized;
>   };
> @@ -372,8 +372,8 @@ static const uint32_t hqvdp_supported_formats[] = {
>    */
>   static int sti_hqvdp_get_free_cmd(struct sti_hqvdp *hqvdp)
>   {
> -	int curr_cmd, next_cmd;
> -	dma_addr_t cmd = hqvdp->hqvdp_cmd_paddr;
> +	u32 curr_cmd, next_cmd;
> +	u32 cmd = hqvdp->hqvdp_cmd_paddr;
>   	int i;
>
>   	curr_cmd = readl(hqvdp->regs + HQVDP_MBX_CURRENT_CMD);
> @@ -400,8 +400,8 @@ static int sti_hqvdp_get_free_cmd(struct sti_hqvdp *hqvdp)
>    */
>   static int sti_hqvdp_get_curr_cmd(struct sti_hqvdp *hqvdp)
>   {
> -	int curr_cmd;
> -	dma_addr_t cmd = hqvdp->hqvdp_cmd_paddr;
> +	u32 curr_cmd;
> +	u32 cmd = hqvdp->hqvdp_cmd_paddr;
>   	unsigned int i;
>
>   	curr_cmd = readl(hqvdp->regs + HQVDP_MBX_CURRENT_CMD);
> @@ -612,19 +612,21 @@ int sti_hqvdp_vtg_cb(struct notifier_block *nb, unsigned long evt, void *data)
>   static void sti_hqvdp_init(struct sti_hqvdp *hqvdp)
>   {
>   	int size;
> +	dma_addr_t dma_addr;
>
>   	hqvdp->vtg_nb.notifier_call = sti_hqvdp_vtg_cb;
>
>   	/* Allocate memory for the VDP commands */
>   	size = NB_VDP_CMD * sizeof(struct sti_hqvdp_cmd);
>   	hqvdp->hqvdp_cmd = dma_alloc_wc(hqvdp->dev, size,
> -					&hqvdp->hqvdp_cmd_paddr,
> +					&dma_addr,
>   					GFP_KERNEL | GFP_DMA);
>   	if (!hqvdp->hqvdp_cmd) {
>   		DRM_ERROR("Failed to allocate memory for VDP cmd\n");
>   		return;
>   	}
>
> +	hqvdp->hqvdp_cmd_paddr = (u32)dma_addr;
>   	memset(hqvdp->hqvdp_cmd, 0, size);
>   }
>
>
