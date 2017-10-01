From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Oct 2017 22:42:15 +0200
Subject: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
Message-ID: <20171001204215.GA9928@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm trying to get qemu emulation of Nokia N900 to work, but
unfortunately i2c-omap.c breaks boot in the emulator (real hardware
works ok).

[    0.837524] omap2-onenand omap2-onenand: initializing on CS0, phys
base 0x01000000, virtual base d00c0000, freq 66 MHz
[    0.838958] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    0.839752] OneNAND version = 0x0121
[    0.842102] Scanning device for bad blocks
[    1.012451] 6 ofpart partitions found on MTD device omap2-onenand
[    1.013153] Creating 6 MTD partitions on "omap2-onenand":
[    1.014007] 0x000000000000-0x000000020000 : "bootloader"
[    1.018066] 0x000000020000-0x000000080000 : "config"
[    1.020660] 0x000000080000-0x0000000c0000 : "log"
[    1.022827] 0x0000000c0000-0x0000002c0000 : "kernel"
[    1.025848] 0x0000002c0000-0x0000004c0000 : "initfs"
[    1.028106] 0x0000004c0000-0x000010000000 : "rootfs"
[    1.047668] omap_i2c 48070000.i2c: addr: 0x004b, len: 2, flags:
0x0, stop: 1
[    1.048828] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.049530] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.050018] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.050476] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.050872] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.051422] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.052001] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.052398] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.052825] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.053222] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.053619] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.054016] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.054412] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
[    1.054840] omap_i2c 48070000.i2c: IRQ (ISR = 0x0010)
...

After 100 messages I get "Too much work in one IRQ" message, and then
repeat. I tried just disabling omap_i2c in the dts, but 1) its not
easy 2) I'd lose quite fundamental functionality.

Ideas welcome.

Best regards,
								Pavel
								
PS: If anyone is interested, this is why working qemu would be useful:
https://wiki.postmarketos.org/wiki/Nokia_N900_(nokia-rx51) . There's a
lot of work to be done in the userspace, and swapping SD cards is kind
of slow.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171001/807547fb/attachment.sig>
