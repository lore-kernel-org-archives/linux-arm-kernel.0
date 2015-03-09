From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 15:57:12 +0000
Subject: [PATCH v5] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <54F5DC08.1040807@linaro.org>
References: <1424969811-11197-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424969811-11197-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <54F5DC08.1040807@linaro.org>
Message-ID: <20150309155711.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:06:32AM -0500, Jorge Ramirez-Ortiz wrote:
> On 02/26/2015 11:56 AM, Jorge Ramirez-Ortiz wrote:
> > -	chan = dma_request_slave_channel(dev, "tx");
> > +	uap->dma_probed = true;
> > +
> > +	chan = dma_request_slave_channel_reason(uap_dev, "tx");
> > +	if (IS_ERR(chan)) {
> > +		if (PTR_ERR(chan) == -EPROBE_DEFER) {
> > +			dev_info(uap_dev, "DMA driver not ready\n");

I still object to this.

It _can't_ be right that we plaster the kernel console with these
messages when the is a DMA possible, but the DMA driver is a module
which hasn't been loaded yet.

You probably don't realise it, but init daemons tend to open the
console, write their message, and then close it again.  What your
message above means is that each time an init daemon does that, we
get a "DMA driver not ready" message.

IMHO, that is unacceptable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
