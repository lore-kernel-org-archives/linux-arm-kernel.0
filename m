From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 31 Aug 2017 00:43:28 +0000
Subject: [PATCH v2 0/5] make XIP kernel .data compressed in ROM
In-Reply-To: <nycvar.YSQ.7.76.1708301951330.2606@knanqh.ubzr>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <SG2PR06MB1165EF18A363D9CC4C5531FE8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1708301951330.2606@knanqh.ubzr>
Message-ID: <SG2PR06MB11652EB1FEDDE2F40AE763B18A9D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 30, 2017, Nicolas Pitre wrote:
> > > This work highlighted some defficiencies in linker scripts, especially
> > > the XIP one. So this also includes linker script cleanups and fixes.
> >
> > Thank you for this!
> 
> More will come eventually.
> 
> Did this fix your cramfs issue with 4.13-rc7?

Yes!
I just stacked on your latest set of cramfs XIP patches on top of these 
and now magically it boots again.
Thank you!

Notice that busybox, libc and ld have physical addresses in Flash (ie, XIP)

$ cat /proc/self/maps
00008000-000a1000 r-xp 1b005000 00:0c 18192      /bin/busybox
000a9000-000aa000 rw-p 00099000 00:0c 18192      /bin/busybox
000aa000-000ac000 rw-p 00000000 00:00 0          [heap]
b6eed000-b6fc6000 r-xp 1b0bc000 00:0c 766540     /lib/libc-2.18-2013.10.so
b6fc6000-b6fce000 ---p 1b195000 00:0c 766540     /lib/libc-2.18-2013.10.so
b6fce000-b6fd0000 r--p 000d9000 00:0c 766540     /lib/libc-2.18-2013.10.so
b6fd0000-b6fd1000 rw-p 000db000 00:0c 766540     /lib/libc-2.18-2013.10.so
b6fd1000-b6fd4000 rw-p 00000000 00:00 0
b6fd4000-b6feb000 r-xp 1b0a4000 00:0c 670372     /lib/ld-2.18-2013.10.so
b6fee000-b6fef000 rw-p 00000000 00:00 0
b6ff0000-b6ff2000 rw-p 00000000 00:00 0
b6ff2000-b6ff3000 r--p 00016000 00:0c 670372     /lib/ld-2.18-2013.10.so
b6ff3000-b6ff4000 rw-p 00017000 00:0c 670372     /lib/ld-2.18-2013.10.so
bee27000-bee48000 rw-p 00000000 00:00 0          [stack]
beea4000-beea5000 r-xp 00000000 00:00 0          [sigpage]
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]


Chris
