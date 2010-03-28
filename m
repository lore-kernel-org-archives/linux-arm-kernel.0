From: linuxmail@4lin.net (Denny Schierz)
Date: Sun, 28 Mar 2010 11:07:19 +0200
Subject: Dlink 323 HW version C1 : Fan Problem - 2.6.33.1
Message-ID: <1269767239.3051.1176.camel@mac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,


first some HW info:

nas:~# cat /proc/cpuinfo 
Processor       : Feroceon rev 0 (v5l)
BogoMIPS        : 332.59
Features        : swp half thumb fastmult edsp 
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 0

Hardware        : D-Link DNS-323
Revision        : 0000
Serial          : 0000000000000000

----- /proc/modules -----
  st 30325 0 - Live 0xbf129000
  sr_mod 13691 0 - Live 0xbf11f000
  cdrom 32503 1 sr_mod, Live 0xbf110000
  hwmon 1087 0 - Live 0xbf0f8000
  i2c_mv64xxx 4213 0 - Live 0xbf0d1000
  i2c_dev 5396 0 - Live 0xbf0ca000
  i2c_core 16164 2 i2c_mv64xxx,i2c_dev, Live 0xbf0be000
  tun 10706 0 - Live 0xbf0b5000
  nfsd 242179 13 - Live 0xbf069000
  exportfs 2876 1 nfsd, Live 0xbf063000
  evdev 6566 0 - Live 0xbf05c000
  ehci_hcd 31689 0 - Live 0xbf04d000
  mv_cesa 4524 0 - Live 0xbf046000
  usbcore 109880 2 ehci_hcd, Live 0xbf01b000
  gpio_keys 2843 0 - Live 0xbf015000
  aes_generic 32888 1 mv_cesa, Live 0xbf007000
  nls_base 5359 1 usbcore, Live 0xbf000000
----- /proc/modules end -----



I own a NAS form Dlink called DNS323. Normal it runs with the Dlink
Kernel 2.6.12.xx, but i installed Lenny with a newer kernel (cause of
ipv6 and much more) but i don't get the (Case) FAN running. He stops
after starting the kernel.

For the hardware revision A1 and B1 the I2C2 chip G760A is used, but I
have a C1 revision :-/ So it seems, that the chip is different, maybe.

I'm not able
to activate him (the fan), with echo, like:

nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18

echo 0 >  /sys/class/hwmon/hwmon0/device/pwm1
nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18


echo 255 >  /sys/class/hwmon/hwmon0/device/pwm1
nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18

nas:~# sensors
g760a-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:       2073 RPM  ALARM

lm75-i2c-0-48
Adapter: mv64xxx_i2c adapter
temp1:       +48.5 C  (high = +80.0 C, hyst = +75.0 C)

? http://www.cyrius.com/debian/orion/d-link/dns-323/specs.html


Some debug:

nas:~# i2cdetect -l
i2c-0   i2c  mv64xxx_i2c adapter       I2C adapter

nas:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- 0c -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- 68 -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

nas:~# i2cdump 0 0x0c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0xc, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
10: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
20: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
30: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
40: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
50: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
60: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
70: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
80: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
90: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
a0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
b0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
c0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
d0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
e0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
f0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????

nas:~# i2cdump 0 0x48
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x48, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 2d 00 4b 50 ff ff ff ff ff 50 ff ff ff ff ff ff    -.KP.....P......
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff 04 ff 00 ff 40 ff ff ff ff ff ff ff ff 47 01    .?... at ........G?


nas:~# i2cdump 0 0x68
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x68, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 88 46 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?F??.(?????????.
10: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
20: 92 46 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?F??.(?????????.
30: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
40: 95 46 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?F??.(?????????.
50: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
60: 99 46 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?F??.(?????????.
70: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
80: 02 47 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?G??.(?????????.
90: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
a0: 06 47 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?G??.(?????????.
b0: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
c0: 09 47 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?G??.(?????????.
d0: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????
e0: 13 47 04 08 00 28 03 10 80 80 1f 3f 3f 7f 7f 00    ?G??.(?????????.
f0: 00 00 ff 00 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2 a2    ....????????????


In the code from D-Link, i found the FAN address is normal 0x3e, but
only I get:

nas:~# i2cdump 0 0x3e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x3e, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

I found also some code lines, that speaks about 0x0b for FAN control,
but the output looks like 0x3e.

======================================

+		//+Vincent03212006
+		case SIOCDEVPRIVATE + 0x0b: //set fan speed
+//			offset = *data; //get or set decision flag
+//			value32 = *(data+1); //set rpm value
+//			printk("set offset %x,value32 %d\n",offset,value32);
+			copy_from_user(&fan_speed, rq->ifr_data, sizeof(FANSPEED));
+			
+			if(fan_speed.flag == 1) //set
+			{
+				mvFSCG760aSet(&fan_speed);
+			}
+			else if(fan_speed.flag == 2) //get
+			{
+				mvFSCG760aGet(&fan_speed);
+//				printk("program_speed %d, actual_speed %d, status %d\n",
+//
fan_speed.program_speed,fan_speed.actual_speed,fan_speed.status);
+				copy_to_user(rq->ifr_data, &fan_speed, sizeof(FANSPEED));
+			}
+
+			return 0;
+		//Vincent03212006+
+		 default:
+		 	return -EOPNOTSUPP;
+
+	}
+	
+	return 0;

======================================

but ... for which revision?


so, does anybody knows, how to resolve the problem?

cu denny



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100328/9b3b569e/attachment.sig>
