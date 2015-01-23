From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jan 2015 17:54:45 +0000
Subject: arm64 -- psci tell the compiler in which registers we are
 expecting arguments
In-Reply-To: <20150123175039.GC13772@arm.com>
References: <1422034314-27084-1-git-send-email-apw@canonical.com>
 <20150123175039.GC13772@arm.com>
Message-ID: <20150123175445.GF26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:50:39PM +0000, Will Deacon wrote:
> On Fri, Jan 23, 2015 at 05:31:54PM +0000, Andy Whitcroft wrote:
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index f1dbca7..425cf78 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -113,9 +113,14 @@ static void psci_power_state_unpack(u32 power_state,
> >   * The following two functions are invoked via the invoke_psci_fn pointer
> >   * and will not be inlined, allowing us to piggyback on the AAPCS.
> >   */
> > -static noinline int __invoke_psci_fn_hvc(u64 function_id, u64 arg0, u64 arg1,
> > -					 u64 arg2)
> > +static noinline int __invoke_psci_fn_hvc(u64 _function_id, u64 _arg0,
> > +					 u64 _arg1, u64 _arg2)
> >  {
> > +	register u64 function_id asm("x0") = _function_id;
> > +	register u64 arg0 asm("x1") = _arg0;
> > +	register u64 arg1 asm("x2") = _arg1;
> > +	register u64 arg2 asm("x3") = _arg2;
> > +
> 
> Given that we've already been bitten by the compiler, I think we should
> just bite the bullet and implement these two functions in assembly in a
> separate file rather than rely on register variables doing what we want.

The alternative is a naked function.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
