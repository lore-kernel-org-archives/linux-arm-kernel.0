From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 19 Jan 2015 14:08:59 +0000
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1967130.oYyZRWCcEF@wuerfel>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <3236720.MHeqOodrCV@wuerfel>
 <7dc11ef7ccec49bcb052c30b9aa916c3@BL2FFO11FD044.protection.gbl>
 <1967130.oYyZRWCcEF@wuerfel>
Message-ID: <8a27d97f74e548b6a01487c82b471013@BL2FFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, October 24, 2014 7:29 PM
> To: Appana Durga Kedareswara Rao
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> vinod.koul at intel.com; Srikanth Vemula; linux-kernel at vger.kernel.org;
> Srikanth Thokala; dmaengine at vger.kernel.org; robh+dt at kernel.org; Michal
> Simek; Anirudha Sarangi; grant.likely at linaro.org; dan.j.williams at intel.com
> Subject: Re: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
>
> On Friday 24 October 2014 12:08:26 Appana Durga Kedareswara Rao wrote:
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > On Tuesday 21 October 2014 09:06:13 Appana Durga Kedareswara Rao
> wrote:
> > > > The above mentioned API's  and structures will be used by the dma
> > > > test client driver's to set hardware configuration information.
> > > > The dma client drivers are not mainlined  yet and it is Internally
> > > > used by our git-tree  to test the DMA functionality in loopback .
> > >
> > > I would suggest you add the test driver into the main dmaengine
> > > driver file directly then, so you don't need to export the symbols.
> > > If there are important reasons to keep that as separate files, just
> > > move the header to the drivers/dma/ directory and add the test driver
> there.
> >
> > Sorry I forgot to mention the below things in the mail .The Config
> > API's and structures not only used by the dmaengine driver's but also
> > used by the  various IP's  (Ex: Ethernet driver and SRIO driver these
> > drivers are under development).For example the Ethernet driver is
> > resides under drivers/net/ethernet but it needs to set some specific
> > configuration parameters of the dma that's why created a separate
> > header file for the h/w configurable parameters.
>
> That is a bug in the ethernet driver, and we should not merge such code.
>
> Please fix those drivers before submitting them, so they don't rely on
> additional interfaces beyond what the DMA engine API provides.
>
> If you need something that the common interface is missing, you can send a
> patch to extend the dmaengine core driver, but more likely it already does
> what you need and you are just not using it right.
>

Sorry for the delay in the reply.
We need that header file in the include/linux/ directory for various  reasons.

 As you know the Xilinx DMA's have a set of configurable parameters which we expect the DMA users to take advantage of.

 For example:
 For Axi DMA we have the following parameters that we expect to be commonly used.
 Coalesce count --> Used to configure the coalesce value.
 Delay timer ---> Used to set the delay value.

 We expect the Xilinx AXI Ethernet driver to use the Axi DMA driver in
 near furture. If so, using ethtool, we expect the driver users to play with the above parameters to do performance tuning.

 Hence AxiDMA driver must expose means to change coalese count or delay timer.

 Similarly For Axi VDMA we have the following parameters that will be used by the users of this driver.
 hsize  --> Used to configure number of bytes per line.
 vsize  -->Number of lines per frame.
 stride  --> Number of bytes per line.


 Earlier in the driver we are embedding dma_slave_config into custom
 structs But Lars suggested to modify it. please refer to the below thread for more details.
 http://www.spinics.net/lists/dmaengine/msg00010.html

 And later we thought of creating a separate private member in
 dma_slave_config for sharing additional configuration between slave
 device and dma engine Or a new dma_ctrl_cmd like
 FSLDMA_EXTERNAL_START(http://www.kernelhub.org/?msg=405535&p=2 )

 Finally Vinod was ok with the existing suggestion so we dropped the above thought.

 @Vinod : Could you please comment on this.

Regards,
Kedar.

>       Arnd



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
