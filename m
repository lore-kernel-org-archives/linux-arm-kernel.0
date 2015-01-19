From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Jan 2015 15:46:40 +0000
Subject: [PATCH 4/5] PCI: designware: Add setup bus-related to
 pcie_host_ops
In-Reply-To: <6696411.b9yjvPTFJo@wuerfel>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <000e01d01a7f$47592e20$d60b8a60$%han@samsung.com>
 <CAG374jBZCn+V2zjcAwdKEb0COzBT2VES5uiw0gc40mFvoraERA@mail.gmail.com>
 <6696411.b9yjvPTFJo@wuerfel>
Message-ID: <20150119154640.GA3845@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 01:54:26PM +0000, Arnd Bergmann wrote:
> On Monday 19 January 2015 13:38:53 Gabriel Fernandez wrote:
> > 
> > On 18 December 2014 at 05:58, Jingoo Han <jg1.han@samsung.com> wrote:
> > 
> > > On Thursday, December 18, 2014 7:16 AM, Arnd Bergmann wrote:
> > > > On Wednesday 17 December 2014 11:34:45 Gabriel FERNANDEZ wrote:
> > > > > ST sti SoCs PCIe IPs are built around DesignWare IP Core.
> > > > > But in these SoCs PCIe IP doesn't support IO.
> > > I cannot understand how ST sti SoCs PCIe IP does not support I/O.
> > > As far as I know, it cannot be selected by the 'parameter'.
> > > Then, H/W engineers dropped out the I/O control logic?
> > >
> > > > >
> > > > > To support this, add setup_bus() to pcie_host_ops.
> > >
> > >
> > > > >
> > > > > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > > > > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> > > >
> > > > The dw-pcie driver should be able to tell whether the device has
> > > > an I/O space or not, and do the right thing based on that. Don't
> > > > add an implementation specific callback for that.
> > >
> > > I agree with Arnd's opinion.
> > >
> > > In addition, I have one more question.
> > > Then, if a device that requires I/O region is connected to
> > > PCIe slot of ST sti SoCs PCIe, what will happen?
> > > It just prints error messages?
> > >
> > >
> > Arnd i
> > n other post mention to add an empty I/O space to workaround lack of I/O
> > port access.
> > Is it the right thing to do ?
> > ?
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/299623.html
> > 
> 
> Good question. Given the latest development, I'd feel tempted to
> try moving the entire pcie-designware driver to use the generic probing
> that bypassses pci_common_init_dev(). Rob Herring posted a patch
> for the versatile PCI driver, you could try doing the same thing
> here, see http://permalink.gmane.org/gmane.linux.kernel.pci/30346.
> 
> I think that would completely avoid this problem, and also help everyone
> that wants to use this driver on arm64.

I was aiming at that, I started by converting the ranges parsing to the new
API, with its own unfortunate quirks (ie untranslated CPU addresses,
that apparently caused deafening silence on the lists :)):

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314008.html

Lorenzo
