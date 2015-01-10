From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Jan 2015 19:56:59 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150110175030.186ef929@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150110163001.GA5392@lunn.ch> <20150110175030.186ef929@free-electrons.com>
Message-ID: <2707920.rUFmbmVqu6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 January 2015 17:50:30 Thomas Petazzoni wrote:
> 
> > For the IO Coherency fixes, obviousness is an issue. This is
> > especially true since your own comment is "still not working 100%
> > properly, but it is apparently not worse than it was."
> > 
> > Maybe the correct fix for stable is to simply disable the I/O
> > coherency hardware. That at least makes mainline stable.  Once we have
> > a real, well tested, 100% fix, take it via the normal merge window.
> 
> However, I'm not a big fan of this idea. I'd really like to have I/O
> coherency progressively improved, and made working.
> 
> The patch is actually make the code *simpler* since it removes the
> custom dma_map_ops and uses a set of operations that already exists in
> the kernel. The changes in the mvebu-mbus driver are minimal.

Despite my earlier analysis that concluded that the just using the
normal coherent dma_ops with this fix was correct on all hardware,
we have now seen a bug in the xor dmaengine driver (I haven't
seen a confirmation for my oneline fix yet, but I still think it's
the one), which gives us less confidence in the other drivers
being correct.

I think that your patch is the only sensible approach going forward
if we want coherent mappings, but we will need both more extensive
testing and more review of each affected device driver before
putting it into stable.

	Arnd
