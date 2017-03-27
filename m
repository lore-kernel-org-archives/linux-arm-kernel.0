From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Mar 2017 18:17:09 +0100
Subject: [Question] firmware/psci.c: prevent registering pm_power_off
In-Reply-To: <58D93CF7.8090409@topic.nl>
References: <64d01077-e2e8-01e2-f763-779a60c0fe68@topic.nl>
 <947a7f4d-63ac-5ce4-007a-ca414cd150e7@arm.com>
 <58D93CF7.8090409@topic.nl>
Message-ID: <20170327171709.GB13752@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 06:25:27PM +0200, Mike Looijmans wrote:
> On 27-03-17 16:02, Sudeep Holla wrote:
> >
> >On 27/03/17 14:36, Mike Looijmans wrote:
> >>Problem: The board uses gpio-poweroff to power down, because the "kill"
> >>signal is controlled by an I2C IO expander. This doesn't work because
> >>drivers/firmware/psci.c unconditionally registers pm_power_off,
> >>resulting in the gpio-poweroff driver to refuse to register. The PSCI
> >>firmware isn't actually capable of really turning off the power, but
> >>there appears to be no way to tell the psci driver about that.
> >
> >That's because {SYSTEM_OFF,RESET} functions are mandatory since v0.2 to
> >be compliant with a PSCI specification.
> >
> >So the question is why is PSCI being advertised in the DT if the
> >firmware is not compliant ?
> 
> The PSCI firmware doesn't have access to the GPIO to turn off power.

I take it that means no SYSTEM_RESET either.

Are there any other mandatory PSCI 0.2+ features that are not
implemented?

Which PSCI implementation is being used here?

If PSCI was advertised as a legacy < 0.2 version, we would not register
pm_power_off, but other features that you might want (e.g.
SYSTEM_SUSPEND) would not be available.

[...]

> >One approach is to implement SYSTEM_OFF in PSCI using the same GPIO. Thereby
> >making it compliant and allowing any secure entity running in the platform
> >to shutdown gracefully.
> 
> Cannot practically do that. The GPIO to switch the power off is on a
> IO expander on an I2C bus behind a I2C multiplexer on the I2C
> controller of the CPU with a dozen other I2C devices. The PSCI would
> somehow need access to the I2C controller without interfering with
> the kernel, change the multiplexer (again without interfering) and
> then set the IO in the expander chip.

Given this is SYSTEM_OFF, the firmware can forcefully get the kernel out
of the way. For example, it can send an SGI to other CPUs to bring those
into the FW before attempting to poke the HW.

> I'd expect other boards to have similar issues, especially if
> they're modules on a carrier board like this one. The PSCI could
> turn off the CPU, but having it turn off the board completely, even
> if it could, would require board-unique firmware for each board.
> Hey, that's like moving back to the "platform data and code" times
> like before the devicetree was introduced.

I appreciate that the board/module case is a little special, but this is
a much more constrained case than a general purpose kernel with platform
code, and it is possible to some extent to have a configurable firmware.

Thanks
Firmware 
