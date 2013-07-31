From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 16:25:23 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731140758.GT2810@htj.dyndns.org>
References: <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <20130731134215.GS2810@htj.dyndns.org>
 <20130731135751.GT9858@sirena.org.uk>
 <20130731140758.GT2810@htj.dyndns.org>
Message-ID: <20130731152523.GW9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 10:07:58AM -0400, Tejun Heo wrote:
> On Wed, Jul 31, 2013 at 02:57:51PM +0100, Mark Brown wrote:

> > That's the only API I've ever heard of doing that.  Everything else is
> > just using it to do deallocation.

> I'm not sure why or what you're trying to argue here but take a look
> at devm_pwm_release() for example.  It calls back into low level
> driver free routine.  Are you arguing that it'd be a good idea to

That the callback is into the driver providing the PWM, not into the
driver that's using the PWM and is releasing it.

> release pci regions before this is complete?  It's just stupid to do
> any differently.  There's nothing to argue about.

What I'm saying is that in essentially all the users I've seen devm is
only being used for things like kfree() or clk_put() which aren't really
connected in any way and can happen in any order.  This (coupled with
the lack of documentation that this is supported) is why people are
nervous about anything that relies on ordering with this stuff - aside
from ATA everything is just using this for straight frees.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/5bc05f02/attachment.sig>
