From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 10:00:09 +0100
Subject: [PATCH v2] serial: pl011: Add Device Tree support to request
 DMA channels
In-Reply-To: <20130418083922.GC3137@gmail.com>
References: <1366272857-14038-1-git-send-email-lee.jones@linaro.org>
 <20130418081811.GF14496@n2100.arm.linux.org.uk>
 <20130418083922.GC3137@gmail.com>
Message-ID: <20130418090008.GG14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 09:39:22AM +0100, Lee Jones wrote:
> On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:
> > This suffers the same problem with your MMCI patch.  If you're using DT and
> > don't provide the DMA information, you get errors printed.  That's not on
> > for an optional driver feature, especially when that feature causes
> > functional difficulties on various platforms and so is _purposely_ omitted.
> 
> How does that differ from using pdata and not passing DMA information?

If you have pdata but no DMA information then, this gets triggered:

        if (!plat || !plat->dma_filter) {
                dev_info(uap->port.dev, "no DMA platform data\n");
                return;
        }

However, with your change, this becomes:

	if (!(plat && plat->dma_filter) && !np) {
		dev_info(uap->port.dev, "no DMA platform data or DT\n");
		return;
	}

wihch means it is _unconditionally_ bypassed if there is a DT node.  So,
if the MMC device has been created from DT, we will drop through to the
following code irrespective of whether there is any DMA data passed.
Hence, we get to here unconditionally in the DT case:

	chan = dma_request_slave_channel_compat(mask,
				(plat) ? plat->dma_filter : NULL,
				(plat) ? plat->dma_tx_param : NULL,
				uap->port.dev, "tx");
	if (!chan) {
		dev_err(uap->port.dev, "no TX DMA channel!\n");
		return;

and if the DT transmit DMA information is not provided, chan will be NULL,
which means we produce an error level "no TX DMA channel!" message.  That
message is supposed to indicate only when it has not been possible to
request the channel, not when there has been no DMA information provided.

This is where AMBA drivers differ from the majority of other drivers -
DMA is *strictly* optional for them, and that must remain the case as long
as we have platforms where AMBA devices are not hooked up to DMA engines
or where the DMA engines they are hooked up to are buggy, or the entire
DMA design (PL08x connected to PL18x) is buggy.
