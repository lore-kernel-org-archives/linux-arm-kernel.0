From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 15:01:39 +0100
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <20140115134653.GF25824@e106331-lin.cambridge.arm.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com>
 <20140115121750.GE25824@e106331-lin.cambridge.arm.com>
 <20140115124041.GD9558@ns203013.ovh.net>
 <20140115134653.GF25824@e106331-lin.cambridge.arm.com>
Message-ID: <20140115140139.GG9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:46 Wed 15 Jan     , Mark Rutland wrote:
> On Wed, Jan 15, 2014 at 12:40:41PM +0000, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:17 Wed 15 Jan     , Mark Rutland wrote:
> > > On Wed, Jan 15, 2014 at 11:47:25AM +0000, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > The new interrupts-extended property, which reuses the phandle+arguments
> > > > pattern used by GPIOs and other core bindings, still have some issue.
> > > > 
> > > > If an SoC have already specifiy interrupt and a board want to add specific
> > > > interrupt such as GPIO (which can be optionnal) be need to re-define
> > > > interrupts-extended. So allow to have an optionnale interrupts-extended-2
> > > > property.
> > > > 
> > > 
> > > NAK.
> > > 
> > > This is a hack that works around a dts organisation issue. This is _not_
> > > a binding or parsing issue.
> > 
> > So the DT is stupid. Yes w have board and SoC information
> > so we do not want to duplicate them. Having a way to descript SoC vs board
> > specific information need to be provided.
> 
> I agree that the current situation isn't fantastic. That doesn't make
> the DT stupid. There are other solutions to this problem.
> 
> > 
> > > 
> > > Properties can be overridden - just describe all of the interrupts in
> > > the final dts file.
> > this is wrong, which mean you duplicate informaation and duplicate bug and
> > fixes
> 
> It's certainly not nice, but it doesn't make it wrong.
> 
> The same problem can be found with any other list property that varies
> per-board. Hacking the parsing of each property is not a solution.

agreed we have the same issue on pinctrl as example and it's become a
nightmare
> 
> Today the only way to implement what you want is to have the list in the
> final file.
> 
> One way of working with that would be to have the common interrupts
> described in a shared macro in the soc file:
> 
> #define SOC_COMMON_INTERRUPTS <&intc1 5 1>, <&intc2 1 0>
> 
> Then the soc file can have:
> 
> 	interrupts = SOC_COMMON_INTERRUPTS;
> 
> And the board can have:
> 
> 	interrupts = SOC_COMMON_INTERRUPTS, <&intc1 6 1>;
hugly for me as a board could work on x SoC so the final dt could be compile
for more than 1 SoC if you one alias
> 
> That gains functionality equivalent to your proposal, without
> introducing new code or new edge cases in interrupt parsing. However, it
> does make it unclear how many interrupts are described, and it won't
> interact well with interrupt-names.
> 
> Another, more invasive option would be extend the dts syntax and teach
> dtc to handle property appending. Then the soc dts could stay as it is,
> and the board dts could have something like:
> 
> 	/append-property/ interrupts = <&intc1 6 1>;
> 	/append-property/ interrupt-names = "board-specific-irq";
> 
> Both these options solve the issue at the source, are general to other
> properties, and allow more than one level of hierarchy (the proposed
> interrupts-extended-2 only allows one level).
agreed here but this touch dtc

Best Regards,
J.
> 
> Thanks,
> Mark.
