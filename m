From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 14:26:33 +0200
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <CAHkRjk5MQUWiF3jmZJ_SBHdtmunoajR4eHftwdnFCKjeDxQDKA@mail.gmail.com>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<F01D8B85CFF58440B2A13965FBA90CA47375AC17BD@GEORGE.Emea.Arm.com>
	<CAHkRjk5MQUWiF3jmZJ_SBHdtmunoajR4eHftwdnFCKjeDxQDKA@mail.gmail.com>
Message-ID: <201110071426.34833.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Catalin Marinas wrote:
> > However, after changing both __io() and pcibios_min_io as Arnd suggested the boot still hangs after " Uncompressing Linux... done, booting the kernel."
> 
> I haven't followed the patch series in detail but the __io() is also
> used by __io_address() in the RealView code and the former is just
> expected to do some type casting. By doing some arithmetic on the
> pointer, the static mappings for various peripherals (GIC etc.) are
> wrong.
> 
> So if you convert __io() as per Arnd's suggestion, make sure that
> __io_address() is redefined, something like below:
> 
> #define __io_address(n)         __typesafe_io(IO_ADDRESS(n))

Ah, right. That definitely explains why it would not boot.
 
> Alternatively we could leave __io() as in the original kernel and
> define RealView specific in*/out* macros.

I wouldn't recommend that, since that would just have to be reverted
as we get closer to having a single zimage across platforms.
Your suggested fix above should be enough.

	Arnd
