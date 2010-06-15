From: mhowe@cwlinux.com (Morgan Howe)
Date: Tue, 15 Jun 2010 11:29:36 +0800
Subject: mxcmmc driver hangs on sync
Message-ID: <20100615112936.5d03ce92@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'm using a freescale i.mx27 board with 2 class 2 sdhc cards.
Originally we were working with the 2.6.22 kernel from freescale, but
found that after an extended period of writing to the SD card (around
2k-3k writes of a 1mb file), the driver would hang when we called the
sync command. It appeared to be an issue related to dma interrupts.

Since we have been wanting to move to the newer kernel anyway, I
decided to try a similar test using the current mainline kernel from
Linus' tree.  Basically, my test is a simple bash script which does
this:

while(true) {
cp 1mb_test_file SD1
cp SD1/1mb_test_file SD2
sync
}

With the older kernel this would hang on sync after a few thousand
loops, and much sooner if you ran 2 or 3 of these processes at a time.
I tried last night with the newer kernel and kicking off 3 processes
and after ~100-150 loops per process I get this:

mxc-mmc mxc-mmc.0: mxcmci_finish_data: No CRC -ETIMEDOUT
mmcblk0: error -110 transferring data, sector 24765007, nr 512, card
status 0x0 mmcblk0: error -110 sending stop command, response 0x0, card
status 0x0 end_request: I/O error, dev mmcblk0, sector 24765021
end_request: I/O error, dev mmcblk0, sector 24765023
end_request: I/O error, dev mmcblk0, sector 24765031
end_request: I/O error, dev mmcblk0, sector 24765039
...
<snip>

It then continues for ~20 more loops per process, and then again I get
that same error. Continues for a while longer and then finally this:

mxc-mmc mxc-mmc.1: mxcmci_finish_data: No CRC -ETIMEDOUT
mmcblk1: error -110 transferring data, sector 8859727, nr 144, card
status 0xc00 FEC: MDIO read timeout

And I can see in the output from ps:

  535 0         2808 S    /bin/sh ./test.sh 
  673 0         2808 S    /bin/sh ./test.sh 
  747 0         2808 S    /bin/sh ./test.sh 
 2097 0         2672 D    sync 
 2098 0         2672 D    sync 
 2099 0         2672 D    sync 
 2261 0            0 SW   [flush-179:8]
 2262 0         3052 R    ps

Has anyone seen this or have any suggestions how I may be able to go
about fixing it?

Regards,
Morgan
