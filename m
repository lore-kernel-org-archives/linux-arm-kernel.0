From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 24 Jan 2014 17:39:55 +0000
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <CAOesGMjrLs9eEPurjUpOfgyexnc__FJkRYmAR84_f7C15HH07Q@mail.gmail.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com> <
 20140115161224.GH25824@e106331-lin.cambridge.arm.com> <20140120224742.
 EC905C40B12@trevor.secretlab.ca> <
 CAOesGMjrLs9eEPurjUpOfgyexnc__FJkRYmAR84_f7C15HH07Q@mail.gmail.com>
Message-ID: <20140124173955.135E1C40A02@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jan 2014 17:03:23 -0800, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jan 20, 2014 at 2:47 PM, Grant Likely <grant.likely@linaro.org> wrote:
> > On Wed, 15 Jan 2014 16:12:24 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >
> >> > Another, more invasive option would be extend the dts syntax and teach
> >> > dtc to handle property appending. Then the soc dts could stay as it is,
> >> > and the board dts could have something like:
> >> >
> >> >     /append-property/ interrupts = <&intc1 6 1>;
> >> >     /append-property/ interrupt-names = "board-specific-irq";
> >> >
> >> > Both these options solve the issue at the source, are general to other
> >> > properties, and allow more than one level of hierarchy (the proposed
> >> > interrupts-extended-2 only allows one level).
> >>
> >> I've just had a go at implementing the append-property mechanism above
> >> in dtc, and it was far easier than I expected (patch below).
> >>
> >> Does anyone have any issues with the /append-property/ idea?
> >
> > I think that is reasonable.
> 
> 
> The main problem with this (same for clocks) is if you need to append
> something with a name when the original didn't have any.
> 
> Reordering entries might not work for interrupts, since the bindings
> might have requirements on order.

Hmmm, yes. to handle that case would need a higher level construct that
keeps the name and interrupt value together. Maybe something like this?

device {
	add-interrupt(27);
	add-interrupt(29, 5, controller=&intc1);
	add-interrupt(2, 4, name="error");
};

I'm using python-like syntax here where controller and name are optional
arguments.

We could get DTC to generate the appropriate interrupt-parent,
interrupts, interrupts-extended and interrupt-names properties as
needed. Of course the shared context would be lost when the tree is
compiled, but it would be useful for building up parsing data. It would
also work for gpio, clocks and similar bindings. Kind of like an
intelligent macro.

g.
