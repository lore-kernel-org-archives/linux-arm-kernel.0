From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Feb 2015 17:26:20 +0100
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <20150211163343.GH11169@kwain> (Antoine Tenart's message of "Wed,
 11 Feb 2015 17:33:43 +0100")
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <20150209005503.3fad39c7@bbrezillon> <871tlx7dgu.fsf@free.fr>
 <20150211163343.GH11169@kwain>
Message-ID: <87k2zn5c5v.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine Tenart <antoine.tenart@free-electrons.com> writes:

>> All these ifs per variant will add complexity to the current driver, won't they
>> ?
>
> Given the current state of this driver I believe this would be a better
> idea to first rework it to use the nand framework properly. Then it will
> be possible to have a look on what we have, to decide whether or not a
> mrvl-nand-lib is needed.

I don't fully agree to delay.
You're taking code, making sometimes copy-paste, for the berlin specific
functions, and I think you're taking the bugs as well, which duplicates the fix
effort.

For example, in nand_cmdfunc_berlin():
+	if (info->reg_ndcr & NDCR_DWIDTH_M)
+		column /= 2;

This is I think a copy-paste from its twin nand_cmdfunc(). Now consider what
happens if the command is _not_ a read command, but an ONFI READID command
(ONFI being specified by column=0x20 if memory serves me well).

This is the reason I don't really like this patch. And this is also the reason
why I believe you're in a perfect timing to improve things, by grouping the
common function, and keeping the bugs in only one place, not many.

Cheers.

-- 
Robert
