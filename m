From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Dec 2015 12:20:38 +0000
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151215093325.GK13531@pali>
References: <20150713131902.GH26485@atomide.com>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr>
 <201511300115.12478@pali> <20151130152352.GY2517@atomide.com>
 <20151130153933.GD29576@pali>
 <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
 <20151215093325.GK13531@pali>
Message-ID: <20151215122038.GI30871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:33:25AM +0100, Pali Roh?r wrote:
> So am I understand correctly that solution would be to hack
> arch/arm/mm/mmu.c to not overwrite page at PHYS_OFFSET?

That's completely unnecessary: there are enough platform hooks to cope
with whatever the platform requires.

If you want to reserve the memory, then you have the ->reserve callback,
where you can call:

	memblock_reserve(PHYS_OFFSET, PAGE_SIZE);

if you wish to prevent the first page being overwritten.  You're then
responsible for freeing this page later in the boot sequence, or you
could just keep it around and refer to the atags in that page directly.

You could also just save_atags() in there, with a comment saying that
this is a work-around for N900 which needs the ATAGs saved, and this
is allowed in ->reserve as a special exception.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
