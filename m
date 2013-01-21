From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 21 Jan 2013 15:41:58 -0800
Subject: [PATCH v4] drivers/pinctrl: grab default handles from device core
In-Reply-To: <1358795855-21064-1-git-send-email-linus.walleij@stericsson.com>
References: <1358795855-21064-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130121234158.GA9322@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 08:17:35PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This makes the device core auto-grab the pinctrl handle and set
> the "default" (PINCTRL_STATE_DEFAULT) state for every device
> that is present in the device model right before probe. This will
> account for the lion's share of embedded silicon devcies.
> 
> A modification of the semantics for pinctrl_get() is also done:
> previously if the pinctrl handle for a certain device was already
> taken, the pinctrl core would return an error. Now, since the
> core may have already default-grabbed the handle and set its
> state to "default", if the handle was already taken, this will
> be disregarded and the located, previously instanitated handle
> will be returned to the caller.
> 
> This way all code in drivers explicitly requesting their pinctrl
> handlers will still be functional, and drivers that want to
> explicitly retrieve and switch their handles can still do that.
> But if the desired functionality is just boilerplate of this
> type in the probe() function:
> 
> struct pinctrl  *p;
> 
> p = devm_pinctrl_get_select_default(&dev);
> if (IS_ERR(p)) {
>    if (PTR_ERR(p) == -EPROBE_DEFER)
>         return -EPROBE_DEFER;
>         dev_warn(&dev, "no pinctrl handle\n");
> }
> 
> The discussion began with the addition of such boilerplate
> to the omap4 keypad driver:
> http://marc.info/?l=linux-input&m=135091157719300&w=2
> 
> A previous approach using notifiers was discussed:
> http://marc.info/?l=linux-kernel&m=135263661110528&w=2
> This failed because it could not handle deferred probes.
> 
> This patch alone does not solve the entire dilemma faced:
> whether code should be distributed into the drivers or
> if it should be centralized to e.g. a PM domain. But it
> solves the immediate issue of the addition of boilerplate
> to a lot of drivers that just want to grab the default
> state. As mentioned, they can later explicitly retrieve
> the handle and set different states, and this could as
> well be done by e.g. PM domains as it is only related
> to a certain struct device * pointer.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mitch Bradley <wmb@firmworks.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Feel free to take this through your tree.

thanks,

greg k-h
