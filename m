From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 16:00:59 +0000
Subject: [PATCH] mmci: drop superfluous regulator #ifdef
In-Reply-To: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101219160059.GP9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 02:36:58PM +0100, Linus Walleij wrote:
> The regulator and MMC frameworks provide the proper stub functions
> for the regulator functions anyway, get rid of this.

I'm dropping this patch - it's wrong, because on platforms without
regulator support, it stamps over the provided platform values:

mmci-pl18x mb:mmci: Provided ocr_mask/setpower will not be used (using regulator instead)

# CONFIG_REGULATOR is not set

So the ifdefs have to stay until some other solution for this is found.
Maybe the:

        if (IS_ERR(host->vcc))
                host->vcc = NULL;
        else {

should be:

        if (IS_ERR(host->vcc) || host->vcc == NULL)
                host->vcc = NULL;
        else {

or maybe:

        if (IS_ERR(host->vcc))
                host->vcc = NULL;
        else if (host->vcc) {
