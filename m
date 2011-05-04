From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 02:16:20 -0700
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110504091619.GV2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@stericsson.com> [110502 12:13]:

Good to see this, looks like this should work for omaps too.

The numbering solves the issue where we have multiple
pinmux domains (base + offset for each domain).

Then I would assume that for most cases the pin access can be
described with:

unsigned long pinmux_base;	/* Can have multiple pinux domains */
u16 pinmux_reg_offset;		/* Register offset from pinmux_base */
u16 flags;			/* Register width etc */

Which can be accessed with read[bwl] and write[bwl], so we
can have default access functions in the pinux framework and
don't necessarily have to implement them for each platform.

Does this work for you? If so, then we can have the data in the
same format for all the architectures for devicetree.

And then we can have pin_get and pin_set functions, so platforms
can implement their custom flags like wake-up trigger etc with
just read[bwl] and write[bwl].

Also noticed one typo:

> +/* Plobal array of descriptors, one for each physical pin */
> +static DEFINE_SPINLOCK(pin_desc_lock);
> +static struct pin_desc pin_desc[MACH_NR_PINS];

s/Plobal/Global/

Regards,

Tony
