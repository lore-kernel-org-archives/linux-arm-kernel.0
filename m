From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Dec 2010 12:03:18 +0000
Subject: [PATCH] mmci: supply per-instance regulator name
In-Reply-To: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101202120318.GB3182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 12:35:07PM +0100, Linus Walleij wrote:
> On the Ux500 we have different regulators to different card slots
> and eMMCs, and some have no regulator. Move the hardcoded "vmmc"
> regulator name to platform data and supply it that way for the

You should never be passing regulator names through platform data, this
appears to be broken.  You should be using the struct device to
distingish between multiple instances and using whatever the actual
supply names are for multiple supplies on the same device.

Looking at this without seeing the datasheet I'd expect these would end
up as vmmcn for suitable values of n.

> platforms that use it. Remove the ugly and unneeded #ifdef around
> the regulator fetch code at the same time.

This is a separate change and is OK - it's this way as historically the
regulator API returned a non-NULL pointer when built out.

> +       if (plat->vcard) {
> +               int mask;

This will break users of this driver on any other platform - the naming
of the driver suggests that it's not specific to your SoC.
