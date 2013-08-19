From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Aug 2013 09:58:17 +0100
Subject: [PATCH] mmc: sdhci: request irq after sdhci_init() is called
In-Reply-To: <20130819083357.GA26883@S2101-09.ap.freescale.net>
References: <1373006335-31239-1-git-send-email-shawn.guo@linaro.org>
 <20130819083357.GA26883@S2101-09.ap.freescale.net>
Message-ID: <20130819085817.GR23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 04:33:59PM +0800, Shawn Guo wrote:
> Hi Chris,
> 
> Can you please queue this patch for 3.12?

I already reported this months ago - it's caused because the SDHCI
initialization code is broken.  It plays at separating out the
"alloc+init" from the "add" but doesn't get it right, because it does
a whole swathe of initialisation at the "add" stage.

This pretty much makes it impossible to use the generic GPIO slot detect
stuff with SDHCI, and why I have no motivation what so ever to convert
the dove sdhci support over to the generic GPIO stuff.

SDHCI basically needs its initialisation stuff rewritten to conform to
the "get everything initialised at alloc time" approach.
