From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Dec 2017 16:09:37 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171217150043.GA1403@1wt.eu>
References: <20171217120503.GA3323@1wt.eu>
 <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
 <20171217155305.16c5bb4f@bbrezillon> <20171217150043.GA1403@1wt.eu>
Message-ID: <20171217150937.GB1403@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 04:00:43PM +0100, Willy Tarreau wrote:
> > > Any idea why this issue is on v4.14, but not observed on v4.4?
> > 
> > I have absolutely no idea.
> 
> Warning, the 4.4 in openwrt very likely is heavily patched! That's also
> why I'm moving to mainline instead (to know what I'm using). I've seen
> some nand timeout changes in the patches. I don't know if anything else
> is applied to the driver (it's always a pain to find where to dig, as
> there is no unified list of all patches for a given architecture).

Given the description here, I suspect this is how they got rid of the
problem there :

  https://github.com/lede-project/source/blob/lede-17.01/target/linux/mvebu/patches-4.4/110-pxa3xxx_revert_irq_thread.patch

  ---
  Revert "mtd: pxa3xx-nand: handle PIO in threaded interrupt"
  
  This reverts commit 24542257a3b987025d4b998ec2d15e556c98ad3f
  This upstream change has been causing spurious timeouts on accesses
  to the NAND flash if something else on the system is causing
  significant latency.
  
  Nothing guarantees that the thread will run in time, so the
  usual timeout is unreliable.
  ---

Willy
