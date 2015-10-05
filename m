From: peda@lysator.liu.se (Peter Rosin)
Date: Mon, 5 Oct 2015 10:45:29 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <560F0DB1.2020101@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se>
Message-ID: <561238A9.1060406@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-03 01:05, Peter Rosin wrote:
> Hi!
> 
> I recently upgraded from the atmel linux-3.18-at91 kernel to vanilla 4.2
> and everything seemed fine. Until I tried to write to the little eeprom
> chip. I then tried the linux-4.1-at91 kernel and that suffers too.
> 
> The symptoms are that it seems like writes get interrupted, and restarted
> again without properly initializing everything again. Inspecting the i2c
> bus during these fails gets me something like this (int hex) when I
> 
> echo abcdefghijklmnopqr > /sys/bus/i2c/devices/0-0050/eeprom
> 
> S a0 00 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 P
> S a0 10 (clk and data low for a "long" time) 10 71 72 0a P
> 
> Notice how the address byte in the second chunk (10) is repeated after
> the strange event on the i2c bus.
> 
> I looked around and found that if I revert a839ce663b3183209fdf7b1fc4796bfe2a4679c3
> "eeprom: at24: extend driver to allow writing via i2c_smbus_write_byte_data"
> eeprom writing starts working again.
> 
> AFAICT, the i2c-at91 bus driver makes the eeprom driver use the
> i2c_transfer code path both with that patch and with it reverted,
> so I sadly don't see why the patch makes a difference.
> 
> I'm on a board that is based on the sama5d31 evaluation kit, with a
> NXP SE97BTP,547 chip and this in the devicetree:
> 
> 			i2c0: i2c at f0014000 {
> 				status = "okay";
> 
> 				jc42 at 18 {
> 					compatible = "jc42";
> 					reg = <0x18>;
> 				};
> 
> 				eeprom at 50 {
> 					compatible = "24c02";
> 					reg = <0x50>;
> 					pagesize = <16>;
> 				};
> 			};

Ok, I found the culprit, and I double and triple checked it this time...

If I move to the very latest on the linux-3.18-at91 branch, the bug is
there too. Which made it vastly more palatable to bisect the bug.

The offender (in the 4.2 kernel) is 93563a6a71bb69dd324fc7354c60fb05f84aae6b
"i2c: at91: fix a race condition when using the DMA controller"
which is far more understandable. Ao, adding Cyrille Pitchen to the Cc list.

If I add that patch on top of my previously working tree, it behaves just
as newer kernels, i.e. equally bad. The patch doesn't revert cleanly, but
reverting the patch and quick-n-dirty-fixing the conflict on vanilla 4.2
makes the problem go away.

I have attached what I actually reverted.

Cheers,
Peter

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Revert-i2c-at91-fix-a-race-condition-when-using-the-.patch
Type: text/x-patch
Size: 7502 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/246115fb/attachment.bin>
