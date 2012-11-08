From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Nov 2012 10:11:33 -0700
Subject: [PATCH 2/2] pinctrl/nomadik: make independent of prcmu driver
In-Reply-To: <1352375742-29611-1-git-send-email-linus.walleij@stericsson.com>
References: <1352375742-29611-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <509BE7C5.4030109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2012 04:55 AM, Linus Walleij wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> Currently there are some unnecessary criss-cross
> dependencies between the PRCMU driver in MFD and a lot of
> other drivers, mainly because other drivers need to poke
> around in the PRCM register range.
> 
> In cases like this there are actually just a few select
> registers that the pinctrl driver need to read/modify/write,
> and it turns out that no other driver is actually using
> these registers, so there are no concurrency issues
> whatsoever.
> 
> So: don't let the location of the register range complicate
> things, just poke into these registers directly and skip
> a layer of indirection.

Do you actually need to store the run-time data in struct
nmk_pinctrl_soc_data too? I would have expected all the soc_data
pointers to remain const, and to store the runtime register pointer
somewhere else, and perhaps pass it as a separate parameter to the
relevant init functions; wouldn't that make the patch much smaller?
