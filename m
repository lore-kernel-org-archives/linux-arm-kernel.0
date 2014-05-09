From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 May 2014 22:12:32 +0200
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <20140509184505.GA30330@arch.cereza>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-4-git-send-email-arnd@arndb.de>
 <20140509184505.GA30330@arch.cereza>
Message-ID: <28202282.tsYsyDGHCL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 May 2014 15:45:05 Ezequiel Garcia wrote:
> On 08 May 04:56 PM, Arnd Bergmann wrote:
> 
> I gave this a try in order to answer Arnd's performance question.

Thanks a lot for testing!

> First of all,
> the patch seems wrong. I guess it's because readsl reads 4-bytes pieces, instead of
> 8-bytes.

Oops. I guess I was thinking of a 64-bit system and didn't even notice
the difference between 4 and 8 byte accesses here. I wonder where I have
my mind sometimes.

> In other words, the patch is still half-untested. Therefore, and given
> this is meant only to coherce a build, maybe we'd rather just loop over
> readb and stay on the safe side?

I guess that would be equal to calling memcpy_fromio().

> And now, answering Arnd's question:
> 
> # Using ldrd
> # time nanddump /dev/mtd5 -f /dev/null -q
> real	0m 5.90s
> user	0m 0.22s
> sys	0m 5.67s
> 
> # Using readsl
> # time nanddump /dev/mtd5 -f /dev/null -q
> real	0m 6.39s
> user	0m 0.17s
> sys	0m 6.20s
> 
> So I'd say, let's stick to the ldrd magic.

Ok, that is a noticeable difference. For scale, what is the size of that partition?
If this is something that actually affects people, it might be worth also trying
memcpy(), which should be better at saturating the bus, but might be wrong here
(if alignment the alignment requirements on the external bus are stricter than
what memcpy does) or it might not make a difference at all if the code is already
ideal.

	Arnd
