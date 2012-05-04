From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Fri, 4 May 2012 08:21:28 +0000
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <87397o3n4y.fsf@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
 <20120427175657.GP18260@opensource.wolfsonmicro.com> <87397o3n4y.fsf@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 02:31:17, Hilman, Kevin wrote:
> Hi Mark,
> 
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:
> >
> >> Devfreq and cpufreq are related to dynamic frequency/voltage switching between
> >> pre defined Operating Performance Points or the OPPs. Every OPP being
> >> a voltage/frequency pair. Smartreflex is a different
> >> power management technique.
> >
> > But presumably these things should integrate somehow - for example,
> > should devfreq and cpufreq be providing inputs into what AVS is doing,
> > and if so how?
> 
> The way it is currently designed, cpufreq/devfreq/regulator layers don't
> need to know about AVS.
> 
> The higher-level layers only know about the "nominal" voltage.  AVS
> hardware does automatic, adaptive, micro-adjustments around that nominal
> voltage, and these micro-adjustments are managed by the AVS hardware
> sending commands to the PMIC.  (specifically, on OMAP, the AVS sensors
> provide inputs to the voltage processor (VP) which provide inputs to the
> voltage controller (VC) which sends commands to the PMIC[1].)
> 
> The driver proposed here is primarily for initializing the various
> parameters/sensitivity/etc. of the AVS hardware, but the actual voltage
> adjustments are done in hardware by VC/VP.
> 
> The only thing the higher-level layers might potentially need to do to
> enable/disable AVS around transitions (e.g. when changing OPP, AVS is
> disabled before changing OPP and only re-enabled when the new nominal
> voltage has been acheived.)
> 
> On OMAP, we handle this inside the OMAP-specific voltage layer which is
> called by the regulator framework, so even the regulators do not need
> any knowledge of AVS.

Kevin,

I want to point out some cases of SR implementation where this may not
be true.

Devices like DM8168, DM8148 and AM335X use Class 2B implementation of SR.

Under this, SR module issues an interrupt to ARM when there is a need to
change the voltage based on temperature changes, ageing etc.

Once the interrupt arrives, kernel needs to adjust voltage using regulator API.
The voltage change is a micro adjustment as in other SR classes.

The SR class 2B implementation on these devices does not exist in mainline.
I can point to some public repositories if you are interested in taking a look at
the current code.

Implementation of this SR method is must on at least the DM8168 device and
I know some customers who are using it on their production systems.

Regards
AnilKumar
