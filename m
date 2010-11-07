From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 17:15:59 +0000
Subject: [PATCH] mmci: reset voltage after power off.
In-Reply-To: <1288949741-9712-1-git-send-email-linus.walleij@stericsson.com>
References: <1288949741-9712-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101107171559.GE1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 10:35:41AM +0100, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> At power off, reset OCR mask to be the highest possible voltage
> supported for the current mmc host.
> 
> This solves the re-initialization during the power up sequence.
> The voltage may have been decreased due to the card accepts a lower
> voltage than the voltage used during the initialization sequence.
> We need to reset the voltage to by the host highest possible value
> since according to specification the initialization must always be
> done at high voltage.

Surely this should already be done by:

        /* If ocr is set, we use it */
        if (host->ocr)
                bit = ffs(host->ocr) - 1;
        else
                bit = fls(host->ocr_avail) - 1;

in mmc_power_up ?
