From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Nov 2012 23:32:57 +0100
Subject: [PATCH V2 1/4] arm: mvebu: increase atomic coherent pool size
 for armada 370/XP
In-Reply-To: <5099810D.9040902@web.de>
References: <5099810D.9040902@web.de>
Message-ID: <20121106223257.GB30428@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 10:28:45PM +0100, S?ren Moch wrote:
> resent as plain text, sorry.
> 
> 
> > For Armada 370/XP we have the same problem that for the commit
> > cb01b63, so we applied the same solution: "The default 256 KiB
> > coherent pool may be too small for some of the Kirkwood devices, so
> > increase it to make sure that devices will be able to allocate their
> > buffers with GFP_ATOMIC flag"
> 
> I see a regression from linux-3.5 to linux-3.6 and think there might
> be a fundamental problem
> with this patch. On my Kirkwood system (guruplug server plus) with
> linux-3.6.2 I see following
> errors and corresponding malfunction even with further increased
> (2M, 4M) pool size:
> 
> Oct 19 00:41:22 guru kernel: ERROR: 4096 KiB atomic DMA coherent
> pool is too small!
> Oct 19 00:41:22 guru kernel: Please increase it with coherent_pool=
> kernel parameter!
> 
> So I had to downgrade to linux-3.5 which is running without problems.
> 
> I use SATA and several DVB sticks (em28xx / drxk and dib0700).

I'm guess its the DVB sticks which are causing the problems. We have a
number of kirkwood devices with two SATA devices which had problems
until we extended the coherent_pool. The DVB sticks are probably take
more coherent RAM. There was also an issue found recently:

http://www.spinics.net/lists/arm-kernel/msg203962.html

That conversation has gone quiet, but that could be because the
participants are at ELCE.

	     Andrew
