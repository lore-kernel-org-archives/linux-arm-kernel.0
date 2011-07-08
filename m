From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 09:59:54 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028.ehs.local>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230945.GA8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062246130.14596@xanadu.home>
	<201107071817.11842.arnd@arndb.de>
	<81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028.ehs.local>
Message-ID: <20110708085954.GA2414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 11:08:38AM -0600, John Linn wrote:
> If I'm following this right....
> 
> We have a hole at the start of physical memory (when it's at 0) so that
> DMA can't DMA into it.  Sounds like that won't work for us?

That depends what you mean by that.

If you're saying that your physical RAM starts at some non-zero address,
then that isn't a problem.  We have lots of ARM platforms where that is
true.

If you're saying that the first N MB of RAM can't be DMA'd to, then that
is a problem as the kernel has no way to be told about that restriction.
The best we can manage is to avoid freeing that memory into the normal
allocation pools.

We do have a very small number of platforms where that's true, but we
'work around' that by having the kernel occupy that space.  If N MB is
less than sizeof(kernel) + 32K then you haven't lost much.
