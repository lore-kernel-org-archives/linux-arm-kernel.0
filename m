From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Dec 2015 14:47:34 +0000
Subject: [PATCH] cpufreq: tegra: add regulator dependency for T124
In-Reply-To: <5668188F.2080202@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel>
 <5668188F.2080202@nvidia.com>
Message-ID: <20151209144734.GB5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 12:03:27PM +0000, Jon Hunter wrote:
> On 08/12/15 21:52, Arnd Bergmann wrote:

> > My first attempt was to implement a helper for this function
> > for regulator_sync_voltage, but Mark Brown explained:

> >    We don't do this for *all* regulator API functions - there's some where
> >    using them strongly suggests that there is actually a dependency on
> >    the regulator API.  This does seem like it might be falling into the
> >    specialist category [...]
> >    Looking at the code I'm pretty unclear on what the authors think the
> >    use of _sync_voltage() is doing in the first place so it may be even
> >    better to just remove the call.  It seems to have been included in the
> >    first commit so there's not changelog explaining things and there's
> >    no comment either.  I'd *expect* it to be a noop as far as I can see.

> In this sequence we are switching from the DFLL clock source (which
> directly controls the voltage) back to a PLL (which does not control the
> voltage directly). What we want to do is to restore the voltage back to
> the voltage it was operating at before we switched to the DFLL clock
> (which could have changed it).

If changes implemented by the clock driver are trashing the regulator
settings I would expect the clock driver to be responsible for fixing
things up rather than another driver that happens to use the clock.  I'd
also expect some kind of internal documentation explaining what's going
on, and possibly 

> I am not familiar with regulator_sync_voltage() but from the comment it
> does say that it will re-apply the last voltage that was configured for
> the regulator. So I can see what they were doing. The question I have
> is, if the consumer has not explicitly called regulator_set_voltage()
> then what does regulator_sync_voltage() do? I am wondering if we should
> have been doing a regulator_get_voltage() during the probe and a
> regulator_set_voltage() when switching back?

This *is* the sort of thing _sync() is intended for, though it's mainly
expected to be used in cases like suspend where things have been powered
off.  As you can see from the code it's based on the settings that
software made, but then if nothing in software has any need to configure
anything then why do we even care that the hardware changed anything?

Setting the voltage you've read back sounds broken, if the hardware
might randomly change things how do you know the settings we read were
sane?  Shouldn't we know what voltage range the device requires in a
given mode and set that - that's much more normal?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/29aea2c8/attachment.sig>
