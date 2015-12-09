From: broonie@kernel.org (Mark Brown)
Date: Wed, 9 Dec 2015 20:10:07 +0000
Subject: [PATCH] cpufreq: tegra: add regulator dependency for T124
In-Reply-To: <566865ED.3020106@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel> <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk> <566865ED.3020106@nvidia.com>
Message-ID: <20151209201007.GG5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 05:33:33PM +0000, Jon Hunter wrote:
> On 09/12/15 14:47, Mark Brown wrote:

> > If changes implemented by the clock driver are trashing the regulator
> > settings I would expect the clock driver to be responsible for fixing
> > things up rather than another driver that happens to use the clock.  I'd
> > also expect some kind of internal documentation explaining what's going
> > on, and possibly 

> Yes, the DFLL clock driver could restore the voltage, however, that
> does not guarantee that the voltage is still sufficient for the other
> clock source.

But the code we've got won't do that either - it'l just set the voltage
to whatever the last thing the regulator API had that might have been
within its constraints.

> > Setting the voltage you've read back sounds broken, if the hardware
> > might randomly change things how do you know the settings we read were
> > sane?  Shouldn't we know what voltage range the device requires in a
> > given mode and set that - that's much more normal?

> The hardware will not randomly change the voltage until the DFLL is
> enabled and so you would have to do this before.

I'm not clear that there's even a guarantee that the kernel will ever
have seen this configuration, consider for example what happens if
someone uses kexec?

> Yes, setting the frequency and voltage as defined by a given operating
> mode would make sense. However, I am not sure we have those defined in
> the kernel for this PLL and would have to be added.

I think given how you're describing the hardware that this will be
required in order to provide something robust (and also to get the best
power savings from the hardware).

> I was thinking that during boot we could read the default voltage and
> frequency set by the bootloader and use this as it should not be
> changing dynamically at this point because the cpufreq driver has not
> been activated yet.

I'm a bit confused here, we're talking about a change to the cpufreq
driver here aren't we?  Or alternatively why are we manipulating the
clock tree like this if we don't yet have support for the hardware?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/fd5be391/attachment-0001.sig>
