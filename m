From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Apr 2015 15:36:50 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <2321040.CmsL1gluUd@wuerfel>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
Message-ID: <20150402153650.2cc9c3d7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 02 Apr 2015 15:28:09 +0200, Arnd Bergmann wrote:

> I think it would be better to add a new .dts file that includes the
> former, and give it a new name, such as armada-370-db-broken-uboot.dts.
> 
> We should not stop supporting the older versions, and it would be better
> to revert the bootloader change in their u-boot before it spreads too far.

Sorry, but I don't follow you.

What was wrong was the initial choice in U-Boot made to keep internal
registers at 0xd0000000. Having the registers at 0xf1000000 is what
should have been done from the beginning: it is the right thing to do,
and there is absolutely no reason to do a revert a go back to
0xd0000000.

Actually, having internal registers at 0xd0000000 is a very bad choice,
as it means that more space in the 0 -> 4 GB physical space is devoted
to I/O, which overlaps with RAM when you have 4+ GB of RAM. One of the
reason with moving the registers at 0xf1000000 is to be able to use as
much RAM as possible.

Also, the proposed change is exactly the same we've done on several
Marvell evaluation boards in the past:

  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-gp.dts?id=91ed32200e6ea1df19df01355c5c7747f9014102
  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-db.dts?id=82066bdb5a759ec00c18f9667853c4fe8840e83d

Those boards are evaluation boards from Marvell, only available to
selected customers, who are supposed to know what they are doing. And
all of those customers are getting boards with a new version of the
bootloader that remaps registers at 0xf1000000.

So the patch I'm proposing is simply fixing the kernel so that it works
for the customers who have access to this Armada 370 DB board.

If you want a file named armada-370-db-broken-uboot.dts, then it should
be the one using the 0xd0000000 register address. We can do that if you
like it, but this .dts file will just be useless clutter as nobody will
ever use it.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
