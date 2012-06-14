From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jun 2012 12:13:33 +0100
Subject: [PATCH 04/17] i2c: omap: simplify omap_i2c_ack_stat()
In-Reply-To: <1339669250-9183-5-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-5-git-send-email-balbi@ti.com>
Message-ID: <20120614111333.GA31187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:20:37PM +0300, Felipe Balbi wrote:
> stat & BIT(1) is the same as BIT(1), so let's
> simplify things a bit by removing "stat &" from
> all omap_i2c_ack_stat() calls.

This doesn't feel right, and the explanation is definitely wrong.

"stat & BIT(1)" is not the same as "BIT(1)" _unless_ you're saying that
stat always has BIT(1) already set.  Can you guarantee that in this code?
If so, how?

What happens if you read the status register, and it has bit 1 clear.
immediately after the read, the status register bit 1 becomes set, and
then you write bit 1 set (because you've dropped the stat & BIT(1) from
the code.)

Is it not going to acknowledge that bit-1-set but because you haven't
read it, you're going to miss that event?

This feels like a buggy change to me.
