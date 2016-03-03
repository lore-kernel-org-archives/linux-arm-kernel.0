From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 3 Mar 2016 17:12:13 +0000
Subject: [PATCH v3 4/4] dmaengine: xilinx_vdma: Use readl_poll_timeout
 instead of do while loop's
In-Reply-To: <20160303152957.GM11154@localhost>
References: <1456495434-11722-1-git-send-email-appanad@xilinx.com>
 <1456495434-11722-4-git-send-email-appanad@xilinx.com>
 <20160303152957.GM11154@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A567A1A@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,


> -----Original Message-----
> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
> owner at vger.kernel.org] On Behalf Of Vinod Koul
> Sent: Thursday, March 03, 2016 9:00 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi; dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3 4/4] dmaengine: xilinx_vdma: Use readl_poll_timeout
> instead of do while loop's
> 
> On Fri, Feb 26, 2016 at 07:33:54PM +0530, Kedareswara rao Appana wrote:
> 
> >  static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)  {
> > -	int loop = XILINX_VDMA_LOOP_COUNT;
> > +	int err = 0;
> > +	u32 val;
> >
> >  	vdma_ctrl_clr(chan, XILINX_VDMA_REG_DMACR,
> > XILINX_VDMA_DMACR_RUNSTOP);
> >
> >  	/* Wait for the hardware to halt */
> > -	do {
> > -		if (vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
> > -		    XILINX_VDMA_DMASR_HALTED)
> > -			break;
> > -	} while (loop--);
> > +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMASR, val,
> > +				      (val & XILINX_VDMA_DMASR_HALTED), 0,
> > +				      XILINX_VDMA_LOOP_COUNT);
> >
> > -	if (!loop) {
> > +	if (err) {
> >  		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
> >  			chan, vdma_ctrl_read(chan,
> XILINX_VDMA_REG_DMASR));
> >  		chan->err = true;
> > @@ -576,18 +579,17 @@ static void xilinx_vdma_halt(struct
> xilinx_vdma_chan *chan)
> >   */
> >  static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)  {
> > -	int loop = XILINX_VDMA_LOOP_COUNT;
> > +	int err = 0;
> 
> why is this initialization required here and other places?

Yes initialization is not required on the other mail you said you already applied this patch series.
Will send a separate patch to fix it.

Regards,
Kedar.

> 
> > +	u32 val;
> >
> >  	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
> > XILINX_VDMA_DMACR_RUNSTOP);
> >
> >  	/* Wait for the hardware to start */
> > -	do {
> > -		if (!(vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
> > -		      XILINX_VDMA_DMASR_HALTED))
> > -			break;
> > -	} while (loop--);
> > +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMASR, val,
> > +				      !(val & XILINX_VDMA_DMASR_HALTED), 0,
> > +				      XILINX_VDMA_LOOP_COUNT);
> >
> > -	if (!loop) {
> > +	if (err) {
> >  		dev_err(chan->dev, "Cannot start channel %p: %x\n",
> >  			chan, vdma_ctrl_read(chan,
> XILINX_VDMA_REG_DMASR));
> >
> > @@ -754,21 +756,17 @@ static void xilinx_vdma_complete_descriptor(struct
> xilinx_vdma_chan *chan)
> >   */
> >  static int xilinx_vdma_reset(struct xilinx_vdma_chan *chan)  {
> > -	int loop = XILINX_VDMA_LOOP_COUNT;
> > +	int err = 0;
> >  	u32 tmp;
> >
> >  	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR,
> XILINX_VDMA_DMACR_RESET);
> >
> > -	tmp = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR) &
> > -		XILINX_VDMA_DMACR_RESET;
> > -
> >  	/* Wait for the hardware to finish reset */
> > -	do {
> > -		tmp = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR) &
> > -			XILINX_VDMA_DMACR_RESET;
> > -	} while (loop-- && tmp);
> > +	err = xilinx_vdma_poll_timeout(chan, XILINX_VDMA_REG_DMACR, tmp,
> > +				      !(tmp & XILINX_VDMA_DMACR_RESET), 0,
> > +				      XILINX_VDMA_LOOP_COUNT);
> >
> > -	if (!loop) {
> > +	if (err) {
> 
> 
> 
> --
> ~Vinod
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in the body
> of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
