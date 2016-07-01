From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Jul 2016 19:19:13 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add the power domain node for
 rk3399
In-Reply-To: <CAD=FV=U0FU5P+seYYmJNZmcV1r-N6_UHtMW5LuVGM-NyPER8BQ@mail.gmail.com>
References: <1467347575-11806-1-git-send-email-wxt@rock-chips.com>
 <CAD=FV=U0FU5P+seYYmJNZmcV1r-N6_UHtMW5LuVGM-NyPER8BQ@mail.gmail.com>
Message-ID: <2235386.KcC75gPTXr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 1. Juli 2016, 09:56:31 schrieb Doug Anderson:
> Caesar
> 
> On Thu, Jun 30, 2016 at 9:32 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> > From: Elaine Zhang <zhangqing@rock-chips.com>
> > 
> > In order to meet low power requirements, a power management unit (PMU)
> > is
> > designed for controlling power resources in RK3399. The RK3399 PMU is
> > dedicated for managing the power of the whole chip.
> > 
> > 1. add pd node for RK3399 Soc
> > 2. create power domain tree
> > 3. add qos node for domain
> > 
> > From the DT/binds and driver can get more detail information:
> > 
> > The driver:
> >         drivers/soc/rockchip/pm_domains.c
> > 
> > The document:
> >         Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> > 
> > ---
> > 
> > Changes in v2:
> > - As Doug/Heiko commnets on https://patchwork.kernel.org/patch/9206415/.
> > 
> >   drop the debugfs-dump and Add the comments for alphabetical order.
> > 
> > Note: As the TRM lists many voltage domains and power domains, then
> > in actual we just need control some domains for driver.
> > Due to some domains (e.g. emmc, usb, core)...We can't turn off it on
> > bootup.
> 
> I'm curious: why can't you turn off USB power domains if a board
> doesn't usb USB?  ...or GMAC on boards that don't use Ethernet?  ...or
> eDP on boards that don't use EDP?
> 
> Maybe the driver for these things isn't ready to handle power domains
> yet so that's why they are left out for now?

I think core power-domain handling is actually transparent to drivers (aka 
turning on before probe and turning off after remove), see 
drivers/base/platform.c:platform_drv_probe() calling dev_pm_domain_attach() 
with the poweron flag set.

And all the unused domains getting turned off automatically also shouldn't 
hurt us I'd think. Just that someone need to collect all clocks needed for 
the synchronuous reset.
