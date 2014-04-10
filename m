From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 10 Apr 2014 22:56:00 +0100 (BST)
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410201201.GA12661@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com> <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Thu, 10 Apr 2014, Jason Gunthorpe wrote:

> Gating the clock without disabling the Phy first does sound like a
> bad idea..
>
> Neil, does this do anything for you?
>
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index f3b325f..e0a032f 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -107,7 +107,7 @@ static int __init mvebu_soc_id_init(void)
>        iounmap(pci_base);
>
> res_ioremap:
> -       clk_disable_unprepare(clk);
> +//     clk_disable_unprepare(clk);
>
> clk_err:
>        of_node_put(child);
>

That patch has fixed it for me. The PCIe card seems to be now be always 
properly detected.

> In any event, turning on the clock should almost certainly be
> accompanied by a phy reset sequence to get both link ends on the same
> page.
>
> Attached is a rough, untested patch along those lines.
>

I took your attached patch and extended it a bit to print out how long it 
took. The delays also need to be much longer for me. I also fixed a small 
typo you made where the bit wasn't being set again to bring the link back 
up. I've attached the diff to your patch, as well as the combined patch 
(hope that makes sense).

With the attached patch I get the following output:

mirabox ~ # dmesg | grep PCIe0.0
[    0.135947] mvebu-pcie pcie-controller.3: PCIe0.0: performing link 
reset
[    0.161989] mvebu-pcie pcie-controller.3: PCIe0.0: link went down after 
26 tries
[    0.173984] mvebu-pcie pcie-controller.3: PCIe0.0: link came back up 
after 12 tries
mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network 
Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network 
Connection (rev 01)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 
02)

So that seems to also work. I will leave it to you and Thomas to decide 
which approach is better!

Cheers,
Neil
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pex-combined.diff
Type: text/x-diff
Size: 2236 bytes
Desc: Combined patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/c4f61db5/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pex-diff-to-jasons-patch.diff
Type: text/x-diff
Size: 1179 bytes
Desc: Diff to Jason's patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/c4f61db5/attachment-0001.bin>
