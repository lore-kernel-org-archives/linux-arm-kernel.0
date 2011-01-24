From: Pawel.Moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 19:59:03 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124180944.GK24104@n2100.arm.linux.org.uk>
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
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If you're flooding the system with USB traffic, enlargening the
> FIFO size won't help.  Making the FIFO larger just decreases the
> _interrupt_ _latency_ requirements.  It doesn't mean you can
> cope with the amount of data being transferred.

On VE both ISP and MMCI are sharing the same static memory interface, which naturally limit their throughput. The ISP has a limited transfer buffer (about 60kB) and will not start new transfers before there is some space available. And of course USB devices are unable to initiate _any_ transactions on their own, so host can simply stall the bus on its discretion.

In my example, when I'm reading as much data from an USB device as possible, the ISP buffer will be filled at some point and the interrupt asserted. Now the handler will perform its duties. I'm guessing (not sure, I'm just unable to read this code today) it gathers all the received transfers and schedules new descriptors, then return. And now it's the MMC opportunity - if it can "survive", not being starved, till this moment (and, as experiments suggest it's about 1.3ms in the worst case scenario), it has a chance to grab CPU's attention, before the USB transfers are finished and the USB interrupt asserted again. If not that - I'll try to bump up MMC interrupt priority.

But it's all theory right now, just what I'm hoping to achieve, and - will all due respect - it's not your decision whether or not we perform this exercise. And there are virtually no changes to the driver required - all we have to do is to add additional "struct variant_data", so you may not be concerned about horrible driver hacks.

Of course you may be absolutely right and we won't succeed to make it much better. But even in this case we should be able to clock the card faster, which will bring performance gain on its own.

Good night!

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
