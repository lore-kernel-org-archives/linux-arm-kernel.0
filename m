From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Feb 2014 15:39:35 +0530
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq
 handler
In-Reply-To: <20140219095212.GT21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
 <20140218175703.GJ21483@n2100.arm.linux.org.uk>
 <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
 <20140219094322.GR21483@n2100.arm.linux.org.uk>
 <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
 <20140219095212.GT21483@n2100.arm.linux.org.uk>
Message-ID: <CAKohpo=ZrLRsTyCH86x7TbGE2XJnpXNb1ZDvYyzDUupAwTtS9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2014 15:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Are you aware that power control to the card is part of the MMC/SD/SDIO
> spec - and part of the protocol talking to the card?  Hence why the
> mmc layer has support for its control built-in.

Yeah, almost everything is part of the protocol and hence handled by core
sdhci.c layer.. We were handling some board specific issues here, that's it.

> If you don't want to use a regulator, then the right way to do this is to
> use the set_ios callback and check the power field - anything which is not
> MMC_POWER_OFF should result in power to the card being turned on.

I didn't get that completely here.. sorry completely out of touch on
this driver.
The power GPIO here is controlling the power to card socket. Once the card
is inserted, we need to enable power to the socket so that controller can
read back information from card.

And this set_ios callback is not available to drivers above sdhci.c, i.e. glues
like sdhci-pltfm or spear.. so, how we can we get that back in sdhci-spear.c?

Again, I can't test any modifications to this code and we need help from
Pratyush/Mohit on this..
