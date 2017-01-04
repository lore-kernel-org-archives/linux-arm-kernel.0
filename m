From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 4 Jan 2017 13:30:00 +0000
Subject: [PATCH v3 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <df3662de-fa3b-b33e-ebf5-88802aea5c49@synopsys.com>
References: <1483512847-25710-1-git-send-email-appanad@xilinx.com>
 <1483512847-25710-3-git-send-email-appanad@xilinx.com>
 <df3662de-fa3b-b33e-ebf5-88802aea5c49@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A66087E@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

	Thanks for the review...
> 
> Hi Kedar,
> 
> 
> On 04-01-2017 06:54, Kedareswara rao Appana wrote:
> > When VDMA is configured for more than one frame in the h/w for example
> > h/w is configured for n number of frames and user Submits n number of
> > frames and triggered the DMA using issue_pending API.
> > In the current driver flow we are submitting one frame at a time but
> > we should submit all the n number of frames at one time as the h/w Is
> > configured for n number of frames.
> >
> > This patch fixes this issue.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> 
> Looks fine. I have a couple of minor comments, if you address them you can add
> "Reviewed-by: Jose Abreu <joabreu@synopsys.com>"
> in next version.

Thanks...
Sure will fix the comments and will add your' s Reviewed-by....

[snip]
> > +	/*
> > +	 * Note: When VDMA is built with default h/w configuration
> > +	 * On the S2MM(recv) side user should submit frames upto
> > +	 * H/W configured. If users submits less than h/w configured
> > +	 * VDMA engine tries to write to a invalid location
> > +	 * Results undefined behaviour/memory corruption.
> > +	 *
> > +	 * If user would like to submit frames less than h/w capable
> > +	 * On S2MM side please enable debug info 13 at the h/w level
> > +	 * It will allows the frame buffers numbers to be modified at runtime.
> > +	 */
> > +	if (!chan->has_fstoreconfig && chan->direction == DMA_DEV_TO_MEM
> &&
> > +	    chan->desc_pendingcount < chan->num_frms) {
> > +		dev_dbg(chan->dev, "Frame Store Configuration is not enabled
> at the");
> > +		dev_dbg(chan->dev, " H/w level enable Debug info 13 at the
> h/w level");
> > +		dev_dbg(chan->dev, " OR Submit the frames upto h/w
> Capable\n\r");
> > +
> > +		return;
> > +	}
> 
> Hmm, may dev_warn would be more suitable because with dev_dbg and no
> dynamic debug enabled user will not know what happened. Also, I am aware
> that in direction DMA_MEM_TO_DEV there will be no corruption in PC side but it
> will be corruption in VDMA side because it will read from invalid memory
> locations. Maybe drop the check for channel direction.

Sure will fix it in the next version....

> 
> I am also not fancy about dropping prints that are not grep'able (you do not
> break line in each print so a user searching for the whole string will not find it).
> Try to do a line break in each print or change the string to be smaller.
> 

Sure will add a line break in each print in the next version...

Regards,
Kedar.

> Best regards,
> Jose Miguel Abreu
> 
