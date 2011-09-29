From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 10:46:02 +0100
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <20110929094243.GC25061@e102144-lin.cambridge.arm.com>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
	<4E83D25C.6020306@codeaurora.org>
	<20110929092102.GB25061@e102144-lin.cambridge.arm.com>
	<20110929094243.GC25061@e102144-lin.cambridge.arm.com>
Message-ID: <20110929094602.GH23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:42:43AM +0100, Will Deacon wrote:
> Bah, just took this for a spin on my Realview-PBX (Cortex-A9) platform and
> the board won't boot unless I have a hardware debugger enabled that can
> service the comms channel. This contradicts the Kconfig text which says:
> 
> 	  It does include a timeout to ensure that the system does not
> 	  totally freeze when there is nothing connected to read.
> 
> so we certainly need to fix something!

One of the problems you'll encounter is that there's places where we
don't have any timer infrastructure (eg, decompressor) and software
timing loops won't work (they'll be too slow for the lower-end CPUs
and too fast for the upper-end CPUs.)

The best fix is probably to leave that as-is, but introduce a 'default'
output entry instead - so platforms which don't have any listed will
get that instead of the ICEDDC stuff.
