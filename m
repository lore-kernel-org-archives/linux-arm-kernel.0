From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Sep 2012 14:35:07 +0300
Subject: [PATCH] serial: omap: fix the overrun case
In-Reply-To: <505C4CA4.6020507@ti.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi> <505C4CA4.6020507@ti.com>
Message-ID: <20120921113506.GF16003@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:46:52PM +0530, Shubhrajyoti wrote:
> On Friday 21 September 2012 04:30 PM, Felipe Balbi wrote:
> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
> >> Overrun also causes an internal flag to be set, which disables further
> >> reception. Before the next frame can
> >> be received, the MPU must:
> >> ? Reset the RX FIFO.
> >> ? clear the internal flag.
> >>
> >> In the uart mode a dummy read is needed. Add the same.
> > Very nice patch but I think commit log can be a bit more verbose.
> ok
> > Please make the problem a little clearer. Why do we even get that
> > interrupt fired if BRK_ERROR_BITS aren't set ?
> I did not get this point.
> 
> it it is !  BRK_ERROR_BITS I return.

That's what I mean. rlsi handler is basically taking care of those
bits... So how come we get RLSI IRQ when those bits aren't set ?

Meaning, you shouldn't ever need that check, right ? Ideally, whenever
that handler is called, it's because BRK_ERROR_BITS are set.

Maybe add a WARN_ONCE() kinda thing just to see if that will ever really
happen ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120921/2690f140/attachment.sig>
