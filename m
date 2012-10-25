From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 18:51:02 +0000 (UTC)
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
In-Reply-To: <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
Message-ID: <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Terve,

On Thu, 25 Oct 2012, Aaro Koskinen wrote:

> On Mon, Oct 15, 2012 at 07:32:33PM -0600, Paul Walmsley wrote:
> > The OMAP watchdog timer driver directly calls a function exported by
> > code in arch/arm/mach-omap2.  This is not good; it tightly couples
> > this driver to the mach-omap2 integration code.  Instead, add a
> > temporary platform_data function pointer to abstract this function
> > call.  A subsequent patch will convert the watchdog driver to use this
> > function pointer.
> 
> Why a function is needed? Reset cause won't change until the next reset,
> so it should be enough to read it once during the init and store it into
> the platform data.

Once the PRM/CM drivers and DT conversion is complete, this driver won't 
have any platform_data.  There won't be any watchdog driver initialization 
code in arch/arm/mach-omap2.  At that point in time, the driver will just 
call a function from the PRM driver that provides the reset source data.  

As you say, the watchdog can certainly do this from its probe code; it 
would be more efficient.  Just didn't want to make that change now; seems 
like it would be best done as a separate optimization patch.


- Paul
