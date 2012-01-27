From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 27 Jan 2012 14:02:40 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <4F184900.8050901@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
 <4F047FE1.5030002@citrix.com>
 <1326979266.32197.60.camel@hornet.cambridge.arm.com>
 <4F184900.8050901@citrix.com>
Message-ID: <1327672960.24701.55.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-01-19 at 16:46 +0000, David Vrabel wrote:
> >>  __create_page_tables has only mapped the single physical
> >> page at 0x1c090000 and thus the test for the UART in the other memory
> >> map faults.

I got to the bottom of the problem... The mapping created by the
DEBUG_LL code in __create_page_tables is actually a section (1MB) so
covers both possible accesses (0xf8009000 and 0xf8090000). The
difference between model and hardware is that "real" RS1 VE has a DAP
ROM located between 0xf8000000 and 0xf800ffff so the 0xf8009000 succeeds
(returning some irrelevant data), while model is "empty" in that space,
so it faults.

Anyway, I have an idea how to solve (or rather work around) the problem
and will get if working on models in the next version of the series.
I'll send you a modified version of the relevant patch before that so
you can test it.

Thanks for your time!

Pawe?
