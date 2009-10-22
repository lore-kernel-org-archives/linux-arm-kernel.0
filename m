From: utx@penguin.cz (Stanislav Brabec)
Date: Fri, 23 Oct 2009 00:09:48 +0200
Subject: [PATCH] Zaurus: Fix PROM partition table for spitz
In-Reply-To: <20091022214511.GB9364@elf.ucw.cz> (from pavel@ucw.cz on Thu
	Oct 22 23:45:11 2009)
Message-ID: <1256249388.1986.0@zaurus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2009-10-29 23:45:11 Pavel Machek wrote:
> On Fri 2009-10-23 05:33:27, Eric Miao wrote:
> > (I won't refuse some comments to make this more clear in the code
> > though).
> 
> I don't know. If the table is wrong, we should fix it. Yes, it may
> break someone, but it probably will not.

This change is not worse than change in .config, as there is no
guarantee of order of loading NAND and PROM maps.

I just looked at original 2.4 kernel. There were:
PROM EN-JP as "Filesystem", bootloader not mapped
NAND partitions as "smf", "root", "home"

This is an output of cat /proc/mtd on vendor's 2.4.20.

dev:    size   erasesize  name
mtd0: 006b0000 00020000 "Filesystem"
mtd1: 00700000 00020000 "smf"
mtd2: 02b00000 00020000 "root"
mtd3: 04e00000 00020000 "home"

We never were compatible:

Guessing from "file" output, EN-JP partition is just a file, not a
filesystem. I am OK with keeping of name "Boot PROM Filesystem" and
calling the new partition as "PROM Bootloader", but EN-JP in the name
cleanly describes the surprising contents. Adding bootloader data
partition has probably a single use case: Being easily able to grab
the PROM contents for the emulator.

-- 
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
