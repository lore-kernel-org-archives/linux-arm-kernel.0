From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Tue, 21 Jun 2016 16:19:38 +0000
Subject: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <20160621154103.GA16910@localhost>
References: <1464765839-29018-1-git-send-email-appanad@xilinx.com>
 <1464765839-29018-2-git-send-email-appanad@xilinx.com>
 <20160607070841.GJ16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160613055012.GC16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B6441@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160615165004.GC16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B6CAD@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160621154103.GA16910@localhost>
Message-ID: <03CA77BA8AF6F1469AEDFBDA1322A7B74A18BAE8@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, June 21, 2016 9:11 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> dan.j.williams at intel.com; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Srikanth
> Vemula <svemula@xilinx.com>; Anirudha Sarangi <anirudh@xilinx.com>;
> Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; dmaengine at vger.kernel.org
> Subject: Re: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine
> driver support
>
> On Thu, Jun 16, 2016 at 07:19:38AM +0000, Appana Durga Kedareswara Rao
> wrote:
> > Hi Vinod,
> >
> >     Thanks for the review...
> >
> > >
> > > On Tue, Jun 14, 2016 at 08:18:09AM +0000, Appana Durga Kedareswara
> Rao
> > > wrote:
> > > > > > Yes it is HW capability. It can be either in simple mode or SG
> > > > > > mode Earlier In the driver this configuration is read from the
> > > > > > device-tree But as per lars and your suggestion moved it as runtime
> config
> > > parameters.
> > > > >
> > > > > If sg mode is available why would anyone _not_ want it?
> > > > >
> > > > > I do not think there is point to have this
> > > >
> > > > You mean always keep the device in SG mode and provide an option
> For
> > > > simple dma mode if user want to use simple DMA mode??
> > >
> > > Yes, why would anyone want to use single if sg is available?
>
> If you have sg mode always enabled, but sg_list is size 1, that its
> essentially a single
>

True. As we said, simple mode ha few additional features like write only
And read only dma. So, if user want then here is the provision.

> Btw SPI is a slave case, not a memcpy!
>

Correct. We are working on slave dma support and will patch to this driver.

> > > > There are few features that are available in the simple DMA mode
> won't
> > > > Available in SG mode like write only DMA , read only DMA mode etc...
> > >
> > > Can you explain what these are, how they are used by clients?
> >
> > Currently it is not implemented but there are cases like,
> >
> > We want to initialize the some region with known value, then write only
> dma helps
> > We want to read dummy data from the fifo, then read only dma helps.
>
> Read will be another transfer, perhpas sg lnegth = 1
>


In sg case, both source and destination locations need to be configured.
In simple dma and read-only mode, only source address is required. Simple
Dma just read the data from source location and discard that data. It will save
Unnecessary write to destination here.

> > Best case is SPI fifo.
>
> Nope
>

Why?


> >
> > >
> > > > > > > > +       chan->config.ratectrl = cfg->ratectrl;
> > > > > > > > +       chan->config.src_issue = cfg->src_issue;
> > > > > > > > +       chan->config.src_burst_len = cfg->src_burst_len;
> > > > > > > > +       chan->config.dst_burst_len = cfg->dst_burst_len;
> > > > > > >
> > > > > > > can you describe these parameters?
> > > > > > ratectl:
> > > > > > Rate control can be independently enabled per channel. When rate
> > > > > > control is enabled, the DMA channel uses the rate control count to
> > > > > > schedule
> > > > > successive data read transactions.
> > > > >
> > > > > And how is this used by client?
> > > >
> > > > When rate control is enabled, ZDMA channel uses the rate control
> count
> > > > To schedule successive data read transactions I mean kind of flow
> > > > control to schedule Transactions at fixed intervals instead of pumping
> > > > the transfers without delay or whenever bus is available
> > > >
> > > > Rate control count register definition (11:0):
> > > > Scheduling interval for SRC AXI transaction, only used if rate control
> > > > is enabled
> > >
> > > Okay, why would anyone want transactions at fixed interval. We are
> talking
> > > about DMA, so please give me transfers without delay or whenever bus
> is
> > > available!
> >
> > Could be that there are certain IPs that requires delay in b/w transactions.
> > Since IP is providing this feature we are exploring it to the user.
>
> I kind of don't agree to that!
>

