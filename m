From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Jan 2013 09:44:16 -0500 (EST)
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <20130109111055.GG3931@n2100.arm.linux.org.uk>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Russell King - ARM Linux wrote:

> On Wed, Jan 09, 2013 at 10:44:14AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 09, 2013 at 10:35:22AM +0000, Arnd Bergmann wrote:
> > > On Wednesday 09 January 2013, Alexandre Courbot wrote:
> > > > On Tue, Jan 8, 2013 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
> > > > > introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
> > > > > should not check for that.
> > > > 
> > > > Sure - you sound like IS_ERR_OR_NULL() is generally considered evil,
> > > 
> > > Correct.
> > > 
> > > > may I ask why this is the case?
> > > 
> > > It's very hard to get right: either you are interested in the error code,
> > > and then you don't have one in some cases, or you don't care but have
> > > to check for it anyway. When you define a function, just make it clear
> > > what the expected return values are, either NULL for error or a negative
> > > ERR_PTR value, but not both.
> > 
> > Indeed, and any code which does this:
> > 
> > 	if (IS_ERR_OR_NULL(ptr))
> > 		return PTR_ERR(ptr);
> > 
> > is buggy because on NULL it returns 0, which is generally accepted as being
> > "success".
>

[ examples of broken code skipped ]

> These are just a few of the issues I've picked out at random from grepping
> the kernel source for IS_ERR_OR_NULL().  Yes, there's some valid use cases
> but the above are all horrid, buggy or down right wrong, and I wouldn't be
> at all surprised if that was all too common.

I do agree with Russell here.  Despite the original intentions behind 
IS_ERR_OR_NULL() which were certainly legitimate, the end result in 
practice is less reliable code with increased maintenance costs.  Unlike 
other convenience macros in the kernel, this one is giving a false sense 
of correctness with too many people falling in the trap of using it just 
because it is available.

I strongly think this macro should simply be removed from the source 
tree entirely and the code reverted to explicit tests against NULL when 
appropriate.


Nicolas
