From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 21 Jun 2016 08:39:02 -0400
Subject: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
In-Reply-To: <b499570f-e624-cbe1-4fca-44ba0e701054@mleia.com>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <b499570f-e624-cbe1-4fca-44ba0e701054@mleia.com>
Message-ID: <1466512742.2114.9.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-06-21 at 05:11 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 03.06.2016 22:37, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> > disable the PWM, the PWM output is always set as a logic 1.
> > 
> > Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> > the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> > and a 0 logic level was apply to the output.
> > 
> > According to the LPC32x0 User Manual [1],
> > the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> > 
> > This change initialize the pin level to 0 (default value) and
> > update the register value accordingly during the disable process.
> > 
> > [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
> > 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> 
> It looks like a pin control setting, but because it depends
> on PWM enabled/disabled status, I suppose it is good enough to
> manage it from the PWM driver.
> 
> I think here a new optional DTS property should be introduced,
> which if present indicates that PWM_OUT pin value is high when
> PWM is disabled. And if the property is not found then
> PWMx_PIN_LEVEL is set to 0 on driver probe.
> 
I will add this option and submit a new revision of the patch.

> By convention the property name should be prefixed by "nxp,",
> what name is good? May be "nxp,pwm-disabled-level-high" ?
> Or add a property "nxp,pwm-disabled-level" with valid values 0/1?
> 
I prefer to use "nxp,pwm-disabled-level-high".

> Also note someone may want to switch the default behaviour
> in runtime, but this feature may be added later on.
> 
I agree with you, this can be done later.

Sylvain
