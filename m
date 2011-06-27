From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2011 11:02:12 +0100
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
	<BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
	<BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
Message-ID: <20110627100212.GA16103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 11:42:52AM +0200, Per Forlin wrote:
> Conclusion:
> Working with mmc the relative cost of DSB is almost none. There seems
> to be slightly higher number for mmc blocking requests with the DSB
> patch compared to not having it.

These figures suggest that dsb is comparitively not heavy on the hardware
you're testing.

I think I'm going to apply the patch anyway - it certainly makes stuff
no worse, and if someone has a platform where dsb is more expensive,
then they should see a greater benefit from this change.

The next thing to think about in DMA-land is whether we should total up
the size of the SG list and choose whether to flush the individual SG
elements or do a full cache flush.  There becomes a point where the full
cache flush becomes cheaper than flushing each SG element individually.
