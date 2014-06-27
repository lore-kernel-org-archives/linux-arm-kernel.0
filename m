From: Hong-Xing.Zhu@freescale.com (Hong-Xing.Zhu at freescale.com)
Date: Fri, 27 Jun 2014 10:06:47 +0000
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <20140626031247.GN2224@dragon>
 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
 <20140626054937.GB7859@dragon>
 <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
Message-ID: <6c999c0fee0b406db597e74837980081@BLUPR03MB136.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


> -----Original Message-----
> From: Tim Harvey [mailto:tharvey at gateworks.com]
> Sent: Friday, June 27, 2014 8:29 AM
> To: Guo Shawn-R65073; Zhu Richard-R65037
> Cc: Fabio Estevam; Bjorn Helgaas; Marek Va?ut; David M?ller (ELSOFT AG);
> Sascha Hauer; linux-arm-kernel at lists.infradead.org; linux-pci at vger.kernel.org;
> Estevam Fabio-R49496
> Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
> 
> On Wed, Jun 25, 2014 at 10:49 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Thu, Jun 26, 2014 at 12:43:19AM -0300, Fabio Estevam wrote:
> >> On Thu, Jun 26, 2014 at 12:12 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> >> > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> >> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >> >>
> >> >> When the mx6 PCI conctroller is initialized in the bootloader we
> >> >> see a kernel hang inside imx6_add_pcie_port().
> >> >>
> >> >> Adding a 30ms delay allows the kernel to boot.
> >> >
> >> > We may not want to add a random delay into the driver before we
> >> > understand the root cause of the issue.
> >>
> >> Yes, that's why I sent this as RFC and also explained it below the
> >> --- line that I am actually trying to get some help with this issue.
> >>
> >> >
> >> > Do you see this issue with FSL kernel?
> >>
> >> Yes, it also hangs.
> >>
> >> It is reproducible in 100% of the boots. Just need to use mainline
> >> U-boot (which has PCI driver enabled by default).
> >> I am using an Intel Wifi 7260 PCI card. This was also reported by
> >> other folks in the U-boot list.
> >
> > Richard,
> >
> > Can you schedule some time to look at this issue?  I think it will
> > come to us sooner or later if any our customer enables PCIe before
> > launching kernel?
> >
> > Shawn
> >
> 
[Richard] I did the tests refer to this use-case, enable imx6 pcie on both u-boot and kernel,
and I encounter the system hang too.

Here are the latest updates and some clues from my side:
- About 200us delay is required after the ltssm_en is set to be '1' at my side.
Otherwise, system would be hang when driver access the pcie_phy_debug_r1 to check
the link is up or not.

- After that, system hang when rc trying to access the cfg space of ep device,
Although the pcie link had been setup and I don't have know the root cause yet.

- The kernel can boot up successfully, when I mask the cfg read/write call-back in pcie-designware.c
Driver for debug purpose.

Note:
The sequence of the pcie initialization should be adjusted refer to the newly
 discovered bug(pcie link maybe rarely random down after the system warm-reset).
* Ref_ssp_en(bit16 of gpr1 register) should be set after the pcie others clks are enable.
Enable pcie related clks --> delay for about ~10us waiting for the clks stable-->set ref_ssp_en(bit16 of gpr1 register).

Debug is still on-going.

> Shawn / Richard,
> 
> I am also affected by this issue on IMX6 boards that I support. If I enable
> PCI in the bootloader I see similar hangs.
> 
> I have the following hardware configurations on my bench:
>   1. IMX6DL + i210 (same PCI setup as Fabio's above, but DL instead of Q)
>   2. IMX6Q + ath9k device
>   3. IMX6DL + PLX PEX860x PCIe-to-PCIe bridge with various devices behind the
> bridge, using a clock buffer from IMX6 PCIe clock
>   4. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices behind the
> bridge, using a clock buffer from IMX6 PCIe clock
>   5. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices behind the
> bridge using a clock generator (always on, ignoring the PCIe clock)
> 
> For all of the above I have no PCI issues using 3.14/3.15/3.16-rc2/vendor
> 3.10.17_1.0.0_ga unless I enable PCI in the bootloader. When I do so, all of
> the above configurations hang somewhere around PCI init/enumeration. The same
> occurs with the most recent vendor kernel 3.10.17_1.0.0_ga kernel (works when
> PCI is disabled in the bootloader, hangs otherwise).
> 
> When I apply Fabio's patch above to the 3.16-rc2 kernel I find that scenarios
> #4 and #5 above then work, #3 boots but the PLX bridge fails all config cycles
> (0xff's), #2 boots but with no PCIe link, and #1 above still hangs. Previously,
> when I have dug into this particular 'hang' issue on 3.15 I found that the
> delay needed to be between
> imx6_pcie_probe() requesting and asserting reset_gpio low, and before setting
> IOMUX_GPR1:18 to power down the PCIe PHY (note here, that the PHY is currently
> enabled in the bootloader when PCI is enabled there).
> 
> When I apply Fabio's patch above to the most recent vendor kernel
> 3.10.17_1.0.0_ga I still hang in all cases.
> 
> So while I agree there is something horribly wrong with IMX6 PCI still, I
> don't think Fabio's patch is the right solution and I don't have anything
> better at this point in time. I'm happy to share any hardware with anyone that
> can work through this issue.
> 
> Thanks,
> 
> Tim

Best Regards
Richard Zhu
