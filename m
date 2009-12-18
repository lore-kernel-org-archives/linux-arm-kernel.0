From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 Dec 2009 11:13:37 +0000
Subject: Regulator framework usage in suspend/resume contex.
In-Reply-To: <000301ca7f39$96047b60$c20d7220$%majewski@samsung.com>
References: <000301ca7f39$96047b60$c20d7220$%majewski@samsung.com>
Message-ID: <20091218111337.GB21706@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 05:54:21PM +0100, Lukasz Majewski wrote:

In general if you want advice on a kernel subsystem it's best to CC the
maintainers of the relevant subsystem - messages posted only to mailing
lists (particularly high volume ones such as this) can easily get lost
in the flow.

> I'm trying to use the regulator framework in conjunction with suspend/resume
> (code based on a s3c Samsung SoC platform).
> My goal is to change values of regulators output before going to sleep and
> restore their values after resume.

Which PMIC are you using for this?

> The problem is when I disable normally enabled source or change its voltage
> value to new_value when entering the suspend to RAM state.

It'd be useful to see the driver here...

> I don't know how to enable this source again after resume or restore source
> microvolts setting as before suspend?

The expecation of the API is that your suspend state configuration will
not impact the state used for the running system so no work should be
required by software to restore the state.  Hardware tends to want this
since the suspend mode will normally involve powering down the CPU and
therefore needs some hardware handshake between the CPU and the PMIC.
If the regulator driver is doing something too different to this then it
probably shouldn't be implementing the suspend mode APIs at all.

There's also a general idea that consumer drivers should be turning off
their supplies when they suspend, if only to allow them to better take
advantage of runtime PM schemes as they come along (though currently
they all use different callbacks).

There's currently no support for restoring the state of regulators that
don't have the hardware handshaking for entering and exiting suspend,
mostly due to lack of demand.  That may be best handled by the
individual regulators from their suspend and resume methods, probably
using a core helper, but I've not fully thought that through.

> It looks like some relevant method is missing in the framework, or I haven't
> look deep enough to spot one :-).

It's a bit academic anyway for ARM platforms since suspend to disk isn't
supported by the architecture at present so most systems will never do
anything except suspend to RAM so there's no real need to select which
mode to use at runtime.

> I was grepping a little and it looks, that regulator_suspend_prepare()
> method is not used by any suspend/resume driver in the kernel linux tree (at
> least up to kernel version 2.6.32-rc8), so there is no reference code.

That's correct, it should probably be hooked in for the 1133-EV1 i.MX
support but IIRC that was merged prior to the platform supporting
suspend and like I say the suspend mode configuration for ARM is a bit
academic.
