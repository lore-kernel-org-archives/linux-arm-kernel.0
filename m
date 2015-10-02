From: yitian.bu@tangramtek.com (yitian)
Date: Fri, 2 Oct 2015 09:08:19 +0800
Subject: [alsa-devel] [RESEND PATCH v2 1/1] ASoC: dwc: fix dma
 stop	transferring issue
In-Reply-To: <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
 <20150930182219.GU15635@sirena.org.uk>
 <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
Message-ID: <01a501d0fcae$d47c9d70$7d75d850$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

> From: alsa-devel-bounces at alsa-project.org
> [mailto:alsa-devel-bounces at alsa-project.org] On Behalf Of yitian
> Sent: Thursday, October 1, 2015 10:25 AM
> To: 'Mark Brown' <broonie@kernel.org>
> Cc: alsa-devel at alsa-project.org; wsa at the-dreams.de;
> linux-kernel at vger.kernel.org; Andrew.Jackson at arm.com;
> lgirdwood at gmail.com; tiwai at suse.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop
> transferring issue
> 
> > From: linux-arm-kernel
> > [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> Mark
> > Brown
> > Sent: Thursday, October 1, 2015 2:22 AM
> > To: yitian <yitian.bu@tangramtek.com>
> > Cc: alsa-devel at alsa-project.org; wsa at the-dreams.de;
> > linux-kernel at vger.kernel.org; Andrew.Jackson at arm.com;
> tiwai at suse.com;
> > lgirdwood at gmail.com; perex at perex.cz;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring
> > issue
> >
> > On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:
> > > Designware I2S uses tx empty and rx available signals as the DMA
> > > handshaking signals. during music playing, if XRUN occurs,
> > > i2s_stop() function will be executed and both tx and rx irq are
> > > masked, when music continues to be played, i2s_start() is executed
> > > but both tx and rx irq are not unmasked which cause I2S stop
> > > sending DMA handshaking signal to DMA controller, and it finally
> > > causes music playing will be stopped once XRUN occurs for the first
> > > time.
> >
> > I'm a bit concerned about how this code ever worked given the above
> > description - is there some race condition which allows things to work
> > if we're lucky?
> 
> Hi Mark:
> 
> Thanks for your comments.
> I think maybe two reasons:
> 1. designware I2S IP in my chipset(new design) is using tx empty and rx
> available signal as the DMA handshaking signal, but it may be not true
> for all chipsets. If I2S has separate signal as DMA handshaking signal,
mask
> irq should not impact DMA transfer. But Synopsys's engineer recommend
> us to
> use
> tx and rx irq signal as the DMA handshaking signal, meanwhile we cannot
> find
> separate DMA handshaking signal from designware's IP spec, that's why
> tx/rx
> irq
> will impact DMA transfer.
> 
> 2. I am using a FPGA for test, the cpu frequency of it is only 26MHz, that
> means
> XRUN is very easy to happen on my board. But I guess most of the
> developers
> are using real chipset which can have at least 600MHz frequency so XRUN
> is
> not easy to be reproduced. As my test, No XUN, no this bug...

Do I need to provide anything else for this patch? Thanks.
