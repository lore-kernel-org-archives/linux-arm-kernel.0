From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 18:09:44 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
Message-ID: <20110124180944.GK24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:54:18PM -0000, Pawel Moll wrote:
> $ git am 0001-arm-Improve-MMC-performance-on-Versatile-Express.patch
> 
> / # uname -a
> Linux (none) 2.6.38-rc2+ #12 SMP Mon Jan 24 17:41:53 GMT 2011 armv7l GNU/Linux
> / # cat /dev/sda > /dev/null &
> / # dd if=/dev/mmcblk0 of=/dev/null bs=64k count=128
> 128+0 records in
> 128+0 records out
> 8388608 bytes (8.0MB) copied, 1.501529 seconds, 5.3MB/s
> 
> > THERE IS NO ISSUE WITH MMCI.  THE HARDWARE DOES NOT NEED "FIXING".
> 
> I'm really pleased you think so. It's always nice to have happy customers :-)

If you're flooding the system with USB traffic, enlargening the FIFO size
won't help.  Making the FIFO larger just decreases the _interrupt_ _latency_
requirements.  It doesn't mean you can cope with the amount of data being
transferred.

	if (cycles-to-transfer-usb-packets + cycles-to-transfer-MMC-data >
			available-cpu-cycles)
		you_are_stuffed(even_with_larger_fifo);

So I'm not surprised that running USB and MMC at full speed results in
MMC losing out.  You will find that even with a larger FIFO, MMC will
still lose out.

Why?  The ISP1761 can store the packets without complaint, and the host
CPU can read them when it's ready.  As soon as one packet is read off
the host, the next packet is probably sitting there waiting for the
host CPU to read it.  When the ISP1761 buffer becomes full, it can
tell the device to stop sending data.

The result of that is the ISP1761 will be able to transfer data as fast
as the host CPU can possibly go - to the exclusion of the MMC interface.
No amount of FIFO (well, except several KB to cover the _largest_ size
of MMC transfer we request) will resolve the problem of USB and MMC
sharing the same CPU.
