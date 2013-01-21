From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 16:29:41 +0000
Subject: Compilation problem with drivers/staging/zsmalloc when !SMP on ARM
In-Reply-To: <CAKGA1b=whdh9=ke0efUXnJdT-op=7G1uVh82=3OxT5GoHhWvdA@mail.gmail.com>
References: <CAKGA1b=ACTQHo9=B7EAG5nrFCO9u-J+sy7dXtYk3Rk6OUcW3cQ@mail.gmail.com>
 <20130118210859.GH23505@n2100.arm.linux.org.uk>
 <CAKGA1bmJ6c4LC=NAD4MU_rBZ2hZjf6qH=C+dqMCf0eP+2vSFdA@mail.gmail.com>
 <20130119044602.GC5391@phenom.dumpdata.com>
 <CAKGA1b=whdh9=ke0efUXnJdT-op=7G1uVh82=3OxT5GoHhWvdA@mail.gmail.com>
Message-ID: <20130121162941.GT23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 10:20:38AM -0600, Matt Sealey wrote:
> See previous mail to Minchan; local_tlb_flush_kernel_range calls
> cpu_tlb.flush_kernel_range on SMP, but a direct function call
> ("glue(_TLB, flush_kernel_range)" which resolves to
> v7wbi_flush_kernel_range etc. etc.) without CONFIG_SMP.

Actually, that's wrong - it's got nothing to do with SMP vs non-SMP.

It's more to do with which CPUs are being supported.  If they all use one
single cache maintanence implementation, then direct calls are used as an
optimization.  If they require more than one cache maintanence
implementation, they are indirect calls.  SMP really doesn't come into
that decision.

So:

> >> diff --git a/drivers/staging/zsmalloc/zsmalloc-main.c
> >> b/drivers/staging/zsmalloc/zsmalloc-main.c
> >> index 09a9d35..ecf75fb 100644
> >         > --- a/drivers/staging/zsmalloc/zsmalloc-main.c
> >> +++ b/drivers/staging/zsmalloc/zsmalloc-main.c
> >> @@ -228,7 +228,7 @@ struct zs_pool {
> >>   * mapping rather than copying
> >>   * for object mapping.
> >>  */
> >> -#if defined(CONFIG_ARM)
> >> +#if defined(CONFIG_ARM) && defined(CONFIG_SMP)

Would be wrong.
