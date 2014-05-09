From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 May 2014 00:24:02 +0200
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <20140509220915.GA391@arch.cereza>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <20140509212810.GF18257@obsidianresearch.com>
 <20140509220915.GA391@arch.cereza>
Message-ID: <4160510.VJSlHZLhNz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 May 2014 19:09:15 Ezequiel Garcia wrote:
> # time nanddump /dev/mtd5 -f /dev/null -q
> real    0m 5.82s
> user    0m 0.20s
> sys     0m 5.60s
> 
> Jason: Care to submit a proper patch?
> 
> On 08 May 04:56 PM, Arnd Bergmann wrote:
> > Ok, that is a noticeable difference. For scale, what is the size of that partition?
> 
> The board is Openblocks A6, running mainline.
> 
> # cat /proc/mtd 
> dev:    size   erasesize  name
> mtd0: 00090000 00004000 "uboot"
> mtd1: 00044000 00004000 "env"
> mtd2: 00024000 00004000 "test"
> mtd3: 00400000 00004000 "conf"
> mtd4: 01d20000 00004000 "linux"
> mtd5: 01dec000 00004000 "user"

Ok, so it takes 5.6 seconds in kernel mode to access 31MB, which comes down
to 5.60MB/s. That isn't very fast compared to the time the CPU should take
for those instructions, so I'm surprised it actually makes any difference
at all.

There isn't a usable slave DMA engine in Armada XP by chance?

	Arnd
