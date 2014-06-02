From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 2 Jun 2014 11:27:13 +0300
Subject: [PATCH v5 0/5] efuse driver for Tegra
In-Reply-To: <5388AF2D.4060909@wwwdotorg.org>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <53878407.3050409@wwwdotorg.org>
 <20140530082356.GP5961@tbergstrom-lnx.Nvidia.com>
 <5388AF2D.4060909@wwwdotorg.org>
Message-ID: <20140602082713.GZ5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 06:17:49PM +0200, Stephen Warren wrote:
> On 05/30/2014 02:23 AM, Peter De Schrijver wrote:
> > On Thu, May 29, 2014 at 09:01:27PM +0200, Stephen Warren wrote:
> >> On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> >>> This driver allows userspace to read the raw efuse data. Its userspace
> >>> interface is modelled after the sunxi_sid driver which provides similar
> >>> functionality for some Allwinner SoCs. It has been tested on
> >>> Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
> >>> Tegra124 (jetson TK1).
> >>
> >>> Changes since v4:
> >>>
> >>> * Provide fallback to hardcoded 0x70000800 in case the apbmisc DT node is
> >>>   missing. This is exactly what the current code does and prevents a system
> >>>   crash in that case due to an invalid memory access by tegra_read_chipid()
> >>
> >> Wouldn't it be better to simply return an error?
> > 
> > This would mean you can't boot a system with these patches applied unless you
> > also update the device tree. The system would crash during boot because CCF
> > relies on tegra_read_chipid() as an APB barrier. Also tegra_boot_secondary()
> > relies on the chipid to select the correct method for booting secondary cores.
> 
> Is this series really backwards-compatible anyway? tegra_init_fuse()
> contains a whole bunch of places where resources are pulled out of DT,
> and only one of those has a fallback to use APBMISC_BASE if the DT entry
> isn't present.

Apart from the randomness initialization, there are no users of
tegra_read_straps(). tegra_fuse_readl() is a new API, so that doesn't pose
any backwards-compatibility problems. The only bug I noticed when rereading
the code is that tegra_get_revision() reads the fuses on an A03 Tegra20 to
findout if it's A03 or A03p. This would obviously crash if the DT entries
are missing. I think this can be worked around by claiming it's an A03
in case the DT entries are missing. I don't think that will cause any problems?

Cheers,

Peter.
