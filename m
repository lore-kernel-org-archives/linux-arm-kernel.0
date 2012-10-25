From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 08:28:26 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121025054638.GB8590@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc>
 <20121024200128.GY21046@lunn.ch> <20121024233356.1bda95bf@skate>
 <20121025054638.GB8590@lunn.ch>
Message-ID: <20121025082826.693939b0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Thu, 25 Oct 2012 07:46:38 +0200, Andrew Lunn wrote:

> Thanks Thomas, i will play around with this.
> 
> I'm just wondering if we are going to get into ordering issues. These
> gpio operations are providing power to subsystems. We probably need
> that to happen before the driver is loaded. If we call
> of_platform_populate() too early, do we have the danger the driver
> probing is going to happen before the init routine can enable the
> power?
> 
> It seems like we want pinctrl/gpio working first, with pins hogged as
> specified in DT, then the board init() function, then the rest of DT
> setup.

If those GPIO value settings are needed to get a particular driver to
work, then I'd recommend letting the driver do the GPIO value setting.
For example, in the lsxl board, I see:

        /* usb and sata power on */
        gpio_set_value(LSXL_GPIO_USB_POWER, 1);
        gpio_set_value(LSXL_GPIO_HDD_POWER, 1);

If the LSXL_GPIO_USB_POWER GPIO should be set to one to get the EHCI
driver to work properly, then I think we should let the EHCI driver set
this GPIO value in its ->probe() operation. Of course, the GPIO
reference will be passed in the platform_data (for old-style probing),
or through specific DT properties (for new-style, DT-based, probing).

Regarding the LSXL_GPIO_HDD_POWER GPIO, I am not sure. Is it required
to apply power on this GPIO to get the SATA driver to probe properly,
or is it possible to get the SATA driver to probe properly, then apply
power and have the HDD still being recognized? I haven't looked at all
at how SATA drivers were working, so I can't say.

Also, ultimately, if those GPIOs are providing power, then they should
probably not be handled as simple GPIOs, but rather as regulator, using
the gpio-regulator driver. But let's do things steps by steps :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
