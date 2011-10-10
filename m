From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 10 Oct 2011 09:38:47 -0700
Subject: [PATCH v7 3/3] arm/tegra: device tree support for ventana board
In-Reply-To: <20111010080109.GQ9003@tbergstrom-lnx.Nvidia.com>
References: <1317647918-22694-1-git-send-email-pdeschrijver@nvidia.com>
	<1317647918-22694-4-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173B23B2FA@HQMAIL01.nvidia.com>
	<20111010080109.GQ9003@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173B23B514@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, October 10, 2011 2:01 AM:
> On Fri, Oct 07, 2011 at 08:04:34PM +0200, Stephen Warren wrote:
> > Peter De Schrijver wrote at Monday, October 03, 2011 7:19 AM:
> > ...
> > > diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> > ...
> > > -	if (of_machine_is_compatible("nvidia,harmony"))
> > > -		harmony_pinmux_init();
> > > -	else if (of_machine_is_compatible("nvidia,seaboard"))
> > > -		seaboard_pinmux_init();
> > > +	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
> > > +		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
> > > +			pinmux_configs[i].init();
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (i == ARRAY_SIZE(pinmux_configs))
> > > +		printk(KERN_WARNING "Unknown platform! Pinmuxing not initialized\n");
> >
> > Should that be WARN() instead of printk?
> 
> pr_warning() might be better. Or do we want a backtrace and a tainted kernel
> in this case?

Well, tainting seems like a good idea. I'm less thrilled about the backtrace,
but perhaps it is a good idea to bring attention to this condition.

-- 
nvpublic
