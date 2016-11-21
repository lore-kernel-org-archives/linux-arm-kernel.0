From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 11:36:14 +0000
Subject: [BUG] i2c-designware silently fails on long transfers
In-Reply-To: <20161121112135.GE1005@e106497-lin.cambridge.arm.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <20161121102901.GF1446@lahna.fi.intel.com>
 <20161121104329.GB1041@n2100.armlinux.org.uk>
 <20161121112135.GE1005@e106497-lin.cambridge.arm.com>
Message-ID: <20161121113614.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 11:21:35AM +0000, Liviu Dudau wrote:
> On Mon, Nov 21, 2016 at 10:43:29AM +0000, Russell King - ARM Linux wrote:
> > It would need to DMA to the Tx FIFO to keep it filled - it triggers the
> > stop condition when the Tx FIFO empties.  From what I can see in the
> > driver, the Tx FIFO not only takes the data but also a "command" to tell
> > the hardware what to do.
> > 
> > The Rx FIFO would also need DMA to avoid it overflowing due to high
> > interrupt latency.
> > 
> > I don't know what state DMA is in on the Juno, or even whether it has
> > DMA - it has a PL330 DMA controller, but I see nothing in the DT files
> > making use of it.
> 
> The only thing we have tested PL330 with was UART and I2S. I'm not sure we
> can really use it with I2C given the above hardware configuration issue.
> 
> The other thing we have tried in our private branches was to repeat the EDID
> transfer a number of times until the checksum was correct. Andrew Jackson
> sent a patch a year or so back to have some ridiculously high number of
> retries (30) and that has been rightfully shut down in the upstream.
> 
> The unfortunate thing is that the monitors and TVs that we use inside ARM
> for testing don't seem to trigger this issue on a regular basis. We had one
> or two small 7" TVs that did that, and the brute force retry of EDID transfer
> sorted them out for the limited use that we had for them.

Due to the way the TDA998x works, it doesn't have much to do with the TV.
The TDA998x is instructed to read up to 128 bytes of EDID data into its
own internal buffer.  It then does so, and raises an interrupt (or we
notice that the interrupt flag is set when there's no hardware interrupt
line), and we then read the EDID data out of the TDA998x.

At the point we're reading from the TDA998x, it has loaded the data from
the DDC bus and the DDC bus is idle... we don't have direct access to
the DDC bus.

The only reason I can think that the checksum would pass is if you were
somehow ending up with data in the buffer that did cause the basic
checksum to pass, even though you had an incomplete read.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
