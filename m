From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 8 Aug 2018 22:59:46 +0530
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
In-Reply-To: <20180807184710.GA26423@rob-hp-laptop>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
 <20180730151131.GA28633@mani>
 <20180807184710.GA26423@rob-hp-laptop>
Message-ID: <20180808172946.GA4188@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Aug 07, 2018 at 12:47:10PM -0600, Rob Herring wrote:
> On Mon, Jul 30, 2018 at 08:41:31PM +0530, Manivannan Sadhasivam wrote:
> > Hi Andreas,
> > 
> > On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas F?rber wrote:
> > > Hi Mani,
> > > 
> > > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > > support into common clock driver inorder to maintain compatibility.
> > > 
> > > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > > sub-node in DT?
> 
> That is exactly what I tell folks not to do. Design the DT based on h/w 
> blocks, not current desired driver split for some OS.
> 
> > Actually I was not sure where to place this reset controller driver. When I
> > looked into other similar ones such as sunxi, they just integrated into the
> > clk subsystem. So I just chose that path. But yeah, this is hacky!
> > 
> > But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> > are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> > RMU has only 2 registers, the HW designers decided to use up the CMU memory
> > map. So, maybe syscon would be best option I think. What is your opinion?
> 
> If there's nothing shared then it is not a syscon. If you can create 
> separate address ranges, then 2 nodes is probably okay. If the registers 
> are all mixed up, then 1 node.
> 

I don't quite understand the reason for not being syscon. The definition
of syscon says that, "System controller node represents a register region
containing a set of miscellaneous registers. The registers are not cohesive
enough to represent as any specific type of device." which exactly fits
this case. Only the registers of CMU & RMU are shared and not the HW block!

Can you please clarify?

Thanks,
Mani

> Rob
