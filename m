From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Feb 2011 19:01:06 +0000
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <20110215230311.GT4152@n2100.arm.linux.org.uk>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Message-ID: <1297882866.20252.20.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> The adaptive clock
> rate algorithm can probably do with a lot more work to avoid it up-
> clocking to a rate which has proven to never work.  I'd actually go as
> far as to say that the algorithm probably has a lot to be desired - but
> it seems to work for my test scenarios.

I've just gave it a try (on top of a clean 2.6.38-rc5):


/ # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 2.922722 seconds, 437.9KB/s
/ # cat /dev/sda > /dev/null &
/ # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x900, card status 0xb00
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x900, card status 0xb00
mmcblk0: retrying with slower /2 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x900, card status 0xb00
mmcblk0: retrying with slower /4 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x900, card status 0xb00
mmcblk0: retrying with slower /8 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x900, card status 0xb00
mmcblk0: retrying with slower /16 clock rate
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.763456 seconds, 27.4KB/s
/ # kill %1
/ # 
[1]+  Terminated                 cat /dev/sda 1>/dev/null
/ # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.539866 seconds, 27.5KB/s
/ # sleep 30
/ # dd if=/dev/mmcblk0 of=/dev/null bs=128k count=10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.540215 seconds, 27.5KB/s


So it does the right thing with decreasing the clock rate in face of
problems, I just can't see it clocking it back up...

Cheers!

Pawe?
