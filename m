From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 17 Sep 2013 17:36:32 -0700
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <5231E44C.9070800@ahsoftware.de>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <344239800.bDEkDg48ZQ@avalon>
 <CACRpkdavR=fv+y1RCNfdgQypPuRbO6isOSwGsABDrYiGeMdyZw@mail.gmail.com>
 <52308C91.2000105@ahsoftware.de> <523096FE.8080901@collabora.co.uk>
 <5230AB6E.1070807@ahsoftware.de> <5231817F.8000901@ahsoftware.de>
 <5231934D.4060706@collabora.co.uk> <52319741.5050407@ahsoftware.de>
 <5231A0F8.1070505@ahsoftware.de> <5231A4FE.1070704@ahsoftware.de>
 <5231A791.9080600@ahsoftware.de> <5231DB88.90605@wwwdotorg.org>
 <5231E44C.9070800@ahsoftware.de>
Message-ID: <20130918003632.CBF48C42BC5@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Sep 2013 17:57:00 +0200, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 12.09.2013 17:19, schrieb Stephen Warren:
> >
> > IRQs, DMA channels, and GPIOs are all different things. Their bindings
> > are defined independently. While it's good to define new types of
> > bindings consistently with other bindings, this hasn't always happened,
> > so you can make zero assumptions about the IRQ bindings by reading the
> > documentation for any other kind of binding.
> >
> > Multiple interrupts are defined as follows:
> >
> > 	// Optional; otherwise inherited from parent/grand-parent/...
> > 	interrupt-parent = <&gpio6>;
> > 	// Must be in a fixed order, unless binding defines that the
> > 	// optional interrupt-names property is to be used.
> > 	interrupts = <1 IRQF_TRIGGER_HIGH> <2 IRQF_TRIGGER_LOW>;
> > 	// Optional; binding for device defines whether it must
> > 	// be present
> > 	interrupt-names = "foo", "bar";
> >
> > If you need multiple interrupts, each with a different parent, you need
> > to use an interrupt-map property (Google it for a more complete
> > explanation I guess). Unlike "interrupts", "interrupt-map" has a phandle
> > in each entry, and hence each entry can refer to a different IRQ
> > controller. You end up defining a dummy interrupt controller node (which
> > may be the leaf node with multiple IRQ outputs, which then points at
> > itself as the interrupt parent), pointing the leaf node's
> > interrupt-parent at that node, and then having interrupt-map "demux" the
> > N interrupt outputs to the various interrupt controllers.
> 
> What a mess. I assume that is the price that bindings don't have to change.
> 
> Thanks for clarifying that,
> 
> Alexander Holler

Actually, I think it is solveable but doing so requires a new binding
for interrupts. I took a shot at implementing it earlier this week and
I've got working patches that I'll be posting soon. I created a new
"interrupts-extended" property that uses a phandle+args type of
binding like this:

intc1: intc at 1000 {
	interrupt-controller;
	#interrupt-cells = <1>;
};

intc2: intc at 2000 {
	interrupt-controller;
	#interrupt-cells = <2>;
};

device at 3000 {
	interrupts-extended = <&intc1 5> <&intc2 3 4> <&intc1 6>;
};

'interrupts-extended' will be proposed as a directly replacement of the
'interrupts' property and it will eliminate the need for an
interrupt-map property. A node will be allowed to have one or the other,
but not both.

I'll write up a proper binding document and post for review.

g.
