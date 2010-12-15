From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 16:07:00 +0000
Subject: [PATCH 1/5] msm: Secure Channel Manager (SCM) support
In-Reply-To: <20101215140558.GA9736@huya.qualcomm.com>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
	<20101215074811.GA2483@ucw.cz>
	<20101215140558.GA9736@huya.qualcomm.com>
Message-ID: <20101215160700.GB9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 06:05:58AM -0800, David Brown wrote:
> On Wed, Dec 15, 2010 at 08:48:11AM +0100, Pavel Machek wrote:
> 
> > > +static u32 smc(dma_addr_t cmd_addr)
> > > +{
> > > +	int context_id;
> > > +	register u32 r0 asm("r0") = 1;
> > > +	register u32 r1 asm("r1") = (u32)&context_id;
> > > +	register u32 r2 asm("r2") = (u32)cmd_addr;
> > 
> > Are these neccessary?
> 
> The values have to be in specific registers.  Without them it doesn't
> generate the right code.
...
> > > +	int context_id;
> > > +	static u32 version = -1;
> > > +	register u32 r0 asm("r0") = 0x1 << 8;
> > > +	register u32 r1 asm("r1") = (u32)&context_id;
> > 
> > And does this even work?
> 
> In what sense?  It generates the desired code.

What you're doing is entirely valid and supported by gcc.  There's no
problem with it.

> > > +	mutex_lock(&scm_lock);
> > > +	asm(
> > > +		__asmeq("%0", "r1")
> > > +		__asmeq("%1", "r0")
> > > +		__asmeq("%2", "r1")

And even if you use an older gcc version where this trips over bugs,
these asmeq() will save you from having silently generated wrong code.

So don't worry about this, you're not doing anything wrong.
