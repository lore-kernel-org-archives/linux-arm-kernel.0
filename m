From: broonie@kernel.org (Mark Brown)
Date: Sun, 30 Mar 2014 00:47:03 +0000
Subject: [linux-sunxi] Re: [PATCH v3 06/10] regulator: AXP20x: Add
 support for regulators subsystem
In-Reply-To: <20140329175201.GD3952@localhost.fastwebnet.it>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-7-git-send-email-carlo@caione.org>
 <20140328133934.GQ30768@sirena.org.uk>
 <20140329175201.GD3952@localhost.fastwebnet.it>
Message-ID: <20140330004703.GL21628@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 29, 2014 at 06:52:01PM +0100, Carlo Caione wrote:
> On Fri, Mar 28, 2014 at 01:39:34PM +0000, Mark Brown wrote:

> > This is fairly obviously broken - it's overwriting the normal runtime
> > value, this will disrupt the running system if we want the value we use
> > on suspend is different to the value we want at runtime.

> Ok, silly question: isn't it exactly what we want? Set the voltage for
> the regulator when the system is suspended?

This needs to be done without affecting the current system state - many
PMICs are aware of system suspend and have support for transitioning
into a separate suspend state, this should only be configuring that.  We
may call this function separately to the actual suspend.

> > Think about it - if this was a sane thing to do the core would just do
> > it without needing driver specific code, we already know how to set the
> > voltage for the device.

> I thought it was because some regulators can have specific regs for
> managing the suspend mode.

Right, but if the PMIC doesn't have that feature then it should indicate
that by not implementing the operation and letting the core worry about
how to handle the situation.

> BTW, but then what is the difference between my code and (i.e.) the same
> routine in da9055-regulator.c?

> http://lxr.linux.no/linux+v3.13.5/drivers/regulator/da9055-regulator.c#L276

That's updating the B register set which IIRC is used only in suspend
mode.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140330/924df094/attachment.sig>
