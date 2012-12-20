From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Dec 2012 09:40:10 +0000
Subject: Inconsistency in clk framework
In-Reply-To: <1355976817.2968.12.camel@gitbox>
References: <1355890233.25599.4.camel@gitbox>
 <20121219092636.GW14363@n2100.arm.linux.org.uk>
 <1355938492.27893.8.camel@gitbox> <1355943649.2451.1.camel@gitbox>
 <20121219190824.GX14363@n2100.arm.linux.org.uk>
 <1355976817.2968.12.camel@gitbox>
Message-ID: <20121220094010.GY14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 05:13:37PM +1300, Tony Prisk wrote:
> On Wed, 2012-12-19 at 19:08 +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 20, 2012 at 08:00:49AM +1300, Tony Prisk wrote:
> > > On Thu, 2012-12-20 at 06:34 +1300, Tony Prisk wrote:
> > > > On Wed, 2012-12-19 at 09:26 +0000, Russell King - ARM Linux wrote:
> > > > > On Wed, Dec 19, 2012 at 05:10:33PM +1300, Tony Prisk wrote:
> > > > > > Hi Mike,
> > > > > > 
> > > > > > In attempting to remove some IS_ERR_OR_NULL references, it was pointed
> > > > > > out that clk_get() can return NULL if CONFIG_HAVE_CLK is not defined.
> > > > > 
> > > > > That is correct - but why is that a problem?  As far as users are
> > > > > concerned, NULL is a valid clock.  If HAVE_CLK is undefined, do you
> > > > > want all your drivers to suddenly stop working?
> > > > 
> > > > That will be where the misunderstanding has occurred - I didn't consider
> > > > NULL to be a valid clock.
> > > > 
> > > > Given that NULL is a valid clock, I guess all tests against get_clk and
> > > > of_get_clk results should be IS_ERR_OR_NULL. Correct?
> > > > 
> > > For the sake of clarity, I should rephrase:
> > > 
> > > If the driver can't operate with a NULL clk, it should use a
> > > IS_ERR_OR_NULL test to test for failure, rather than IS_ERR.
> > 
> > Why should a _consumer_ of a clock care?  It is _very_ important that
> > people get this idea - to a consumer, the struct clk is just an opaque
> > cookie.  The fact that it appears to be a pointer does _not_ mean that
> > the driver can do any kind of dereferencing on that pointer - it should
> > never do so.
> 
> As a simple example:
> We have a PWM module that requires a clock source to be enabled before
> registers can be read/written.
> 
> *pseudo code*
> x = clk_get("pwm_clock")
> if IS_ERR(x) then fail
> err = clk_enable(x)
> if (err != 0) then fail
> start writing to module registers
> 
> 
> Assuming HAVE_CLK is undefined:
> 
> x = clk_get("pwm_clock") (= NULL)
> if IS_ERR(x) then fail (not an error)
> err = clk_enable(x) (= 0)
> if (err) then fail (not an error)
> start writing to module registers
> (register writes lock the bus because the clock wasn't really enabled,
> but no errors occurred enabling the clock)

Which is really silly if you have a platform which requires clock control
and HAVE_CLK is not selected.  The clk API is not designed to cope with
that situation.
