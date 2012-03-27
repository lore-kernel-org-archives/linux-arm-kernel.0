From: joancarles@fqingenieria.es (joancarles)
Date: Tue, 27 Mar 2012 10:46:45 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327101259.73525f9d@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
Message-ID: <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric

>> G'day
>>
>> This is still present, and we have absolutely no idea where to 
>> continue
>> searching for the solution of the problem. Any pointers? Any git 
>> trees
>> of mmc driver changes we could try? Anybody else with a MX25 that 
>> has
>> this issue?
>>
> does that attached patch fix your problem ?

YES, indeed it does to a certain degree. The timeout errors do not 
occur anymore and I can successfully perform many fs->ops, such as READ, 
WRITE, UNLINK ... . So thank you very much for this insight through your 
patch!

The speed of the card is excruciatingly slow, however. We roughly get 
between 34KB/s and 64KB/s from a dd if=/dev/zero write to any of the 
following partitions:

root at mx25-noah:~$> grep mmc /proc/mounts
/dev/mmcblk0p2 /media/card-ext3 ext3 
rw,sync,relatime,user_xattr,barrier=1,nodelalloc,data=ordered 0 0
/dev/mmcblk0p1 /media/card vfat 
rw,sync,relatime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 
0 0
root at mx25-noah:~$> df -kh | grep mmc
/dev/mmcblk0p2            1.7G    133.1M      1.5G   8% 
/media/card-ext3
/dev/mmcblk0p1          123.6M      2.7M    120.9M   2% /media/card
root at mx25-noah:~$> dd if=/dev/zero of=/media/card/test-10M bs=1024K 
count=10
10+0 records in
10+0 records out
10485760 bytes (10.0MB) copied, 296.004564 seconds, 34.6KB/s
root at mx25-noah:~$> dd if=/dev/zero of=/media/card-ext3/test-10M 
bs=1024K count=10
10+0 records in
10+0 records out
10485760 bytes (10.0MB) copied, 158.207481 seconds, 64.7KB/s

What's going on here, why is it so slow?

root at mx25-noah:~$> dmesg | grep -A1 CMD24
[  635.195042] mmc0: starting CMD24 arg 0e5c1600 flags 000000b5
[  635.195081] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0
--
[  635.199831] mmc0: req done (CMD24): 0: 00000900 00000000 00000000 
00000000
[  635.199866] mmc0:     512 bytes transferred: 0
--
[  635.200212] mmc0: starting CMD24 arg 0e5c1800 flags 000000b5
[  635.200251] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0
--
[  635.206516] mmc0: req done (CMD24): 0: 00000900 00000000 00000000 
00000000
[  635.206549] mmc0:     512 bytes transferred: 0
--
[  635.206892] mmc0: starting CMD24 arg 0e5c1a00 flags 000000b5
[  635.206932] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0
--
[  635.211763] mmc0: req done (CMD24): 0: 00000900 00000000 00000000 
00000000
[  635.211796] mmc0:     512 bytes transferred: 0
--
[  635.212409] mmc0: starting CMD24 arg 0e5c1c00 flags 000000b5
[  635.212449] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 300 ms 
nsac 0

Also, debugfs values don't make sense to me:

root at mx25-noah:/sys/kernel/debug/mmc0$> cat clock
50000000
root at mx25-noah:/sys/kernel/debug/mmc0$> cat ios
clock:		50000000 Hz
vdd:		17 (2.9 ~ 3.0 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	2 (sd high-speed)
root at mx25-noah:/sys/kernel/debug/mmc0$> cat mmc0\:0002/stat
state   status
root at mx25-noah:/sys/kernel/debug/mmc0$> cat mmc0\:0002/state
0x00000005
root at mx25-noah:/sys/kernel/debug/mmc0$> cat mmc0\:0002/status
00000900

Best regards and thank you so much for this real improvement of our 
situation here.
-- 
Joan C. Abelaira
