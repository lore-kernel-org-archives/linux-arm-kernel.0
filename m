From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 15 Sep 2015 00:13:20 +0200
Subject: [PATCH v2] net: mvneta: fix refilling for Rx DMA buffers
In-Reply-To: <CAA-51jPPDHfE1uT2NuJ53wWTvEgh7DcW0K0-xZgQdjAD2CC04w@mail.gmail.com>
References: <1437303653-2236-1-git-send-email-simon.guinot@sequanux.org>
 <20150721.003033.1524284435822402813.davem@davemloft.net>
 <CAA-51jPPDHfE1uT2NuJ53wWTvEgh7DcW0K0-xZgQdjAD2CC04w@mail.gmail.com>
Message-ID: <20150914221320.GA7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oren,

On Mon, Sep 14, 2015 at 01:22:12PM -0700, Oren Laskin wrote:
> I had to undo this change on my Amada 370 based board.  It was causing
> corrupt data to make it through on large downloads.  I'm using wget to get
> the same 30MB file many times and the SHA would occasionally be different.

During your tests, can you see some "Linux processing - Can't refill"
messages along with the data corruptions ?

> I tracked it down to this commit.  In it, I would find on the order of a
> few hundred bytes to simply be wrong data.

I am little bit surprised here. For me, this patch is very simple and
does the exact opposite. It does fix kernel crashes and data corruptions
in case of refilling errors. This can happen for example if you run
large data transfers with jumbo frames enabled...

But anyway, I'll try to reproduce the issue tomorrow. I only have to
wget the same file (size 30MB) in a loop and to check its md5sum ?
That's it ? And how long should I wait for the error ?

Thanks,

Simon

> 
> Thanks,
> 
> Oren
> 
> On Tue, Jul 21, 2015 at 12:30 AM, David Miller <davem@davemloft.net> wrote:
> 
> > From: Simon Guinot <simon.guinot@sequanux.org>
> > Date: Sun, 19 Jul 2015 13:00:53 +0200
> >
> > > With the actual code, if a memory allocation error happens while
> > > refilling a Rx descriptor, then the original Rx buffer is both passed
> > > to the networking stack (in a SKB) and let in the Rx ring. This leads
> > > to various kernel oops and crashes.
> > >
> > > As a fix, this patch moves Rx descriptor refilling ahead of building
> > > SKB with the associated Rx buffer. In case of a memory allocation
> > > failure, data is dropped and the original DMA buffer is put back into
> > > the Rx ring.
> > >
> > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
> > network unit")
> > > Cc: <stable@vger.kernel.org> # v3.8+
> > > Tested-by: Yoann Sculo <yoann@sculo.fr>
> >
> > Applied, thanks.
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/ba87a8f1/attachment.sig>
