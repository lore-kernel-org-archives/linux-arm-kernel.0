From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2016 09:58:54 +0100
Subject: [PATCH 2/2] ARM: sa1100: register clocks early
In-Reply-To: <CALT56yPLMiQZaeSxmo3xz_+6c11BO-hWSEN2ex-ziJGZdZDY6w@mail.gmail.com>
References: <E1baiKh-0004yg-OF@rmk-PC.armlinux.org.uk>
 <CALT56yPLMiQZaeSxmo3xz_+6c11BO-hWSEN2ex-ziJGZdZDY6w@mail.gmail.com>
Message-ID: <20160823085854.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 04:47:08AM +0300, Dmitry Eremin-Solenikov wrote:
> 2016-08-19 14:51 GMT+03:00 Russell King <rmk+kernel@armlinux.org.uk>:
> > Since we switched to use pxa_timer, we need to provide the OSTIMER0
> > clock.  However, as the clock is initialised early, we need to provide
> > the clock early as well, so that pxa_timer can find it.  Adding the
> > clock to the clkdev table at core_initcall() time is way too late.
> 
> This worked for me before, so maybe the init order of other kernel parts
> has changed. Anyway:
> 
> Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

It worked in so far as we fell back to the non-clock based code, so
things continued to work.  However, a warning was printed at each
boot.

I don't think this ever worked.  Timers are setup very early in the
boot process (going back to 0.99.x times), and core_initcall() has
always been after that, after pid1 has been created.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
