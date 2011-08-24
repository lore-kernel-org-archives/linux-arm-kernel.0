From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 24 Aug 2011 11:29:13 -0700
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3BC0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Friday, August 19, 2011 3:54 AM:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This creates a subsystem for handling of pin control devices.
> These are devices that control different aspects of package
> pins.

Sorry to keep harping on about this, but I'm still not convinced the data
model is correct.

Note: There are two places where a data model is relevant: (a) The API
exposed to clients of the pinmux API (b) the API between the pinmux API
core and the pinmux chip implementations. Your patches currently use the
same data model for both. I believe we can use a different data model for
the two interfaces. My discussion below talks solely about the interface
at point (b); I can talk more about (a) later. I'm trying to talk about
one thing at a time right now to avoid my previous overwhelming emails,
and gain consensus on one point at a time.

Here are the two possible models:

Model 1 (as implemented in the pin control subsystem):

* Each pinmux chip defines a number of functions.
* Each function describes what functionality is mux'd onto the pins.
* Each function describes which pins are affected by the function.

Result:

If there are a couple of controllers that can each be mux'd out two
places, you get four functions:

Function i2c0-0: Controller i2c0 is mux'd onto pins 0 and 1
Function i2c0-1: Controller i2c0 is mux'd onto pins 2 and 3
Function spi0-0: Controller spi0 is mux'd onto pins 0 and 1
Function spi0-1: Controller spi0 is mux'd onto pins 4 and 5

Model 2 (what I'd like to see)

* Each pinmux chip defines a number of functions.
* Each function describes the functionality that can be mux'd out.
* Each pinmux chip defines a number of pins.
* Each pinmux chip defines which functions are legal on which pins.

Result:

With the same controllers and pins above, you get:

Function i2c0
Function spi0
Pins 0, 1, 2, 3, 4, 5
Pins 0, 1 accept functions i2c0, spi0
Pins 2, 3 accept functions i2c0
Pins 4, 5 accept functions spi0

We'd still have a single controller-wide namespace for functions, it's
just that functions are something you mux onto pins, not the combination
of mux'd functionality and the pins it's been mux'd onto.

Advantages:

* I believe this model is much more directly maps to the way most HW
works; there's a register for each pin where you write a value to select
which functionality to mux onto that pin. Assuming that's true, using
this data model might lead to simpler pinmux chip implementations; they'd
require fewer mapping tables.

* Given that's the way Tegra HW works at least, the patches I recently
posted to initialize the Tegra pinmux from device-tree define bindings
that use this model. I think it's important that such bindings use the
same data model as the pinmux chip data model. This keeps consistency
between boot-time initialization and the pinmux chip portion of any
run-time pinmux modifications.



As an aside, I see your patches use the pinmux API at driver probe time
to set up the pinmux, whereas my init-pinmux-driver-from-dt patches do
a pinmux-controller-wide initialization at probe time. There was some
discussion in response to earlier patches re: which way was better, and
I got the impression that the pinmux API was mainly for runtime changes,
rather than boot-time initial configuration. If that's not the case, then
I guess we should drop my proposed init-pinmux-driver-from-dt patches and
put all that code into your pinmux subsystem...

-- 
nvpublic
