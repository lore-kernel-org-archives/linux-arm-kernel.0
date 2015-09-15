From: vdonnefort@gmail.com (Vincent Donnefort)
Date: Tue, 15 Sep 2015 11:09:10 +0200
Subject: [PATCH v2] net: mvneta: fix refilling for Rx DMA buffers
In-Reply-To: <CAA-51jNFeJn5ZPz5JRcK1Cv3WnFnDWV--SN2fqCNMyxxKrdmhg@mail.gmail.com>
References: <1437303653-2236-1-git-send-email-simon.guinot@sequanux.org>
 <20150721.003033.1524284435822402813.davem@davemloft.net>
 <CAA-51jPPDHfE1uT2NuJ53wWTvEgh7DcW0K0-xZgQdjAD2CC04w@mail.gmail.com>
 <20150914221320.GA7306@kw.sim.vm.gnt>
 <CAA-51jNFeJn5ZPz5JRcK1Cv3WnFnDWV--SN2fqCNMyxxKrdmhg@mail.gmail.com>
Message-ID: <20150915090909.GA1326@ns3274321.ip-5-39-88.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oren,

On Mon, Sep 14, 2015 at 03:16:50PM -0700, Oren Laskin wrote:
> I would hit this error on my Armada 370 board about 20% of the time
> after downloading a 30MB file to /tmp.  We're running a 1 Gb SGMII
> link.  I would hit this in less than a minute before removing this
> commit from my tree.  I've now been running this test in a loop for a
> few hours with no problems.

I didn't managed to reproduce the issue on a a370-rd board.

What defconfig file are you using? If not mvebu_v7_defconfig, can you
give a try with it?

What kind of hardware are you using?

-- 
Vincent.

> 
> It was somewhat hard to diagnose since files I used scp didn't see the
> issues (or at least as quickly).  I set up an http program to serve a
> file and replicated the problem with wget and found it.
> 
> Oren
> 
> On Mon, Sep 14, 2015 at 3:13 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> > Hi Oren,
> >
> > On Mon, Sep 14, 2015 at 01:22:12PM -0700, Oren Laskin wrote:
> >> I had to undo this change on my Amada 370 based board.  It was causing
> >> corrupt data to make it through on large downloads.  I'm using wget to get
> >> the same 30MB file many times and the SHA would occasionally be different.
> >
> > During your tests, can you see some "Linux processing - Can't refill"
> > messages along with the data corruptions ?
> >
> >> I tracked it down to this commit.  In it, I would find on the order of a
> >> few hundred bytes to simply be wrong data.
> >
> > I am little bit surprised here. For me, this patch is very simple and
> > does the exact opposite. It does fix kernel crashes and data corruptions
> > in case of refilling errors. This can happen for example if you run
> > large data transfers with jumbo frames enabled...
> >
> > But anyway, I'll try to reproduce the issue tomorrow. I only have to
> > wget the same file (size 30MB) in a loop and to check its md5sum ?
> > That's it ? And how long should I wait for the error ?
> >
> > Thanks,
> >
> > Simon
> >
> >>
> >> Thanks,
> >>
> >> Oren
> >>
> >> On Tue, Jul 21, 2015 at 12:30 AM, David Miller <davem@davemloft.net> wrote:
> >>
> >> > From: Simon Guinot <simon.guinot@sequanux.org>
> >> > Date: Sun, 19 Jul 2015 13:00:53 +0200
> >> >
> >> > > With the actual code, if a memory allocation error happens while
> >> > > refilling a Rx descriptor, then the original Rx buffer is both passed
> >> > > to the networking stack (in a SKB) and let in the Rx ring. This leads
> >> > > to various kernel oops and crashes.
> >> > >
> >> > > As a fix, this patch moves Rx descriptor refilling ahead of building
> >> > > SKB with the associated Rx buffer. In case of a memory allocation
> >> > > failure, data is dropped and the original DMA buffer is put back into
> >> > > the Rx ring.
> >> > >
> >> > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >> > > Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
> >> > network unit")
> >> > > Cc: <stable@vger.kernel.org> # v3.8+
> >> > > Tested-by: Yoann Sculo <yoann@sculo.fr>
> >> >
> >> > Applied, thanks.
> >> >
> >> > _______________________________________________
> >> > linux-arm-kernel mailing list
> >> > linux-arm-kernel at lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >> >
