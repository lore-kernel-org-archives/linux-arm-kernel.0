From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 26 May 2015 16:49:34 +0200
Subject: sdhci(imx6): misbehaves while installing debian jessie, "Got data
 interrupt 0x00100000"
In-Reply-To: <20150519222320.GM2067@n2100.arm.linux.org.uk>
References: <20150519222320.GM2067@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFqR3NwBd9O40BPzHG7Y4wyyJwgdB4NsA_GUO=YEyqFSXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2015 at 00:23, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> iMX6 with a Samsung EVO UHS-1 16GB card.
>
> There's actually two problems here.
>
> 1. SDHCI chooses to impose a 10 second timeout on any data operation.
>    This magic value of 10 seconds is rediculous.  Consider that SD
>    cards are typically slower than ATA, and ATA has a timeout of more
>    than one minute for a stuck command...  And yes, I've had this fire
>    a good 10 seconds before I then got...
>
> 2. "Got data interrupt 0x00100000 even though no data operation was in progress."
>
>    That's SDHCI_INT_DATA_TIMEOUT.
>
>    Unfortunately, I have no other information, as the registers are
>    dumped at pr_debug() level, which means that they're all compiled
>    out in normal kernel builds.  In any case, I have no way to copy
>    information off of the installing system; debian does not start up
>    a ssh daemon during the install, so remote login is not possible.
>    Nor can I photograph the rather reflective TV screen.
>
> The side-effect of this is that the entire MMC IO subsystem locks up
> and I'm left with lots of processes stuck in IO-wait state, with the
> hungtask detector spewing onto the console.

Sorry, I can't tell much around the host driver and HW as such. I
don't have any iMX6 boards at hand.

Though, the side-effect you are describing isn't very nice. Even if it
doesn't solve you problem, perhaps we should discuss about converting
from wait_for_completion() to wait_for_completion_timeout(), when the
mmc core waits for the host driver to return the result for the
request.

I guess the tricky part is to find a decent value for the "timeout".

Kind regards
Uffe
