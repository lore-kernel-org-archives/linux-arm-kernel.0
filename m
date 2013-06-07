From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Jun 2013 10:20:50 -0600
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <1880458.2ksb8qtzHh@wuerfel>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <20130408165626.GA30824@obsidianresearch.com>
 <000c01ce6360$237a7040$6a6f50c0$@samsung.com>
 <1880458.2ksb8qtzHh@wuerfel>
Message-ID: <20130607162050.GA31895@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 01:59:43PM +0200, Arnd Bergmann wrote:
> On Friday 07 June 2013 18:19:40 Jingoo Han wrote:
> > Hi Jason Gunthorpe,
> > 
> > I implemented 'Single domain' with Exynos PCIe for last two months;
> > however, it cannot work properly due to the hardware restriction.
> > Each MEM region is hard-wired.
> > 
> > Thus, I will send Exynos PCIe V3 patch as 'Separate domains'.
> 
> Yes, I think that is best, if the hardware is clearly designed as
> separate domains, this is what we should do by default in the
> driver. For the Marvell case with its 10 separate ports, much
> more address space would be wasted by having one domain per
> port and that hardware let us work around it by remapping the
> physical address space windows. For Exynos there is much less to
> lose and I too cannot see how it would be done in the first
> place.

Sounds fair to me.

But when we talk about multiple domains we don't mean a disjoint range
bus bus numbers, as your other email shows:

00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
10:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])

We mean multiple domains, it should look like this:

0000:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
0001:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])

ie lspci -D.

Each domain gets a unique bus number range, config space, io range,
etc. This is much clearer to everyone than trying to pretend there is
only one domain when the HW is actually multi-domain.

Jason
