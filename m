From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 17:18:53 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <519CD920.5030301@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <519CD920.5030301@free-electrons.com>
Message-ID: <201305221718.53759.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Gregory CLEMENT wrote:
> >> Therefore, the last patch of this series adds some early code in the
> >> kernel, at the ->map_io() stage, to switch the internal registers from
> >> 0xD0000000 to 0xF1000000 if this has not been done already by the
> >> bootloader. As it was explained above, we unfortunately can't read the
> >> current base address of the internal register window, so we need a
> >> different mechanism to know if the bootloader has done the remapping
> >> at 0xF1000000 (new generation bootloader) or has left the internal
> >> registers at 0xD0000000 (old generation bootloader). In order to
> >> distinguish between those two cases, a CP15 bit is being used. Old
> >> bootloaders do not touch this CP15, so it is set to 0. New bootloaders
> >> set this CP15 bit to 1, so that the kernel knows that the remapping
> >> has already been done. The ->map_io() code looks at this bit to know
> >> if the remapping should be done or not.
> > 
> > As you already admit, using the CP15 register is a hack. It sounds
> > to me that a cleaner approach would be to put the correct address
> > into the device tree and use that value everywhere, rather than
> > hardcoding one or more addresses.
> 
> That means reading and decoding the device tree very early in the
> auto-uncompress part of the kernel.

Why that? I was only implying that we would have no console output in
the uncompressor, which is already the case on multiplatform these
days when DEBUG_LL is disabled.

	Arnd
