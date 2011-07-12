From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 12 Jul 2011 18:18:43 +0400
Subject: [PATCH V3] mmc: Enable the ADMA2 on esdhc imx driver
In-Reply-To: <20110712134602.GT6069@pengutronix.de>
References: <1310465609-4516-1-git-send-email-richard.zhu@linaro.org>
	<20110712134602.GT6069@pengutronix.de>
Message-ID: <20110712141843.GA27358@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 03:46:02PM +0200, Sascha Hauer wrote:
[...]
> Honestly, putting all kinds of driver logic into the register access
> functions will lead to a catastrophe sooner or later. There are too
> many quirks in it already, we should not add more of them.

There aren't many options. You may pollute generic driver with
quirks (which is not an option :-), or you can introduce more
ops for things like sdhci_send_command(), but in that case
you will duplicate the logic just to compensate minor register
differences.

In some cases, e.g. capabilities register, it seems that introducing
get_caps() op would be a logical step, but then you just move the code
under 'if (reg == SDHCI_CAPABILITIES) { ' into a dedicated function.
No big difference.

As for me, I don't see any catastrophe coming because of the register
access fixups. Quite the contrary: from the maintenance stand point,
you just need to know how the generic SDHCI works, and then you can
look into platform drivers to see their differences, which are mostly
minor.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
