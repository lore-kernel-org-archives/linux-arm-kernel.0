From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 30 Mar 2017 15:04:51 +0800
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170330065836.GD19596@b29396-OptiPlex-7040>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
 <20170324062451.GB12604@b29396-OptiPlex-7040>
 <CAHQ1cqEvE=P6Vrwmm-DEL6sD+ppy3XSeih2_1VynESr9ZmtSOw@mail.gmail.com>
 <20170330065836.GD19596@b29396-OptiPlex-7040>
Message-ID: <20170330070451.GA29432@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 02:58:36PM +0800, Dong Aisheng wrote:
> On Mon, Mar 27, 2017 at 11:42:15AM -0700, Andrey Smirnov wrote:
> > On Thu, Mar 23, 2017 at 11:24 PM, Dong Aisheng <dongas86@gmail.com> wrote:
> > > On Tue, Mar 21, 2017 at 07:50:04AM -0700, Andrey Smirnov wrote:
> > >> Add code allowing for control of various power domains managed by GPCv2
> > >> IP block found in i.MX7 series of SoCs. Power domains covered by this
> > >> patch are:
> > >>
> > >>     - PCIE PHY
> > >>     - MIPI PHY
> > >>     - USB HSIC PHY
> > >>     - USB OTG1/2 PHY
> > >>
> > >
> > > You probably may need drop USB OTG which is not claimed in current RM.
> > > See the PGC definition in 5.5.10 GPC Memory Map section.
> > >
> > > Each PGC (CPU type, MIX type, PU type) will occupy 64 Bytes address space,
> > > the specific base address of each PGC are listed as below.
> > > ? 0x800 ~ 0x83F : PGC for A7 core0
> > > ? 0x840 ~ 0x87F: PGC for A7 core1
> > > ? 0x880 ~ 0x8BF: PGC for A7 SCU
> > > ? 0xA00 ~ 0xA3F: PGC for fastmix/megamix
> > > ? 0xC00 ~ 0xC3F: PGC for MIPI PHY
> > > ? 0xC40 ~ 0xC7F: PGC for PCIE_PHY
> > > ? 0xC80 ~ 0xCBF: Reserved
> > > ? 0xCC0 ~ 0xCFF: Reserved
> > > ? 0xD00 ~ 0xD3F: PGC for USB HSIC PHY
> > >
> > > And in 5.4 Power Management Unit (PMU) chapter,
> > > you will find the USB OTG phy power is directly supplied by
> > > VDD_USB_OTG1_3P3_IN/VDD_USB_OTG2_3P3_IN.
> > >
> > > http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX7DRM.pdf
> > >
> > > I understand that there's also some USB OTG code exist in NXP internal
> > > tree, but that's legacy for early doc implementation and may be deprecated.
> > > so i assume it should be gone.
> > >
> > > Hopefully i will double confirm with our IC designer tomorrow.
> > >
> > 
> > USB OTG domains are absent from that list, true, but they are
> > mentioned all of the place further in that section in register map
> > documentation, which makes it difficult to tell which part of the
> > datasheet is not up to date.
> > 
> > I'm going to drop those power domains for now, since I don't have a
> > use-case for them and it would also allow me to get rid of the chunk
> > of code you thought was messy. However it would be nice to get an
> > updated version of RM where all of that is straightened out.
> > 
> 
> I checked with our IC designer and he confirmed the USB OTG is removed
> and not supported in GPC. SW should not control it, instead, its power
> domain is handled by hardware automatically.
> 
> Currently there's true some incorrectness in GPC chapter, i already
> reported the issue to the designer, but still no timeline when i
> can get a updated version.
> 
> But i think it's fine if you're going to only support PCIE/MIPI/USB HSIC
> PHY power domain. I suppose those bits are correct in RM.
> 

BTW, would you please CC my company email next time?
aisheng.dong at nxp.com

Then i can see them in time to help the review.

Regards
Dong Aisheng
