From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:03:44 +0100
Subject: [PATCH V2 RESEND 2/5] gpiolib: provide provision for gpiolib to
 register pin range
In-Reply-To: <77b462979e474f8b921d0f5ab8ac5b2a2fb2808e.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
 <77b462979e474f8b921d0f5ab8ac5b2a2fb2808e.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdYm6AUaRJQ3=G4tvkMrFEOpvkLC8oLFFeC5m235q21akA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 11:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> pinctrl subsystem needs gpio chip base to prepare set of gpio pin ranges, which
> a given pinctrl driver can handle. This is important to handle pinctrl gpio
> request calls in order to program a given pin properly for gpio operation.
>
> As gpio base is allocated dynamically during gpiochip registration, presently
> there exists no clean way to pass this information to the pinctrl subsystem.
>
> After few discussions from [1], it was concluded that may be gpio controller
> reporting the pin range it supports, is a better way than pinctrl subsystem
> directly registering it.
>
> [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/184816
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>

Hey thanks for working out the details of this!!

Patch applied, but I was a bit picky about the English in the
documentation so I patched it around a little, hope you don't
mind (diff below).

I will now try to make the U300 use this new range concep
as guinea pig, and that platform is *not* using DT so we'll
see for sure if it works :-)

Yours,
Linus Walleij

-gpio-controller and pinctrl subsystem
+GPIO controllers and the pinctrl subsystem
 ------------------------------------------

-gpio-controller on a SOC might be tightly coupled with the pinctrl
+A GPIO controller on a SOC might be tightly coupled with the pinctrl
 subsystem, in the sense that the pins can be used by other functions
-together with optional gpio feature.
+together with an optional gpio feature. We have already covered the
+case where e.g. a GPIO controller need to reserve a pin or set the
+direction of a pin by calling any of:

-While the pin allocation is totally managed by the pin ctrl subsystem,
+pinctrl_request_gpio()
+pinctrl_free_gpio()
+pinctrl_gpio_direction_input()
+pinctrl_gpio_direction_output()
+
+But how does the pin control subsystem cross-correlate the GPIO
+numbers (which are a global business) to a certain pin on a certain
+pin controller?
+
+This is done by registering "ranges" of pins, which are essentially
+cross-reference tables. These are described in
+Documentation/pinctrl.txt
+
+While the pin allocation is totally managed by the pinctrl subsystem,
 gpio (under gpiolib) is still maintained by gpio drivers. It may happen
 that different pin ranges in a SoC is managed by different gpio drivers.

 This makes it logical to let gpio drivers announce their pin ranges to
-the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
-request the corresponding pin before any gpio usage.
+the pin ctrl subsystem before it will call 'pinctrl_request_gpio' in order
+to request the corresponding pin to be prepared by the pinctrl subsystem
+before any gpio usage.

-For this, the gpio controller can register its pin range with pinctrl subsystem
-There are two ways of doing it currently with or without DT.
+For this, the gpio controller can register its pin range with pinctrl
+subsystem. There are two ways of doing it currently: with or without DT.

 For with DT support refer to Documentation/devicetree/bindings/gpio/gpio.txt.

 For non-DT support, user can call gpiochip_add_pin_range() with appropriate
 parameters to register a range of gpio pins with a pinctrl driver. For this
-exact name string of pinctrl device has to be passed as one of the argument to
-this routine.
+exact name string of pinctrl device has to be passed as one of the
+argument to this routine.


 What do these conventions omit?
