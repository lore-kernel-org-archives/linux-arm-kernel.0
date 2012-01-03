From: ashley.hughes@blueyonder.co.uk (Ash Hughes)
Date: Tue, 03 Jan 2012 22:45:36 +0000
Subject: orion5x mpp/gpio issue
Message-ID: <1325630736.18479.12.camel@ash-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I recently tried to build a new kernel and ran into an error with GPIOs
on my device. The MPP setup code has changed since I last compiled and
it now seems that some of the information in the mpp_list is being
ignored.

I've traced this back to arch/arm/plat-orion/mpp.c. In function:

void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int
variant_mask,
			   unsigned int mpp_max, unsigned int dev_bus)


there is the following:

		if (sel != 0)
			gpio_mode = 0;

sel is the value to be written to the MPP config registers and this is
not 0 for some pins (>16 and perhaps a few others, see
arch/arm/plat-orion/mpp.h). This means these pins will not be recorded
in the orion_gpio_chip valid_input and valid_output vars, which makes
them unavailable for drivers, despite the mpp_list defined for the
device (and the device registers being set correctly!).

What is the reason for this limitation? I've seen that some devices
(e.g. arch/arm/mach-orion5x/d2net-setup.c) use orion_gpio_set_valid to
manually enable higher GPIOs, along with the comment "/* Configure GPIO
over MPP max number. */" Is this the correct workaround to enable higher
GPIOs or should the code above not be included?

Apologies if there has already been a discussion on this, I couldn't
find one with a quick search!

Many thanks

Ash
