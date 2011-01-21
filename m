From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 18:13:13 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <e95d92f6f19f474442f6e817067614e9.squirrel@www.codeaurora.org>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
	<20110120131239.GB23941@n2100.arm.linux.org.uk>
	<1295536094.9236.11.camel@m0nster>
	<ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
	<e95d92f6f19f474442f6e817067614e9.squirrel@www.codeaurora.org>
Message-ID: <20110121181313.GA23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 08:57:42AM -0800, Brent DeGraaf wrote:
> Russell,
> 
> I just had a chat with Daniel and I think I understand what you're doing
> now.  The reason for the original change was to ensure there was a barrier
> (dmb minimum) between population of the nc box structure and the command
> port write to the datamover.

> With the original code structure, the dsb for the cache management is
> happening too early to benefit the nc writes.

That DSB has precisely *nothing* to do with making sure that anything but
the cache operations which the DMA API performed are complete by the time
the API returns.

> Since dsbs are costly operations, I elected to call the other api, then do
> the cache management with its barrier after everything was populated.
> 
> Since the nc box and the command port writes are not using writel to do
> their assignment (unless I'm missing some change here),

You must not use writel on anything but ioremapped memory.  So that's
correct.

Writing to the device registers though should be using a memory accessor
like writel.  That contains the necessary barrier to ensure that any
previous writes to memory will be ordered with respect to device writes.

As you seem to already be using writel, you have all the necessary barriers
in place provided by architecture code.
