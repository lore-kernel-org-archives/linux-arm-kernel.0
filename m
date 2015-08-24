From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Aug 2015 07:53:56 +0100
Subject: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
In-Reply-To: <1634812.ZDaECJ9ClW@wuerfel>
References: <cover.1439843482.git.petr.cvek@tul.cz>
 <2889798.x6xcIzdYMU@wuerfel> <55D65722.9030508@tul.cz>
 <1634812.ZDaECJ9ClW@wuerfel>
Message-ID: <20150824065356.GA3247@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Aug 2015, Arnd Bergmann wrote:

> On Friday 21 August 2015 00:39:30 Petr Cvek wrote:
> > Dne 20.8.2015 v 22:26 Arnd Bergmann napsal(a):
> > > On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
> > >> Petr Cvek <petr.cvek@tul.cz> writes:
> > >>
> > >>> +     mdelay(3);
> > >> Okay, there are several mdelay(3) in this file.
> > >>
> > >> Could you please test if removing these mdelays prevents the camera from working
> > >> ? If not, I'd like to have them removed.
> > >>
> > >>
> > > 
> > > FWIW, it might be possible to replace some of them with msleep() calls,
> > > potentially after replacing spinlocks with mutexes where necessary.
> > > 
> > >       Arnd
> > > 
> > 
> > Datasheet says:
> > 
> >         tS:RESET        Setting time after software/hardware reset      1 ms
> > 
> > So at least one ~1 ms should be left there. Are msleep less than 20ms valid? 
> > 
> > (checkpatch: msleep < 20ms  can sleep for up to 20ms)
> 
> On most kernels, an msleep(1) will sleep somewhere between 1 and 3 milliseconds
> (but could be much longer), while an mdelay(1) tries to sleep around one
> millisecond, more or less.

If high-res timers are available I'd suggest using usleep_range()
instead.  By providing suitably divergent values usleep_range
de-restricts the kernel, allowing the scheduler to bundle your
wake-up along with others.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
