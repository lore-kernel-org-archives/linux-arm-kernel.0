From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 04 Jul 2016 10:08:56 -0400
Subject: [PATCH v2 0/3] pwm: lpc32xx: Add support to control
 PWM_PIN_LEVEL bit
In-Reply-To: <03725469-ce79-3fe6-3f51-242f4e895c41@mleia.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
 <ce29f743-e481-64b0-8e05-0b610fa33fb3@mleia.com>
 <1467293119.32051.9.camel@localhost>
 <03725469-ce79-3fe6-3f51-242f4e895c41@mleia.com>
Message-ID: <1467641336.9582.22.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Fri, 2016-07-01 at 11:13 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 30.06.2016 16:25, Sylvain Lemieux wrote:
> > Hi Vladimir,
> > 
> > On Thu, 2016-06-30 at 11:43 +0300, Vladimir Zapolskiy wrote:
> >> Hi Sylvain,
> >>
> >> On 27.06.2016 16:09, Sylvain Lemieux wrote:
> >>> From: Sylvain Lemieux <slemieux@tycoint.com>
> >>>
> >>> The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.
> >>>
> >>> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> >>> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> >>> and a 0 logic level was apply to the output.
> >>>
> >>> According to the LPC32x0 User Manual [1],
> >>> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> >>>
> >>> First patch:
> >>> * initialize the pin level to 0 (default value) and update
> >>>   the register value accordingly.
> >>>
> >>> Second anf third patches:
> >>> *  provide support to configure the pin output (i.e. PWM_PIN_LEVEL bit)
> >>>    when the PWM is disabled.
> >>
> >> a short question, how do you use PWM? Does it serve as a backlight
> >> or something else?
> >>
> > The PWM is used to control the LCD backlight intensity.
> > 
> > When we setup the backlight brightness level to 0, 
> > it should turn off the LCD display by disabling the PWM.
> > 
> > This is what was added to our board dts for it:
> > 	backlight {
> > 		compatible = "pwm-backlight";
> > 		pwms = <&pwm1 0 1250000>;
> > 
> > 		brightness-levels = <0 20 100>;
> > 		default-brightness-level = <2>;
> > 	};
> > 
> 
> this is good that there is a consumer and we are not talking in
> general, then it might be more visual that the new property probably
> is not needed due to the lack of use cases.
> 
> I think that we should start from something as simple as one-time
> setting of PWMx_PIN_LEVEL to default 0 in lpc32xx_pwm_probe() and then
> implement a proper support of boundary values as suggested in discussion
> of v1 series.
> 
Can you take the patch 1 of this series? This resolved an issue with 
the LPC32xx PWM when use to control the LCD backlight brightness level.

As suggested, we can later discuss the best way to 
implement proper support of boundary values.
 
> >>> Note:
> >>> * Follow this URL to access the discussion for version 1 of this
> >>>   patch: http://thread.gmane.org/gmane.linux.pwm/3882
> 
> --
> With best wishes,
> Vladimir
