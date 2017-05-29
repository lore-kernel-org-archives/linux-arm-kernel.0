From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 10:09:44 +0200
Subject: [PATCH 10/11] crypto: sun4i-ss: fix large block size support
In-Reply-To: <20170526145501.GA19284@Red>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
 <20170524190652.13278-11-antoine.tenart@free-electrons.com>
 <20170526145501.GA19284@Red>
Message-ID: <20170529080944.GA3169@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Fri, May 26, 2017 at 04:55:01PM +0200, Corentin Labbe wrote:
> On Wed, May 24, 2017 at 09:06:51PM +0200, Antoine Tenart wrote:
> >  
> > +	/*
> > +	 * The datasheet isn't very clear about when to retrieve the digest. The
> > +	 * bit SS_DATA_END is cleared when the engine has processed the data and
> > +	 * when the digest is computed *but* it doesn't mean the digest is
> > +	 * available in the diesgt registers. Hence the delay to be sure we can
> 
> Small typo here (diesgt/digest)

Oops. I'll fix it.

> This behaviour is very strange since I didnt get it on other platform.
> Could you give me the board name where you get it ?

I used a CHIP (sun5i-r8-chip).

> Does any wmb() after the writel(..SS_DATA_END..) do the trick ?

Nope. I tried this and it didn't help.

> Which speed are the SS clocks ?

The AHB SS clk is running at 300 MHz and the SS clk at 150 MHz. SS clk
is at the expected rate but the AHB SS clk has a higher rate that what's
expected.

In the probing function only the SS clk rate is explicitly set. I tried
to set the AHB clk rate as well and removed the delays. This didn't fix
the framework selftests at boot time. Is there any reason the AHB SS clk
rate isn't explicitly set when probing the driver? (Should it?)

> Anyway the whole serie seems good, I will test it just after this weekend.

Let me know if your tests went well, I'll send a v2 fixing the typo
below then (and setting the AHB SS clk rate explicitly if needed).

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/0cc8ea33/attachment.sig>
