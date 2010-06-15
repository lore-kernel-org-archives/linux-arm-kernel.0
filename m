From: mhowe@cwlinux.com (Morgan Howe)
Date: Tue, 15 Jun 2010 18:32:00 +0800
Subject: mxcmmc driver hangs on sync
In-Reply-To: <20100615072237.GW17833@buzzloop.caiaq.de>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
	<20100615152051.26e4589c@morgan>
	<20100615072237.GW17833@buzzloop.caiaq.de>
Message-ID: <20100615183200.45164c20@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Daniel,


On Tue, 15 Jun 2010 09:22:37 +0200
Daniel Mack <daniel@caiaq.de> wrote:
> Could you try two things:
> 
> a) build a kernel without MX2 DMA support

I did this and ran the test again several times and the behavior seemed
basically the same.

Around 100 times, write the file to each SD and sync.
Then finally:

mxc-mmc mxc-mmc.0: mxcmci_finish_data: No CRC -ETIMEDOUT
mmcblk0: error -110 transferring data, sector 29692583, nr 512, card
status 0xc00 end_request: I/O error, dev mmcblk0, sector 29692863
... <snip ~20 similar I/O errors for other sectors>

After this it continues to write without problems and eventually:

Loop: 159
Loop: 162
Loop: 164
Loop: 187
mxc-mmc mxc-mmc.0: mxcmci_finish_data: No CRC -ETIMEDOUT
mmcblk0: error -110 transferring data, sector 29517031, nr 96, card
status 0xc00 end_request: I/O error, dev mmcblk0, sector 29517125

Loop # represents the number of times each of the four processes has
copied to SD1, copied from SD1 to SD2, and then called sync.  It
continues after this error again and then:

Loop: 228
Loop: 233
Loop: 231
Loop: 257
mxc-mmc mxc-mmc.1: mxcmci_finish_data: No CRC -ETIMEDOUT
mmcblk1: error -110 transferring data, sector 22419455, nr 56, card
status 0xc00

At this point I can see that all four of the test scripts are stuck
at calling sync.

> b) try 2.6.34, as there were some updates to the mxcmmc driver after
>    2.6.34 which could be related

I will try this, but may need a bit more time.

Regards,
Morgan
