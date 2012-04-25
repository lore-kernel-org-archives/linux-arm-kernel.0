From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Apr 2012 07:28:02 +0200
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424201802.GE3628@n2100.arm.linux.org.uk>
 <CAOh2x==Se4ipK_jexOE_=82=S4p41W9Ek0Om6DrUwctSz-Wcyw@mail.gmail.com>
Message-ID: <20120425052802.GF13489@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This is what i was thinking too and thats why floated this version of patch.
> But as Andrew said, clk API support is enabled for them, but still they
> don't have a clk for sata. To get this working, there are two solutions:
> - Create dummy clk for sata for that platform, so clk_get doesn't fail.
> - Check for error before every call to clk APIs after clk_get().
> 
> Andrew favored the second one. Which means, even on platforms
> with clk API defined and clk enable required, if there are some issues
> with lookup table, and clk_get() fails, system may hang when registers
> are accessed. For this i favored first one.

I'm not too sure how you are going to achieve 1)

config SATA_MV
        tristate "Marvell SATA support"
        help
          This option enables support for the Marvell Serial ATA family.
          Currently supports 88SX[56]0[48][01] PCI(-X) chips,
          as well as the newer [67]042 PCI-X/PCIe and SOC devices.

So this driver can be used with anything which has a PCI(-X) or PCIe
bus, or Orion SoC and a few PowerPC SoCs.

The SoCs are not too bad, we know which ones they are and we can add
dummy entries to their device tree. However, how do you want to handle
the PCI devices? Create the dummy entry somewhere in the middle of the
PCI core?

Thought not.

A comment to:
> - Check for error before every call to clk APIs after clk_get().

There are only two calls. clk_prepare_enable() in the probe and
clk_disable_unprepare() in the remove function.

	Andrew
