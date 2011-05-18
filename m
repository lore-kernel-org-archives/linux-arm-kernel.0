From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 18 May 2011 11:50:46 -0700
Subject: [GIT PULL v2 0/3] TrimSlice updates for 2.6.40
In-Reply-To: <20110518161230.GA3029@gentoodev.compulab.local>
References: <cover.1305576864.git.mike@compulab.co.il>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAB1E@HQMAIL01.nvidia.com>
	<20110518161230.GA3029@gentoodev.compulab.local>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A47A69@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mike at compulab.co.il wrote at Wednesday, May 18, 2011 10:13 AM:
> Hi Stephen,
> 
> On Tue, May 17, 2011 at 01:41:56PM -0700, Stephen Warren wrote:
> > Mike Rapoport wrote at Monday, May 16, 2011 2:23 PM:
> > > Hi Colin,
> > > Please consider pulling TrimSlice updates for 2.6.40 merge window.
> > > These patches add registration of i2c, audio and USB devices.
> >
> > Second, I tried to test this, but failed. I hit two issues:
> >
> > 1) USB didn't seem to work for me; the following prints continuously:
> >
> > [   93.952248] usb 3-1: new high speed USB device number 126 using tegra-ehci
> > [   94.022291] hub 3-0:1.0: unable to enumerate USB device on port 1
> >
> > This means I can't use the built-in SSD as the root filesystem.
> >
> > I see this problem irrespective of whether I tell U-Boot to initialize
> > USB before booting or not.
> 
> Yeah, this is caused by issue with USB1 port reset. Greg already took
> the patch that fixes it (1).
> [1] http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg00581.html

OK, I applied that, and USB appears to work; I could mount the SSD OK.

I found a way to get around aplay/speaker-test crashing (which happens
both with the ChromeOS filesystem or the Ubuntu filesystem shipped with
the Trimslice). If you specify which ALSA PCM device to use ("-D hw:0,0")
then they both work OK.

That said, I do still see some issues. Specifically, when I play audio,
USB and/or MMC IO appear to go south, and then recovers when audio
playback terminates:

chronos at localhost ~ $ aplay -D hw:0,0 /home/abba-dq-48000-stereo.wav 
Playing WAVE '/home/abba-dq-48000-stereo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
[   90.434741] usb 3-1: USB disconnect, device number 2
[   90.722342] hub 3-0:1.0: unable to enumerate USB device on port 1
<repeats about every 300mS>
^C Aborted by signal Interrupt...
chronos at localhost ~ $ [   97.262302] usb 3-1: new high speed USB device number 27 using tegra-ehci
[   97.684058] usb 3-1: New USB device found, idVendor=05e3, idProduct=0718
[   97.690758] usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
[   97.698354] usb 3-1: Product: USB Storage
[   97.702511] usb 3-1: SerialNumber: 000000000033
[   97.710500] scsi1 : usb-storage 3-1:1.0
[   99.492400] scsi 1:0:0:0: Direct-Access     SanDisk  SSD P4 8GB       0015 PQ: 0 ANSI: 0
[   99.502508] sd 1:0:0:0: [sda] 15649196 512-byte logical blocks: (8.01 GB/7.46 GiB)
[   99.522376] sd 1:0:0:0: [sda] Write Protect is off
[   99.527169] sd 1:0:0:0: [sda] Assuming drive cache: write through
[   99.572658] sd 1:0:0:0: [sda] Assuming drive cache: write through
[   99.592671]  sda: sda1
[   99.597539] sd 1:0:0:0: [sda] Assuming drive cache: write through
[   99.604184] sd 1:0:0:0: [sda] Attached SCSI disk

Sometimes this affects mmcblk0 too.

This happens irrespective of whether my root filesystem is on USB (with
no SD card plugged in) or on SD card.

That said, I think these issues are some pre-existing condition that was
simply exposed because this patchset now enables USB and audio. Hence,
not a problem with the changes in the patch set itself.

Do you have a kernel branch that's been tested with the Ubuntu build
that shipped on the TrimSlice's SSD that I could test with? Alternatively,
how did you create the filesystem you're testing with, so I could test
with that instead?

Thanks.

-- 
nvpublic
