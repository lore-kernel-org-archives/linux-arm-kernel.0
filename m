From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Mar 2016 20:59:57 +0530
Subject: [PATCH v3 4/4] dmaengine: xilinx_vdma: Use readl_poll_timeout
 instead of do while loop's
In-Reply-To: <1456495434-11722-4-git-send-email-appanad@xilinx.com>
References: <1456495434-11722-1-git-send-email-appanad@xilinx.com>
 <1456495434-11722-4-git-send-email-appanad@xilinx.com>
Message-ID: <20160303152957.GM11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 07:33:54PM +0530, Kedareswara rao Appana wrote:

>  static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)
>  {
> -	int loop = XILINX_VDMA_LOOP_COUNT;
> +	int err = 0;
> +	u32 val;
>  
>  	vdma_ctrl_clr(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RUNSTOP);
>  
>  	/* Wait for the hardware to halt */
> -	do {
> -		if (vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
> -		    XILINX_VDMA_DMASR_HALTED)
> -			break;
> -	} while (loop--);
> +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMASR, val,
> +				      (val & XILINX_VDMA_DMASR_HALTED), 0,
> +				      XILINX_VDMA_LOOP_COUNT);
>  
> -	if (!loop) {
> +	if (err) {
>  		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
>  			chan, vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR));
>  		chan->err = true;
> @@ -576,18 +579,17 @@ static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)
>   */
>  static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
>  {
> -	int loop = XILINX_VDMA_LOOP_COUNT;
> +	int err = 0;

why is this initialization required here and other places?

> +	u32 val;
>  
>  	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RUNSTOP);
>  
>  	/* Wait for the hardware to start */
> -	do {
> -		if (!(vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
> -		      XILINX_VDMA_DMASR_HALTED))
> -			break;
> -	} while (loop--);
> +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMASR, val,
> +				      !(val & XILINX_VDMA_DMASR_HALTED), 0,
> +				      XILINX_VDMA_LOOP_COUNT);
>  
> -	if (!loop) {
> +	if (err) {
>  		dev_err(chan->dev, "Cannot start channel %p: %x\n",
>  			chan, vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR));
>  
> @@ -754,21 +756,17 @@ static void xilinx_vdma_complete_descriptor(struct xilinx_vdma_chan *chan)
>   */
>  static int xilinx_vdma_reset(struct xilinx_vdma_chan *chan)
>  {
> -	int loop = XILINX_VDMA_LOOP_COUNT;
> +	int err = 0;
>  	u32 tmp;
>  
>  	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RESET);
>  
> -	tmp = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR) &
> -		XILINX_VDMA_DMACR_RESET;
> -
>  	/* Wait for the hardware to finish reset */
> -	do {
> -		tmp = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR) &
> -			XILINX_VDMA_DMACR_RESET;
> -	} while (loop-- && tmp);
> +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMACR, tmp,
> +				      !(tmp & XILINX_VDMA_DMACR_RESET), 0,
> +				      XILINX_VDMA_LOOP_COUNT);
>  
> -	if (!loop) {
> +	if (err) {



-- 
~Vinod
