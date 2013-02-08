From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 16:27:30 -0700
Subject: [PATCH v4 01/10] s5p-csis: Add device tree support
In-Reply-To: <51157C36.6030505@gmail.com>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
 <1359745771-23684-2-git-send-email-s.nawrocki@samsung.com>
 <5112E907.4080100@wwwdotorg.org> <51157C36.6030505@gmail.com>
Message-ID: <511589E2.9030308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 03:29 PM, Sylwester Nawrocki wrote:
> On 02/07/2013 12:36 AM, Stephen Warren wrote:
>> On 02/01/2013 12:09 PM, Sylwester Nawrocki wrote:
>>> s5p-csis is platform device driver for MIPI-CSI frontend to the FIMC
>>> device. This patch support for binding the driver to the MIPI-CSIS
>>> devices instantiated from device tree and for parsing all SoC and
>>> board specific properties.
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt
>> b/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt
>>
>>> +Optional properties:
>>> +
>>> +- clock-frequency : The IP's main (system bus) clock frequency in
>>> Hz, default
>>> +            value when this property is not specified is 166 MHz;
>>
>> Shouldn't this be a "clocks" property, so that the driver can call
>> clk_get(), clk_prepare_enable(), clk_get_rate(), etc. on it?
> 
> Hi Stephen,
> 
> Thanks for your review!
> 
> I also use "clocks" and "clock-names" property, but didn't specify
> it here, because the Exynos SoCs clocks driver is not in the mainline yet.

I'm a bit sympathetic to this, since I've been trying to push Tegra
towards the common clock framework and describing clock connectivity in
DT, before adding new drivers that need clocks, specifically to avoid
this kind of situation.

The problem here is that if this gets merged now, then the clock driver
comes along later, you'll have to change this binding definition to
account for it, and DT bindings aren't supposed to be changed...

Do you have any clock driver at all upstream yet? Or, could you add a
dummy clock driver to satisfy the driver's clkl_get() needs? If you do,
you can always set up some AUXDATA so that clk_get() works for your
driver right now, and then remove that once the complete clock driver is
in place with full device tree support. That's how we've ended up
handling this for Tegra drivers.

Anyway, this is all mainly food-for-thought rather than an objection to
the patch; I'd leave that to Grant/Rob if applicable.
