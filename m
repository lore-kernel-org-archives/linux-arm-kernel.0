From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 17:22:03 +0000
Subject: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
In-Reply-To: <4150271.zrLzq08T60@wuerfel>
References: <5868782.RxZY0W5S4d@wuerfel> <20151123163359.GC768@1wt.eu>
 <20151123163750.GT8644@n2100.arm.linux.org.uk>
 <4150271.zrLzq08T60@wuerfel>
Message-ID: <20151123172203.GU8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 05:52:38PM +0100, Arnd Bergmann wrote:
> On Monday 23 November 2015 16:37:50 Russell King - ARM Linux wrote:
> > Does that not depend on the architectures BUG() implementation?  If an
> > architecture implements it as a signalling illegal instruction and a
> > lookup table, changing it to be a panic() would probably be more code.
> 
> Correct, overall, we are down to a 1.40% size reduction compared to
> 1.70% without my patch and 1.49% with my version:
> 
> section     CONFIG_BUG=y    CONFIG_BUG=n    CONFIG_BUG=n+patch    panic("BUG!")
> 
>  .text            8320248   |     8180944   |     8207688	|  8221848
>  .rodata          3633720   |     3567144   |     3570648	|  3567344
>  __bug_table        32508   |         ---   |         ---	|      ---
>  __modver             692   |        1584   |        2176	|     1384
>  .init.text        558132   |      548300   |      550088	|   550592
>  .exit.text         12380   |       12256   |       12380	|    12448
>  .data            1016672   |     1016064   |     1016128	|  1016064
>  Total           14622556   |    14374510   |    14407326	| 14417898

Are you including dropping the bug table in these stats?  See BUG_TABLE
in include/asm-generic/vmlinux.lds.h.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