It's a kind of rate control mechanism. We can aslo use this feature to prioritize other
Channel by deliberately controlling the current channel transfer scheduling.

> >
> > >
> > >
> > > > > > src_issue:
> > > > > > Tells outstanding transaction on SRC.
> > > > >
> > > > > This should be read only then, right?
> > > >
> > > > It is a Read/Write register
> > > > http://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-
> ultrascal
> > > > e-registers.html By default it is configured for Max transactions.
> > > > If user want to limit it they can limit it using this config option.
> > >
> > > And why would they want that?
> >
> > Could be that there are certain IPs that my not support burst operations or
> > May not support all burst lengths it will be helpful.
> > Since IP is providing the feature, we are exploring it to the user.
> >
> > >
> > > > > > Burst_len:
> > > > > > Configures the burst length of the src and dst transfers...
> > > > >
> > > > > Hmmm, but you are on memcpy, so that should be programmed for
> > > throughput?
> > > >
> > > > Yes...
> > >
> > > So max burst lengths then, why would anyone configure lesser?
> >
> > Depends on the destination and source IPs.
>
> Not for memory copy
>

Depends on the system and how source and destination IPs are interconnected.
Sometimes there is a limitation from interconnection also.
Also some flash controllers providing linear access to NAND or NOR memories may
Have limitation in burst length but still user can use memory copy with desired burst
Length.

>
> >
> > >
> > > > > > > How would a client know how to configure them?
> > > > > >
> > > > > > With the default values of the config parameters driver will work.
> > > > >
> > > > > But how will client know what is default!
> > > >
> > > > Default values means IP default state after reset.
> > > > If user not aware of the above parameters also still the driver will work
> for
> > > basic functionality.
> > > > Do you want me to implement one more API get_config so that
> Whenever
> > > > user will call the get_config he will know the default values Of the
> > > > config parameters?
> > >
> > > Looking at above I think we do not warrant programming them. Assume
> defaults
> > > in your driver for performance. Like max burst lengths, Max transactions,
> > > without delay scheduling.
> > >
> > > If you disagree, which is fine, please provide the cases where a client
> would
> > > need to program these to different values.
> >
> > As said above there are use cases for SPI and others but currently we didn't
> tested
> > It.
> >
> > >
> > > > > > If user has specific requirement to change these parameters they
> > > > > > can pass It to the driver using set_config API and all these
> > > > > > parameters are Documented in the include/linux/dma/xilinx_dma.h
> file...
> > > > >
> > > > > Can you give me an example where user would like to do that
> > > >
> > > > I am using customized dma test client.
> > > > There I am calling this set_config API before triggering memcpy/SG
> > > operations.
> > >
> > > Well that is precisely a  problem. The generic applications wont know
> "your"
> > > custom API and will not configure that!
> >
> > As said above, generic application can work with default values.
> > These are not custom parameters and we can say these are the dma
> parameters.
> > i.e we can generalize these and provide it to user as generic API.
>
> No it doesn't make it generic API. With generic API the IP should be usable
> with any generic interface without specfic hoops to go thru. People are
> going to test upstream dmatest on your IP and find it not working or
> degraded perf, so better stick with generic API.
>

By default driver configures the optimized settings and it works with upstream
Dmatest. Even with customized settings it works with dmatest only thing it might
Gain/loss performance but that's up to the configuration user may want.

This dma controller was designed to provide more flexibility to the user by providing
the all possible dma parameters configurable.

Regards,
Punnaiah
> --
> ~Vinod


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
