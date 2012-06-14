From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 14:45:50 +0300
Subject: [PATCH 04/17] i2c: omap: simplify omap_i2c_ack_stat()
In-Reply-To: <20120614111333.GA31187@n2100.arm.linux.org.uk>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-5-git-send-email-balbi@ti.com>
 <20120614111333.GA31187@n2100.arm.linux.org.uk>
Message-ID: <20120614114546.GP13602@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 14, 2012 at 12:13:33PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 01:20:37PM +0300, Felipe Balbi wrote:
> > stat & BIT(1) is the same as BIT(1), so let's
> > simplify things a bit by removing "stat &" from
> > all omap_i2c_ack_stat() calls.
> 
> This doesn't feel right, and the explanation is definitely wrong.
> 
> "stat & BIT(1)" is not the same as "BIT(1)" _unless_ you're saying that
> stat always has BIT(1) already set.  Can you guarantee that in this code?
> If so, how?
> 
> What happens if you read the status register, and it has bit 1 clear.
> immediately after the read, the status register bit 1 becomes set, and
> then you write bit 1 set (because you've dropped the stat & BIT(1) from
> the code.)
> 
> Is it not going to acknowledge that bit-1-set but because you haven't
> read it, you're going to miss that event?
> 
> This feels like a buggy change to me.

I fail to see that situation would happen with this driver. See what it
does (extremely simplified):

if (stat & NACK) {
	...
	omap_i2c_ack_stat(dev, stat & NACK);
}

if (stat & RDR) {
	...
	omap_i2c_ack_stat(dev, stat & RDR);
}

and so on. The tricky place is only WRT errata handling, for example:

if (*stat & (NACK | AL)) {
	omap_i2c_ack_stat(dev, *stat & (XRDY | XDR));
	...
}

but in this case, the errata says we must clear XRDY and XDR if that
errata triggers, so if they just got enabled or not, it doesn't matter.

Another tricky place is RDR | RRDY (likewise for XDR | XRDY):

if (stat & (RDR | RRDY)) {
	...
	omap_i2c_ack_stat(dev, stat & (RDR | RRDY));
}

again here there will be no issues because those IRQs never fire
simultaneously and one will only after after we have handled the
previous, that's because the same FIFO is used anyway and we won't shift
data into FIFO until we tell the IP "hey, I'm done with the FIFO, you
can shift more data". Right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/db62ffcb/attachment-0001.sig>
