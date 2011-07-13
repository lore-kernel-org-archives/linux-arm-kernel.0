From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 01:36:39 +0900
Subject: [PATCH v3 4/4] mmc: sdhci-esdhc-imx: add device tree probe support
In-Reply-To: <20110713155212.GB7875@oksana.dev.rtsoft.ru>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
	<1309970870-13336-5-git-send-email-shawn.guo@linaro.org>
	<20110706210518.GD5371@ponder.secretlab.ca>
	<20110713155212.GB7875@oksana.dev.rtsoft.ru>
Message-ID: <CACxGe6t27uvsoU6ZXYakh9ncyCeCvnqwKa5d2TQ3WUwG4xW4og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 12:52 AM, Anton Vorontsov
<cbouatmailru@gmail.com> wrote:
> Hi,
>
> On Wed, Jul 06, 2011 at 03:05:18PM -0600, Grant Likely wrote:
>> On Thu, Jul 07, 2011 at 12:47:50AM +0800, Shawn Guo wrote:
>> > The patch adds device tree probe support for sdhci-esdhc-imx driver.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> > Cc: Wolfram Sang <w.sang@pengutronix.de>
>> > Cc: Chris Ball <cjb@laptop.org>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> [...]
>> > +Optional properties:
>> > +- fsl,card-wired : Indicate the card is wired to host permanently
>> > +- fsl,cd-internal : Indicate to use controller internal card detection
>> > +- fsl,wp-internal : Indicate to use controller internal write protection
>> > +- cd-gpios : Specify GPIOs for card detection
>> > +- wp-gpios : Specify GPIOs for write protection
> [...]
>> > + ? cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
>> > + ? wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
>
> Is there any particular reason why we started using named GPIOs
> in the device tree? To me, that's quite drastic change... should
> we start using named regs and interrupts as well? Personally, I
> don't think that the idea is great, as now you don't know where
> to expect memory resources, interrupt resources and, eventually
> GPIO resources.

No, there are no plans to move to named irqs or regs.  irq and reg
resources tend to be a lot more regular than gpios.  It's not a
drastic change though because existing bindings remain unaffected, and
new bindings can still use unnamed gpios if that is more appropriate.

>
> Just a few disadvantages off the top of my head:
>
> - You can't statically validate your device tree for correctness.
> ?Today dtc checks #{address,size}-cells sanity for 'regs' and
> ?'ranges';

We can. The gpio binding was extended to be in the form
[<name>-]gpios.  Any property with the string "gpios" at the end can
be statically validated.

> - You can't automatically convert named resources into 'struct
> ?resource *', as we do for platform devices now;

Only for irqs and regs.  gpios have never been automatically loaded
into resources.

> - Any pros for using named resources in the device tree? I don't
> ?see any.

Human readability.  To know exactly what a gpio is intended to be used
for.  Particularly for the case where a device might not use all the
gpios that it could use.  Yes, the gpios property can have 'holes' in
it, but the observation was made by several people that it is easy to
get wrong.  I for one thing the concern was well justified.

> So, I suggest to at least discuss this stuff a little bit more
> before polluting device trees with dubious ideas.

It was discussed on list quite a while ago.

>
> p.s.
>
> As for this particular patch, I really don't see why we should
> use named GPIOs. For consistency, I'd suggest to reuse bindings
> from Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.
>
> Plus, fsl,cd-internal and fsl,wp-internal is not needed: either
> you specify GPIOs or not. That already signals whether driver
> should use internal detection (i.e. 'present' register) or
> external (i.e. GPIO).

wp-internal and cd-internal differentiates between using the internal
functionality and not having wp/cd at all.

>
> And also, why {cd,wp}-gpioS (plural)?

For consistency.  Doing it that way means that the plural "gpios" is
always the suffix for both the "gpios" and "<name>-gpios" use cases.

>
> --
> Anton Vorontsov
> Email: cbouatmailru at gmail.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
