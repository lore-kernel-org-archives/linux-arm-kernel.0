From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Aug 2018 12:21:25 -0600
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
In-Reply-To: <20180808172946.GA4188@Mani-XPS-13-9360>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de> <20180730151131.GA28633@mani>
 <20180807184710.GA26423@rob-hp-laptop>
 <20180808172946.GA4188@Mani-XPS-13-9360>
Message-ID: <CAL_JsqL7rFt8OKQoyD4JuZ+i9Fqc6RLsTxN4cJmur28ptwyNWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 11:30 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi Rob,
>
> On Tue, Aug 07, 2018 at 12:47:10PM -0600, Rob Herring wrote:
> > On Mon, Jul 30, 2018 at 08:41:31PM +0530, Manivannan Sadhasivam wrote:
> > > Hi Andreas,
> > >
> > > On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas F?rber wrote:
> > > > Hi Mani,
> > > >
> > > > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > > > support into common clock driver inorder to maintain compatibility.
> > > >
> > > > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > > > sub-node in DT?
> >
> > That is exactly what I tell folks not to do. Design the DT based on h/w
> > blocks, not current desired driver split for some OS.
> >
> > > Actually I was not sure where to place this reset controller driver. When I
> > > looked into other similar ones such as sunxi, they just integrated into the
> > > clk subsystem. So I just chose that path. But yeah, this is hacky!
> > >
> > > But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> > > are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> > > RMU has only 2 registers, the HW designers decided to use up the CMU memory
> > > map. So, maybe syscon would be best option I think. What is your opinion?
> >
> > If there's nothing shared then it is not a syscon. If you can create
> > separate address ranges, then 2 nodes is probably okay. If the registers
> > are all mixed up, then 1 node.
> >
>
> I don't quite understand the reason for not being syscon. The definition
> of syscon says that, "System controller node represents a register region
> containing a set of miscellaneous registers. The registers are not cohesive
> enough to represent as any specific type of device." which exactly fits
> this case. Only the registers of CMU & RMU are shared and not the HW block!
>
> Can you please clarify?

IIRC, the original intent of 'syscon' was really for things that had
no subsystem. Random bits all just dumped together. A block with clock
and reset doesn't sounds pretty well defined functions. Plus that
criteria doesn't work well because what does and doesn't have a
subsystem (and DT binding) evolves. IMO, we should probably get rid of
'syscon'.

Let me turn it around. Why do you want it do be a syscon? Simply to
create a regmap I suppose because that is all that 'syscon' compatible
is. A flag to create a regmap. Why do you need a regmap then? Do you
need to protect concurrent accesses (a single register has both clock
and reset bits). If so, you can't really call CMU and RMU 2 blocks. If
not, you don't really need regmap.

Rob
