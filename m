From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 1 Mar 2018 09:00:22 +0000
Subject: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return value
 clean up
In-Reply-To: <20180204213624.18288-1-philippe.cornu@st.com>
References: <20180204213624.18288-1-philippe.cornu@st.com>
Message-ID: <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit, Andrzej & Laurent,

May I ask you please your feedback on this small patch?
Many thanks,

Philippe :-)

On 02/04/2018 10:36 PM, Philippe Cornu wrote:
> The readl_poll_timeout() return value is 0 in case of success
> so it is better to detect errors without taking care of the
> return value sign.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 65aeb3f78b48..4d0e8471a15c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -342,7 +342,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>   	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   				 val, !(val & GEN_CMD_FULL), 1000,
>   				 CMD_PKT_STATUS_TIMEOUT_US);
> -	if (ret < 0) {
> +	if (ret) {
>   		dev_err(dsi->dev, "failed to get available command FIFO\n");
>   		return ret;
>   	}
> @@ -353,7 +353,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>   	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   				 val, (val & mask) == mask,
>   				 1000, CMD_PKT_STATUS_TIMEOUT_US);
> -	if (ret < 0) {
> +	if (ret) {
>   		dev_err(dsi->dev, "failed to write command FIFO\n");
>   		return ret;
>   	}
> @@ -385,7 +385,7 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>   		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   					 val, !(val & GEN_PLD_W_FULL), 1000,
>   					 CMD_PKT_STATUS_TIMEOUT_US);
> -		if (ret < 0) {
> +		if (ret) {
>   			dev_err(dsi->dev,
>   				"failed to get available write payload FIFO\n");
>   			return ret;
> @@ -716,13 +716,13 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>   
>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
>   				 val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT_US);
> -	if (ret < 0)
> +	if (ret)
>   		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>   
>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>   				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
>   				 PHY_STATUS_TIMEOUT_US);
> -	if (ret < 0)
> +	if (ret)
>   		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>   }
>   
> 
