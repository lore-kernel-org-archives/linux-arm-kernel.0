From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2011 19:31:51 +0100
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <alpine.LFD.2.00.1103291235380.11889@xanadu.home>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<alpine.LFD.2.00.1103281822170.11889@xanadu.home>
	<4D91C1EF.1040102@nokia.com>
	<alpine.LFD.2.00.1103291235380.11889@xanadu.home>
Message-ID: <20110329183151.GA18135@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 12:55:27PM -0400, Nicolas Pitre wrote:
> Sorry, I meant r15-indexed with a write back.

I believe that's unpredictable.  So actually you can make kprobes do
anything you like with it - no one should ever generate an instruction
which read-modify-writes the PC.  Easiest and most efficient solution
is to make it work the same way as it would do with any other register -
in other words, by all means do the necessary correction to perform the
load, but allow the writeback to go ahead even if that means that the
resulting PC value is wrong.  It doesn't matter as you've actually
implemented what is required.
