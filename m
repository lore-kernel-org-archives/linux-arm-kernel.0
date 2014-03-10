From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Mar 2014 17:22:21 +0000
Subject: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
In-Reply-To: <531DF250.5060100@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk> <531DF250.5060100@ti.com>
Message-ID: <20140310172221.GT28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 12:11:44PM -0500, Nishanth Menon wrote:
> On 03/02/2014 09:54 PM, Mark Brown wrote:
> > On Mon, Feb 24, 2014 at 08:38:07AM -0600, Nishanth Menon wrote:

> >> Intent here is to allow drivers such as cpufreq-cpu0 to be reused on
> >> platforms such as TI's OMAP derivatives, and other SoCs which differ
> >> only by the sequence involved in voltage scale operations. So, this
> >> patch provides a framework for registering the underlying
> >> implementation of the SoC specific voltage change methodology.

> > That bit is clear, what's very opaque from the code is how this is going
> > to be accomplished.

> The SoC specific voltage domain drivers register with
> devm_voltdm_register. the fops provide the abstraction needed for the
> SoC (example in patch #5 - which introduces OMAP specific voltage
> domain which handles ABB and VDD regulators).

> What would you suggest that we do to clarify the usage here?

Probably saying something about this in the commit message would be
enough - mentioning how the registration occurs and that things are
triggered by clock frequency changes.

> > So the first question I have here is what happens if multiple clocks
> > need to be updated in lock step - if we're only triggering off clock
> > notifiers that seems tricky.  The other thing here is that the fact that

> Yes, that is true, however, there are ways to implement them, for
> example: We could implement an higher level clock that takes care of
> the multiple clock node control to handle this kind of scenario.

That seems concerning given the fact that people seem to like describing
their entire clock trees in DT, we shouldn't be putting implementation
stuff there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/5991f6ff/attachment.sig>
