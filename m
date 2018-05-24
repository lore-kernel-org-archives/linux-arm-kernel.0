From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 09:29:14 +0200
Subject: [PATCH v4] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <3016198.WsLn1iDyWJ@debian64>
References: <20180412190138.12372-1-chunkeey@gmail.com>
 <20180518051826.GO14924@minitux> <3016198.WsLn1iDyWJ@debian64>
Message-ID: <CACRpkdZtpxe+oDaT+wUG3ONS6fd0YeE5TcDcWt82=NEsc0ti7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 11:52 AM, Christian Lamparter
<chunkeey@gmail.com> wrote:
> On Friday, May 18, 2018 7:18:26 AM CEST Bjorn Andersson wrote:

>> > +                   gpio-ranges = <&msmgpio 0 0 150>;
>>
>> I'm still confused to why this information is in DT at all, it feels
>> like an implementation detail, not a system configuration thing.

This reflects especially the layout of systems such as HiSilicon
that have a standard fit-all pin controller (pinctrl-single.c, shared
with OMAP) and a standard PL061 GPIO primecell from ARM
(gpio-pl061.c) shared with many other SoCs.

These are non-HiSilicon-specific drivers used in other SoCs.
So the ranges in e.g. arch/arm64/boot/dts/hisilicon/hi6220.dtsi
define how the pin controller and the GPIO blocks inside the
SoC are connected using these ranges.

So "system configuration" is something different for you guys
than for HiSilicon. They need to configure how the stuff inside
the SoC are wired up, because they are using standard silicon
used in other SoCs.

As I understand it, your SoCs are so Qualcomm-specific and
idiomatic that this situation never happened to you :)

> I did look at the commits and code from back in 2013. From what
> I can gather "this implementation detail" was realized the way
> it is now, because "devicetree was the new thing" and it seemed
> like a good idea to make it as extendable/generic as possible.

Many mistakes were made when shoehorning device tree
into the ARM architecture with one finger constantly on the
fast-forward button. There were reasons for this. Mea culpa.

I hope to fix them all before I retire.

One use case (which still applied) are pin controllers and GPIO
chips defined through the use of platform data.

If we have for example a PCI card with a pin controller and
GPIO block (Alessandro Rubini ran into such a device at
CERN IIRC) we need to be able to define both components
and connect them using ranges, even without either
device tree or ACPI hardware descriptions.

Yours,
Linus Walleij
