From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 21:35:00 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
In-Reply-To: <1392578464.996901773@f49.i.mail.ru>
References: <1392573811.28866.22.camel@x220>
 <1392577615.265469392@f161.i.mail.ru> <1392577965.28866.37.camel@x220>
 <1392578464.996901773@f49.i.mail.ru>
Message-ID: <1392582900.28866.85.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-02-16 at 23:21 +0400, Alexander Shiyan wrote:
> ???????????, 16 ??????? 2014, 20:12 +01:00 ?? Paul Bolle <pebolle@tiscali.nl>:
> > On Sun, 2014-02-16 at 23:06 +0400, Alexander Shiyan wrote:
> > > Kconfig selects MACH_MXLADS, this enables machine_arch_type
> > > from include/generated/mach-types.h which used for machine_is_xx() macro,
> > > so if multiple boards is defined in the kernel, this cause to incorrect
> > matching.
> > 
> > But, as I stated in the commit explanation, there are no users of
> > machine_is_mxlads().
> 
> If you have MXLADS and FOO boards support in the kernel (for example)
> and you want to start MXLADS version, your machine_is_FOO() will be positive,
> since machine_arch_type will be constant value FOO in this case.

I think it might be helpful - for people trying to understand this
thread - to add a quote from https://lkml.org/lkml/2013/3/8/473 :
    So, the result is that:
    - de-selected platforms have their if (machine_is_xxx()) { } optimised
      out of the kernel.
    - for a kernel built targetting one platform, all the
      if (machine_is_xxx()) tests are optimised away, leaving only the
      relevant code behind.
    - otherwise, we get the _appropriate_ conditional code for the
      configuration generated.

Back to the issue at hand: without my patch ARCH_MX1ADS selects
MACH_MXLADS. So it seems in this case people will have to select
ARCH_MX1ADS besides selecting FOO. Wouldn't that solve this problem?
Note that the MACH_MXLADS is now basically meant to be selected by
ARCH_MX1ADS and not set directly anyway.


Paul Bolle
