From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 5 Sep 2013 13:40:06 -0500
Subject: [PATCH 5/8] sdhci: sdhci-esdhc-imx: change pinctrl state
 according to uhs mode
In-Reply-To: <1378299257-2980-6-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
 <1378299257-2980-6-git-send-email-b29396@freescale.com>
Message-ID: <CAHCPf3tYXsT6kTbJcqJx1gN_G9G2iqi1-f+jRcpw95CEPkW8NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +       if (of_find_property(np, "no-1-8-v", NULL))
> +               boarddata->support_vsel = false;
> +       else
> +               boarddata->support_vsel = true;
> +
>         return 0;

No, no, no, no, no :(

Please do not just strip the prefix from a definition in code, or just
convert the underscores into hyphens to make a device tree property.
SDHCI_QUIRK2_NO_1_8_V should never, ever, EVER become no-1-8-v and NO
DEFINITION FROM SOURCE CODE should EVER make it into a device tree.
This is how we ended up with manure like "dr_mode" in the USB
bindings. Please follow good common sense as well as the bindings.

In this case a suitable standard for describing a voltage would be
no-1v8 (replacing the decimal point with the v) which is how 99.9% of
schematics are written in the world where a period is not a desirable
character in a net name or component/signal description. But even that
is stupid and not expandable.

This property should probably be called "voltage-selects" or something
and you should put in a list of supported voltages (in uV units just
like cpufreq operating points and regulators, please, for consistency,
and update the binding).

Then you can parse the list and find out precisely what voltages you
can switch to - there are more possibilities than an implied 3-ish
volts and a switch to 1.8V for MMC. The standard for the OCR register
is a bunch of ranges - so specify which voltages you HAVE available,
if you can switch. The driver (as per standard) can determine if this
is in one range or another.

Lack of this property would imply that whatever the chip is driving
right now for logic is what it should stay at (support_vsel = false in
the code).

--
Matt Sealey <neko@bakuhatsu.net>
