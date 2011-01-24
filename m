From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 17:54:18 -0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124170304.GH24104@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
Message-ID: <000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My final mail on this subject.

Ah, and I was really enjoying our pleasant discussion...

> Take a mainline kernel.  Apply the attached three patches.  MMC
> will then work without any problems.  No hacks required.  There is
> *absolutely* *no* need to waste time with hardware modifications.
> 
> With this you will find that MMCI FIFO underruns/overruns are no
> longer any problem.

$ git log -1
commit d315777b32a4696feb86f2a0c9e9f39c94683649
Merge: 5a05a6d 1765e3a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jan 24 19:58:39 2011 +1000
[...]
$ git diff > changes.diff

Attached, I trust you will find all your changes there (and only them).

/ # uname -a
Linux (none) 2.6.38-rc2+ #11 SMP Mon Jan 24 17:11:35 GMT 2011 armv7l GNU/Linux
/ # cat /dev/sda > /dev/null &
/ # dd if=/dev/mmcblk0 of=/dev/null bs=64k count=128
dd: /dev/mmcblk0: Input/output error

And dmesg is full of:
[...]
mmcblk0: error -5 transferring data, sector 254, nr 2, cmd response 0x900, card status 0xb00
end_request: I/O error, dev mmcblk0, sector 254
mmcblk0: error -5 transferring data, sector 255, nr 1, cmd response 0x900, card status 0xb00
end_request: I/O error, dev mmcblk0, sector 255
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x900, card status 0x900
mmcblk0: retrying using single block read
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
[...]

Now:

$ git am 0001-arm-Improve-MMC-performance-on-Versatile-Express.patch

/ # uname -a
Linux (none) 2.6.38-rc2+ #12 SMP Mon Jan 24 17:41:53 GMT 2011 armv7l GNU/Linux
/ # cat /dev/sda > /dev/null &
/ # dd if=/dev/mmcblk0 of=/dev/null bs=64k count=128
128+0 records in
128+0 records out
8388608 bytes (8.0MB) copied, 1.501529 seconds, 5.3MB/s

> THERE IS NO ISSUE WITH MMCI.  THE HARDWARE DOES NOT NEED "FIXING".

I'm really pleased you think so. It's always nice to have happy customers :-)

Cheers!

Pawe?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: changes.diff
Type: application/octet-stream
Size: 7990 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110124/35e18346/attachment-0001.obj>
