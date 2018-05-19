From: chunkeey@gmail.com (Christian Lamparter)
Date: Sat, 19 May 2018 13:38:00 +0200
Subject: [PATCH v4] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <152654016566.210890.15719083257170941464@swboyd.mtv.corp.google.com>
References: <20180412190138.12372-1-chunkeey@gmail.com>
 <3220588.XpgAMh8mx0@debian64>
 <152654016566.210890.15719083257170941464@swboyd.mtv.corp.google.com>
Message-ID: <3016210.dAmjALS4pV@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 17, 2018 8:56:05 AM CEST Stephen Boyd wrote:
> Quoting Christian Lamparter (2018-05-16 13:29:48)
> > On Wednesday, May 16, 2018 5:31:16 PM CEST Stephen Boyd wrote:
> > > Why can't we register the gpiochip and tell it about the pin ranges in
> > > one API call instead of adding the chip and then adding the ranges? It
> > > doesn't look right to have to go and update all the DT nodes to list
> > > this information that is already known in the driver because the kernel
> > > implementation can't handle the order of operations correctly.
> > The problem is that gpiochip_add_pin_range() was not intended for
> > DT-based pinctrls... but it got used anyway.
> 
> Are there more users of this on DT based systems? A quick grep shows a
> couple more potential failures, like the qcom based SPMI gpio controllers
> and a mediatek one.
Yes, it there are a few. In the reply to the original report from Sven I found:
<https://www.spinics.net/lists/linux-arm-msm/msg34726.html>
pinctrl-mt7622, pinctrl-mtk-common.c, pinctrl-abx500.c, pinctrl-msm.c,
pinctrl-as3722.c, pinctrl-at91-pio4.c, pinctrl-axp209.c, pinctrl-coh901.c,
pinctrl-digicolor.c, pinctrl-pistachio.c, pinctrl-sx150x.c

.. And now the new Actions S900 gpio/pinctrl patch as well.
(<https://lkml.org/lkml/2018/5/19/44>)

> It's almost like we should print a huge WARN_ON() if gpio_chip::of_node
> is non-NULL and gpochip_add_pin_range() is called. But that probably
> would be noisy and can't be fixed on older DT blobs. It may also be good
> to bail out of that function if the node pointer exists and the property
> is there in the node so that we don't have to go update each driver for
> the backwards compat mode like was done in this patch. Plus the function
> should get some sort of comment that calling it is not useful on DT
> based platforms so this is all documented.
Agreed. Though, adding a warning now is likely a bit much, since the code
has to be compatible with existing definitions. But if Linus agrees I think
it would be fair to call drivers out with something like "the use of this 
function is deprecated for DT" debug level message.

(As for the documentation update to gpiochip_add_pin_range() and 
gpiochip_add_pingroup_range(). yeah I'll give it a go.)
 
> > This topic came up in an earlier post:
> > "Re: pinctrl: qcom: ipq4019: Use of gpio-hog's" [0] (you must have gotten
> > this mail too, since you are on the Cc.) which links to a ML thread titled
> > "Re: [GIT PULL] SPEAr pinctrl updates for v-3.5" 
> 
> I get quite a bit of email as you can tell.
Everyone does :D.

> > 
> > For your convenience: (this post is from 2012-09-03 - so it's 5-6 years
> > old by now and it looks like it predates even the DT pinctrl-msm driver.
> > (Not entirely sure?))
> > <http://thread.gmane.org/gmane.linux.ports.arm.kernel/184943>
> > |[...]
> > |But I want two similar function named:
> > |
> > |gpiochip_add_pin_range();
> > |gpiochip_remove_pin_range();
> > |
> > |*that can be used for platforms that doesn't support DT.*
> > |
> > |For example I'd like to convert over some of my existing
> > |drivers that do not have DT support to do this thing instead
> > |of registering ranges from the pin controller...
> > 
> > I think you must have come across similar issues with the
> > "gpio-reserved-ranges" property you recently added. Because
> > from what I can glimpse from the
> > "[2/3] dt-bindings: pinctrl: Add a ngpios-ranges property" 
> > <https://patchwork.kernel.org/patch/10153785/> series.
> > The gpio-reserved-ranges property would also need to be added
> > to existing products (msm8996) as well, right?
> > ("I stuck this inside msm8996, but maybe it can go somewhere more generic?")
> 
> The gpio-reserved-ranges only affects some SoCs. It should be added to
> the bindings on whatever chips are affected by those firmware quirks as
> optional properties. It would be great if you could add it to the ones
> that may need it. My guess is that it only matters for the pin
> controllers that spread out each pin into a big range of I/O memory
> because otherwise pins aren't locked away from non-secure systems.
(- see text the end - )
> > 
> > > Furthermore, it looks like this becomes a silent requirement to add the
> > > gpio-ranges property into the DT so that hogs work, but none of the
> > > bindings have been updated in this patch to indicate that.
> > The pinctrl-msm.c driver will fallback to using gpiochip_add_pin_range(),
> > if the gpio-ranges property is not present. So all existing and compiled 
> > devicetree binaries files will remain compatible.
> 
> That's good.
> > 
> > As for adding the gpio-ranges to the dt binding text files under
> > Documentation/devicetree/bindings/pinctrl/: Sure. No problem. I can add
> > them too :).
> 
> Great!
> 
> > 
> > But I do have a question: Should I also include the missing declaration
> > of the gpio-reserved-ranges properties too? (I can make the patches over
> > the long weekend. If I hear nothing from anyone, I'll post them on Monday).
> 
> Sure. Do you have the list of pinctrl devices that may need the
> gpio-reserved-ranges property?
> 
Oh, let me clarify. My plan is to add the binding documentation text for 
the (now) semi-required gpio-ranges property. And while I'm patching the
files in Documentation/devicetree/bindings/pinctrl/qcom-* I can also add
the new gpio-reserved-ranges as an optional property well. This way it is
in place for the future. (This is nothing fancy. As both properties are
part of the gpio.txt already).

As for the dtsi updates, I don't think I can add any sensible
gpio-reserved-ranges to the individual SoC's dts in 
arch/arm(64)/boot/dts/qcom-*dtsi without the HW/SoC or the documentation
which ranges need to be reserved. Because unlike the gpio-ranges values
(which are easy to extract from the drivers in drivers/pinctrl/qcom/)
the gpio-reserved-ranges for each SoCs is not yet documented (or I can't
find it?).

Regards,
Christian 
