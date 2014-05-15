From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 15 May 2014 03:46:08 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <5373C2F4.50803@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>	<20140514141914.446F7C4153D@trevor.secretlab.ca>	<53738580.7000902@ahsoftware.de>	<CACxGe6s4px_9CNk3bkc1OF1KGZGYdyh4gE_VufCKU5dLFBG48g@mail.gmail.com>	<53739871.9070407@ahsoftware.de>	<CAL_JsqJB4CAO60m1HTGQGHQRYVWcARxm_roOhn-PJh+ZR7OONg@mail.gmail.com>	<5373ABD2.9010508@ahsoftware.de>
 <CAL_JsqJ-=amrmRR9FfnOH1ELDQ1kTaG3e1n878mgpZP1FUw_jA@mail.gmail.com>
 <5373C2F4.50803@ahsoftware.de>
Message-ID: <53741C60.70209@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.05.2014 21:24, schrieb Alexander Holler:
> Am 14.05.2014 21:06, schrieb Rob Herring:

>> I still have not seen an example of A depends on B, deferred probe
>> fails because of ? and here is the code for A that works around the
>> problem.
>>
>>> Anyway, this feature is totally independ of the deferred probe stuff and
>>> both can friendly live together.
>>
>> Yes, except then we get to maintain both.

And just in case someone still hasn't realized what the goal of a
deterministic initialization order is, have a look at this snippet from
arch/arm/mach-omap2/gpio.c:

--------
/*
 * gpio_init needs to be done before
 * machine_init functions access gpio APIs.
 * Hence gpio_init is a omap_postcore_initcall.
 */
static int __init omap2_gpio_init(void)
{
	/* If dtb is there, the devices will be created dynamically */
	if (of_have_populated_dt())
		return -ENODEV;

	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init, NULL);
}
omap_postcore_initcall(omap2_gpio_init);
--------
(Sorry to the OMAP guys, it isn't there fault that it has to look like
this.)

But this is ecactly what should be avoided and why the kernel is in need
of a deterministic, easy to setup, initialization order. And deferred
probes are in now way a help to reach that target, in fact they even
support such stuff. Does anybody outside the OMAP crew do understand
what that piece of code does? The answer is pretty likely no. Again
sorry to the OMAP guys, I'm pretty sure that code was born out of
necessity because no other mechanism is available to get things in order.

Regards,

Alexander Holler
