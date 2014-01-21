From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 21 Jan 2014 13:46:53 +0100
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <20140121120214.GK28747@e106331-lin.cambridge.arm.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com>
 <20140115161224.GH25824@e106331-lin.cambridge.arm.com>
 <20140120224742.EC905C40B12@trevor.secretlab.ca>
 <CAOesGMjrLs9eEPurjUpOfgyexnc__FJkRYmAR84_f7C15HH07Q@mail.gmail.com>
 <20140121120214.GK28747@e106331-lin.cambridge.arm.com>
Message-ID: <20140121124653.GQ9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:02 Tue 21 Jan     , Mark Rutland wrote:
> On Tue, Jan 21, 2014 at 01:03:23AM +0000, Olof Johansson wrote:
> > On Mon, Jan 20, 2014 at 2:47 PM, Grant Likely <grant.likely@linaro.org> wrote:
> > > On Wed, 15 Jan 2014 16:12:24 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > >> >
> > >> > Another, more invasive option would be extend the dts syntax and teach
> > >> > dtc to handle property appending. Then the soc dts could stay as it is,
> > >> > and the board dts could have something like:
> > >> >
> > >> >     /append-property/ interrupts = <&intc1 6 1>;
> > >> >     /append-property/ interrupt-names = "board-specific-irq";
> > >> >
> > >> > Both these options solve the issue at the source, are general to other
> > >> > properties, and allow more than one level of hierarchy (the proposed
> > >> > interrupts-extended-2 only allows one level).
> > >>
> > >> I've just had a go at implementing the append-property mechanism above
> > >> in dtc, and it was far easier than I expected (patch below).
> > >>
> > >> Does anyone have any issues with the /append-property/ idea?
> > >
> > > I think that is reasonable.
> > 
> > 
> > The main problem with this (same for clocks) is if you need to append
> > something with a name when the original didn't have any.
> 
> Can you not just add a name in the original file? I assume we're not
> going to use this to adjust dts files we're not already in full control
> of.
> 
> > 
> > Reordering entries might not work for interrupts, since the bindings
> > might have requirements on order.
> 
> That's a fair point.
> 
> Do we currently have any optional/board-specific interrupts which must
> appear at the start or middle of the list?
> 
> For those, could we add names? The kernel should be abel to fall back to
> ordering if names aren't present, and we can recommend a particular
> ordering for compatiblity with older kernels.
> 
> As a general preventative measure it would be nice to have named
> elements whenever elements can be optional.

I never was a fanof index search I do agree the names irq is the best way
> 
> > 
> > I'm not aware of a good solution for this. Suggestions welcome.
> 
> Me neither. Prepending and appending is easy.
> 
> Inserting and/or modifying the list requires knowledge of the size of
> each element (and for variable-sized entries requires knowledge of the
> particular binding, which we cannot embed in dtc). 
> 
> I suspect adding richer syntax for modifying properties in arbitrary
> ways will devolve into a turing tarpit.

no this need to stay simple if too much complexe => mess up, unmaintainable

if you really have complex stuff duplicate the info

Best Regards,
J.
> 
> Thanks,
> Mark.
