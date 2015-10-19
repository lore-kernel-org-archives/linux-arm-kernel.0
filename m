From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Oct 2015 09:23:20 +0200
Subject: [PATCH] pinctrl: mvebu: armada-38x: add suspend/resume support
In-Reply-To: <CAPv3WKdKea-85_0xUv218OVfhnfMvisYXh8qRNRjvmNkweSUJg@mail.gmail.com>
References: <1445117328-31678-1-git-send-email-mw@semihalf.com>
 <20151017222927.GR32532@n2100.arm.linux.org.uk>
 <CAPv3WKed+Q3K0ky9b9AAYSymB-tE0O=57UdrgM+7Cx-X9PeVcA@mail.gmail.com>
 <20151018160123.6694b4be@free-electrons.com>
 <CAPv3WKdKea-85_0xUv218OVfhnfMvisYXh8qRNRjvmNkweSUJg@mail.gmail.com>
Message-ID: <20151019092320.33d48dba@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 19 Oct 2015 08:04:49 +0200, Marcin Wojtas wrote:

> > I don't like this. The mvebu_pinctrl_soc_info structure is meant to be
> > a read-only structure that only describes static information giving
> > SoC-specific details for pin-muxing. The idea is that in the event
> > where you had multiple pinctrl in the same system, you would still have
> > only one instance of mvebu_pinctrl_soc_info.
> 
> Ok, understood. What with current static globals, like mpp_base? This
> is a problem when we consider hypothetical multi-pintrl system...

The current driver is indeed not designed for multiple instances of the
same pinctrl controller. But that's exactly what Russell is asking for.

> In genereal, I think storing additional global data is not
> starightforward, as dev->platform_data and dev->driver_data are
> currently occupied by mvebu_pinctrl and mvebu_pinctrl_soc_info. I
> propose the following:
>
> 
> 1. Create a new structure:
> struct mvebu_pinctrl_pm_info {

This definitely shouldn't be called "pm_info", because 'base' is not PM
related. It should be mvebu_pinctrl_state or something like that.

>     void __iomem *base;
>     static u32 *mpp_saved_regs;
>     int nregs;
> }
> 
> 2. Add new field to struct mvebu_pinctrl:
> struct mvebu_pinctrl_pm_info *pm_info;

Does not work because "mvebu_pinctrl_pm_info" cannot be a generic
structure, it has to be a per-SoC driver structure, since the set of
registers to save for PM reasons is different from one SoC to the
other. Also, some SoC have only one "base" pointer, some others (like
Dove) have multiple.

So it should be the other way around: the SoC-specific driver create a
structure, and this structure points back to the mvebu_pinctrl
structure.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
