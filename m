From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 15:03:16 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130912134345.GQ29403@sirena.org.uk>
References: <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk> <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
 <1378987323.2627.429.camel@shinybook.infradead.org>
 <20130912134345.GQ29403@sirena.org.uk>
Message-ID: <1378994596.2627.449.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 14:43 +0100, Mark Brown wrote:
> 
> > I only know what's in the patch that you have also received, but it
> > seems to be a table of commands. To send a given command to the flash,
> > you write the actual command to the some slot in the LUT, then 'trigger'
> > it by writing its index to another register.
> 
> OK, so the LUT itself isn't a generic mtd thing, though the commands
> it's apparently sending are?

Kind of.

Imagine you have a controller with a set of SRAM buffers for transmit
data.

One might normally imagine that when you get a request to make a
transaction, you'd load the data-to-be-sent into one of the buffers,
then trigger a "send from buffer <X>".

Not so in this case. The controller driver appears "know", in advance,
what commands are going to be sent. It preloads its buffers (the LUT)
with what it *expects* us to send, and when we make a request it'll just
trigger a send from the appropriate buffer. And it will crap itself if
we actually try to send anything *different*.

Or so I understand it.

So to go back to your question: the commands that it "knows" we are
going to send are indeed specific to (one particular type of) SPI NOR
flash. But there's nothing on the MTD side which justifies that
assumption. Even if you use a different type of SPI NOR flash which uses
different opcodes for its commands, this broken scheme will fall over.

Unless, as I say, I've completely misunderstood what's going on here.
Huang?

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/61d78a7d/attachment-0001.bin>
