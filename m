From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 12:17:45 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
References: <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk> <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
Message-ID: <1378984665.2627.423.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 10:56 +0000, Gupta, Pekon wrote:
> 
> And when the spi_transfer reaches spi/.../qspi-controller.c driver, then
> you can populate your LUT with info present in spi_transfer. And initiate
> the actual transfer on SPI bus.

Right. The issue here is that the LUT is currently *pre-populated*, with
an incestuously-"known" set of commands that the slave is expected to
support.

For each "known" command, at controller init time we pick an index in
the LUT, then pre-configure that index to send the command in question.

Then when we're asked to actually *do* a transaction, we hope that it's
one of the "known" ones, look up the right index to use, and just
trigger the transaction.

We shouldn't have that horrid incestuous preconfiguration.

When we get an actual request for a transfer, we should find an unused
slot in the LUT, *write* the appropriate values for the transaction
we're being asked to make, then trigger it.

Obviously the immediate optimisation is to be able to *reuse* LUT
configuration so you're not writing to the LUT over and over again for
the *same* transactions, but let's not overcomplicate things to start
with.

I certainly don't see why we should have the controller knowing in
advance what the commands will be.

(Although hey - if you want to *guess* and prepopulate the LUT with the
most likely options at init time, that would be fine. As long as you can
cope with then being asked to send something unexpected, and rewrite the
LUT as needed.)

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/e8611a17/attachment-0001.bin>
