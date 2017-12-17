From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Dec 2017 16:00:43 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <20171217155305.16c5bb4f@bbrezillon>
References: <20171217120503.GA3323@1wt.eu>
 <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
 <20171217155305.16c5bb4f@bbrezillon>
Message-ID: <20171217150043.GA1403@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 03:53:05PM +0100, Boris Brezillon wrote:
> On Sun, 17 Dec 2017 11:27:51 -0300
> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> 
> > On 17 December 2017 at 09:05, Willy Tarreau <w@1wt.eu> wrote:
> > > Hello,
> > >
> > > I recently bought a Linksys WRT1900ACS which hosts an Armada 385 and a
> > > NAND flash. While I could get OpenWRT to work flawlessly on it using
> > > kernel 4.4, mainline 4.14.6 fails with a lot of such messages :
> > >
> > >     pxa3xx-nand f10d0000.flash: Wait time out!!!
> > >  
> > 
> > Boris,
> > 
> > Any idea why this issue is on v4.14, but not observed on v4.4?
> 
> I have absolutely no idea.

Warning, the 4.4 in openwrt very likely is heavily patched! That's also
why I'm moving to mainline instead (to know what I'm using). I've seen
some nand timeout changes in the patches. I don't know if anything else
is applied to the driver (it's always a pain to find where to dig, as
there is no unified list of all patches for a given architecture).

> > Also, is this somehow related to Armada 385 only?
> 
> I doubt it. My guess is that almost nobody uses JFFS2 these days, which
> may explain why this problem has not been detected before.

That's very likely indeed.

Ezequiel, to answer your question about dumping bad blocks, this flash
doesn't report any bad blocks yet (cool) however I could issue "nanddump
--oob --bb=dumpbad" on all MTD devices without issues. The last one has
8 BBT blocks. I didn't find any bad block, but I could confirm that
dumping oob apparently worked as it returned data that differs from the
non-oob dump on the last partition (the one containing the oob blocks),
so I guess we're fine :

# cmp -l raw oob 
40822793 377  61
40822794 377 164
40822795 377 142
40822796 377 102
40822797 377 126
40822798 377 115
40822799 377   1
40957961 377 115
40957962 377 126
40957963 377 102
40957964 377 142
40957965 377 164
40957966 377  60
40957967 377   1

Hoping this helps,
Willy
