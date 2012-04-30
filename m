From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Apr 2012 10:54:29 +0100
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <87397o3n4y.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
 <20120427175657.GP18260@opensource.wolfsonmicro.com>
 <87397o3n4y.fsf@ti.com>
Message-ID: <20120430095429.GB3170@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 02:01:17PM -0700, Kevin Hilman wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > But presumably these things should integrate somehow - for example,
> > should devfreq and cpufreq be providing inputs into what AVS is doing,
> > and if so how?

> The way it is currently designed, cpufreq/devfreq/regulator layers don't
> need to know about AVS.

Yes, and that was a part of my concern, but see below.

> The higher-level layers only know about the "nominal" voltage.  AVS
> hardware does automatic, adaptive, micro-adjustments around that nominal
> voltage, and these micro-adjustments are managed by the AVS hardware
> sending commands to the PMIC.  (specifically, on OMAP, the AVS sensors
> provide inputs to the voltage processor (VP) which provide inputs to the
> voltage controller (VC) which sends commands to the PMIC[1].)

Right, that's what I'd understood it to be.  

> The driver proposed here is primarily for initializing the various
> parameters/sensitivity/etc. of the AVS hardware, but the actual voltage
> adjustments are done in hardware by VC/VP.

It's not just a driver, though - it's also creating this power/avs
thing, though now I look at the code rather than just its shape there's
not actually an abstraction being added here, it's mostly just straight
code motion of the arch/arm code that's there already.  The changelog
and the shape of the code make it sound like this is intended to be
somewhat generic when really it's providing some OMAP specific tuning
for the device which is much less of a concern.

I guess for now it's probably OK to just clarify in the documentation
and say that whoever adds the second driver has to work on making this
generic :)

This does also sound rather like it's in a similar area to the current
management work which Durgadoss R (CCed) was working on, though with a
slightly different application and in the OMAP case it's pretty much all
hidden in the external processor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/b3bfa9e7/attachment.sig>
