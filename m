From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Sep 2012 15:07:53 +0300
Subject: [PATCH] serial: omap: fix the overrun case
In-Reply-To: <CAKdam55VG8KTRZNvPgur9M-wkbD7wyJt27Jsvks=r4PNiuEGaQ@mail.gmail.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi>
 <CAKdam55VG8KTRZNvPgur9M-wkbD7wyJt27Jsvks=r4PNiuEGaQ@mail.gmail.com>
Message-ID: <20120921120752.GG16003@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 05:09:56PM +0530, Poddar, Sourav wrote:
> Hi Felipe,
> 
> On Fri, Sep 21, 2012 at 4:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
> >> Overrun also causes an internal flag to be set, which disables further
> >> reception. Before the next frame can
> >> be received, the MPU must:
> >> ? Reset the RX FIFO.
> >> ? clear the internal flag.
> >>
> >> In the uart mode a dummy read is needed. Add the same.
> >
> > Very nice patch but I think commit log can be a bit more verbose.
> >
> > Please make the problem a little clearer. Why do we even get that
> > interrupt fired if BRK_ERROR_BITS aren't set ?
> >
> According to LSR registers, there are few other bits like RX_FIFO_E( atleast 1
> character in RX_FIFO or TX FIFO Empty), which might be the cause of an
> interrupt. ?

right. In that case, is it really correct to just return if
BRK_ERROR_BITS aren't set ? IRQ line will not toggle and we just might
end up with an IRQ storm, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120921/902c7fce/attachment.sig>
