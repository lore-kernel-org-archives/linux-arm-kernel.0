From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 May 2013 16:11:43 +0100
Subject: [PATCH] dmatest: abort transfers immediately when asked for
In-Reply-To: <1369139597-24446-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <20130516153553.GI11706@mudshark.cambridge.arm.com>
 <1369139597-24446-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <20130521151143.GH10453@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, May 21, 2013 at 01:33:17PM +0100, Andy Shevchenko wrote:
> When thread is going to be stopped we have to unconditionally terminate all
> ongoing transfers. Otherwise it would be possible that callback function will
> be called on the next interrupt and will try to access to already freed
> structures.
> 
> The patch introduces specific error message for this, though it doesn't
> increase the counter of the failed tests.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reported-by: Will Deacon <will.deacon@arm.com>

Thanks for persevering with this! Although this patch definitely fixes the
panic I was seeing, I now observe buffer verification failures in subsequent
test runs after an aborted run:

[   43.888424] dma0chan0-copy0: #1: transfer aborted with src_off=0x81f0 dst_off=0x9f4 len=0xdf29 (0)
[   43.888526] dma0chan0-copy0: terminating after 1 tests, 0 failures (status 0)
[   43.888635] dmatest: thread dma0chan0-copy0 exited with status 0

<reload module and start new tests>

[   77.341405] dma0chan0-copy0: #1: errors with src_off=0x8e29 dst_off=0x11dc8 len=0x2b93 (370)
[   77.341505] dma0chan0-copy0: terminating after 1 tests, 1 failures (status 0)

Note that the non-aborted transfers (I have 4 dma controllers) seem fine.

Looking at the results file doesn't show anything obvious, although I do
see some strange entries:

	[...]
	dstbuf not copied! [0xffffffff] Expected ff, got ff
	dstbuf not copied! [0xffffffff] Expected ff, got ff
	dstbuf not copied! [0xffffffff] Expected 00, got 00
	dstbuf not copied! [0xffffffff] Expected 00, got 00
	dstbuf not copied! [0xffffffff] Expected ff, got ff
	[...]

The more alarming ones look like:

	[...]
	dstbuf not copied! [0x147e9] Expected d5, got 36
	dstbuf not copied! [0x147ea] Expected d4, got 35
	dstbuf not copied! [0x147eb] Expected d3, got 34
	dstbuf not copied! [0x147ec] Expected d2, got 33
	dstbuf not copied! [0x147ed] Expected d1, got 32
	dstbuf not copied! [0x147ee] Expected d0, got 31
	[...]

Of course, this could be a driver bug with the PL330 that is being exposed
by this aborting code.

Will
