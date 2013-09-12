From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 11:39:55 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <523186DF.4070203@freescale.com>
References: <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk> <523186DF.4070203@freescale.com>
Message-ID: <1378982395.2627.416.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 17:18 +0800, Huang Shijie wrote:
> ? 2013?09?11? 19:30, Mark Brown ??:
> > Indeed - what I was wondering was if those opcodes could be requested
> > from the flash driver rather than coded in there.  The driver needs to
> > write the commands to the device but it's not clear to me if it really
> > needs to know the specific commands.
> yes. The driver uses the commands to find the _right_ LUT index, and
> uses the LUT index to
> trigger the controller.
>
> For example, LUT0-LUT3 is used for the READ_STATUS, the driver will
> match the
> 0 index for the NOR's read status operation (0x05), and then the driver
> write 0 to the QSPI_IPCR
> register to trigger the operation.

But why?

Your SPI controller's device driver gets a spi_transfer struct which
(indirectly) comes from the m25p80 *chip* driver. That should contain
appropriate values for tx_nbits and rx_nbits to indicate the mode which
its to be used for this particular command.

All you need to do then is pick a suitable slot in the LUT table, *fill*
the LUTn-LUN(n+3) registers with appropriate values, then write (n/4) to
the QSPI_IPCR register. Or something like that? (Can you provide a URL
for the datasheet for this controller?)

And if this is a command/nbits combination which has recently been used,
of course you can skip the 'write the LUT registers' step and just use
the same index you used last time. Add some LRU scheme to handle *which*
index you use... handwave... 

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/7f84803e/attachment.bin>
