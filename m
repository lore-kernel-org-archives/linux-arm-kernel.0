From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Jun 2016 18:16:16 +0100
Subject: orion5x: initrd fails to load due to reserved memory
In-Reply-To: <20160625162040.GA15367@jirafa.cyrius.com>
References: <20160625162040.GA15367@jirafa.cyrius.com>
Message-ID: <20160625171615.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 09:20:40AM -0700, Martin Michlmayr wrote:
> I ported Debian to the HP Media Vault mv2120 (based on orion5x) many
> years ago.  Debian stable (jessie), based on 3.16 kernel, works fine.
> A user told me a few months ago that the version of Debian currently
> in development (based on 4.6) doesn't boot.
> 
> The boot loader loads the kernel to 0x400000 and the ramdisk 0x200000
> after that location, i.e. at 0x600000:

So you're giving the kernel zImage just 2MB here.  How large is the
4.6 zImage?  Does the zImage have a dtb appended?

> Booting the image (@ 0x400000) with RamDisk (@ 0x600000)...
> 
> Unfortunately, with 4.x, this leads to:
> 
> INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd

Right, so the kernel worked out that something else overwrote the
initramfs.  If you boot with memblock=debug, and memblock should
dump out the memory and reserved regions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
