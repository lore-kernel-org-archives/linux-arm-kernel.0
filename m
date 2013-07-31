From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 09:42:15 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731132708.GQ9858@sirena.org.uk>
References: <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
Message-ID: <20130731134215.GS2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 31, 2013 at 02:27:08PM +0100, Mark Brown wrote:
> It's really only interrupts that affect most devices - if there's DMA or
> anything going on after the remove() then as you said earlier the driver
> is probably doing something wrong.

Hmmm... it depends on the specific driver is converted but if the
deactivation sequence - shutting down of command engine - is also
handled by devm as in libata and if you have non-devres resource free
in the exit path, you have the same problem.  Again, in general,
tearing things down in the order which isn't the reverse of allocation
is a bad idea.  Adhering to the order isn't that hard and will result
in far less craziness in the long term.

Thanks.

-- 
tejun
