From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:01:17 +0200
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <20170521074535.4a4ba6dd@bbrezillon>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
Message-ID: <20170522070117.mwk4gm34o7idedye@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 21, 2017 at 07:45:35AM +0200, Boris Brezillon wrote:
> > >> [    7.130000] ubi0: scanning is finished
> > >> [    7.150000] ubi0: attached mtd4 (name "rootfs", size 496 MiB)
> > >> [    7.160000] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 
> > >> 258048
> > >> bytes
> > >> [    7.170000] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page 
> > >> size
> > >> 1024
> > >> [    7.180000] ubi0: VID header offset: 1024 (aligned 1024), data
> > >> offset: 4096
> > >> [    7.190000] ubi0: good PEBs: 1977, bad PEBs: 7, corrupted PEBs: 0
> > >> [    7.200000] ubi0: user volume: 1, internal volumes: 1, max. volumes
> > >> count: 128
> > >> [    7.210000] ubi0: max/mean erase counter: 3/1, WL threshold: 4096,
> > >> image sequence number: 1444477407
> > >> [    7.220000] ubi0: available PEBs: 1, total reserved PEBs: 1976, 
> > >> PEBs
> > >> reserved for bad PEB handling: 33  
> > > 
> > > UBI attach works...
> > >   
> > >> [    7.240000] hctosys: unable to open rtc device (rtc0)
> > >> [    7.250000] vcc3v0: disabling
> 
> Interestingly, it starts failing after the core disables all unused
> regulators. Not sure this is related but that's worth having a look.
> 
> I looked at the schematics and it seems VCC-3V3 (which is powering the
> NAND chip) is enabled with the EXTEN pin of the AXP209 [1]. I don't know
> if this pin is controlled by Linux, but maybe you can dump register
> 0x12 and check if EXTEN is set to 1.
> 
> > >> [    7.250000] ALSA device list:
> > >> [    7.260000]   #0: sun4i-codec
> > >> [    7.260000] ubi0: background thread "ubi_bgt0d" started, PID 53
> > >> [    8.320000] sunxi_nand 1c03000.nand: wait interrupt timedout
> > >> [    9.320000] sunxi_nand 1c03000.nand: wait interrupt timedout
> > >> [   10.330000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO 
> > >> timedout
> > >> [   11.340000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO 
> > >> timedout
> > >> [   12.350000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO 
> > >> timedout
> > >> [   13.360000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO 
> > >> timedout
> > >> [   14.370000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO 
> > >> timedout
> > >> [   14.380000] ubi0 warning: ubi_io_read: error -110 while reading 
> > >> 4096
> > >> bytes from PEB 1034:4096, read only 0 bytes, retry  
> > > 
> > > And suddenly you get timeouts. That's really weird.  

This just made me realise, this is also the time where the clocks are
disabled, and we changed our clock implementation in 4.11.

And using the 4.4 DT will keep the old driver...

Did you test in 4.11? If it's also broken, could you try to revert
1f4ce3b6ca79 and 6b48644b1d29 (I'm not sure it's going to be a trivial
revert, but in that order it should work).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/b51637bf/attachment.sig>
