From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Tue, 31 May 2011 21:55:13 +0200
Subject: [PATCH v3] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F381FC498E@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4955@AUSP01VMBX24.collaborationhost.net>
	<1306868578-3883-1-git-send-email-ynezz@true.cz>
	<ADE657CA350FB648AAC2C43247A983F001F381FC498E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110531195513.GL16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten <hartleys@visionengravers.com> [2011-05-31 14:24:04]:

> I pulled out the ts-7200 manual to verify the watchdog reset.  Your feeding
> the watchdog then changing the timeout period to 250ms.  Without the "else"
> the syscon would have tried to reset the board when the SWRST bit is toggled.

Yep, that missing "else" was a good catch, thanks.

This feed first then set behaviour is "logic", but it's correct (250ms is the
smallest possible value), from that manual:

   In order to load the WDT Control register, the WDT must first be ?fed?, and
   then within 30 uS, the WDT control register must be written. Writes to this
   register without first doing a ?WDT feed?, have no affect.

(Please don't laugh at that 30us constraint).

> I have no way of testing this patch (no ts boards) but as long as Ryan has no
> objections you have my:

I'm using it[1] since 2.6.19-rc6-git10 (maybe earlier). Funny, that I didn't
forget to add that "else" in this old patch.

And as I see it, you and few other guys really deserve some free TS boards for
sure (at least the damn board as a thank you), but Lennert could probably tell
you more about their "we only leech the work from the comunity, but don't give
anything back" attitude...

1. http://ynezz.ibawizard.net/ts72xx/ts72xx_cpld_wdt_reset.diff.gz

> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks.

-- ynezz
