From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Jun 2012 09:05:47 -0600
Subject: pinctrl: group/pin identity mapping
In-Reply-To: <4FC89437.1070304@parrot.com>
References: <4FC89437.1070304@parrot.com>
Message-ID: <4FC8DA4B.2040600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2012 04:06 AM, Gr?gor Boirie wrote:
> Hi All,
> 
> I'm trying to implement pinctrl support for our new cortex based SoC.
> Our driver should provide support for pinctrl/pinmux/pinconf combination
> without device tree handling at the moment.
> However, I'm afraid I misunderstand how groups relate to muxed pins and
> I'd like to hear your suggestions.
> 
> Here's the HW: our I/O pins subsystem allows us to multiplex every
> controllable pins using up to 4 mutually exclusive functions, i.e. there
> is no notion of pin GROUP multiplexing at the HW level (one register per
> pin is available to setup multiplexing and other electronic properties
> like drive strength, pull up/down...).
> 
> However, it seems the pinctrl subsystem requires the driver to provide
> pin groups for pinmux implementation.
> So my question is: having no notion of HW pin groups whatsoever, should I:
> 
> 1) implement a software/logical group that would arbitrarily gather
> multiple HW pins in a platform dependent manner ?
> 
> 2) perform an identity mapping between HW pin and software/logical group
> with up to 4 groups/HW pins per pinmux function ?
> 
> 3) anything else ? any way to bypass the pinctrl group logic to directly
> assign pins rather than groups to pinmux functions ?

Here's my take.

pinctrl originally (early during design) only supported per-pin muxing.
This didn't work for Tegra (since it really has register fields that
affect muxing of multiple pins at once; groups), so I requested allowing
per-group muxing as well. We ended up only allowing per-group muxing and
dropped per-pin muxing:-( So, /my/ intention was to only use groups for
true groups in HW.

However, many others have taken this group muxing capability and used it
for a different purpose; to define SW-only groups that end up affecting
HW registers/fields and hence multiple pins at once, e.g. a group for
for each of the possible mux locations for e.g. HW module UART A , which
contain s of the pins used for that mux option.

So, you have two choices:

a) (Like Tegra30): Define a group for each pin, that contains just that
one pin. This will allow you to pick the mux option for each pin
individually (since there's a group per pin) in the pinctrl mapping
table. In my (personal) opinion (which is evidently rarely shared), this
is the correct approach, since the pinctrl driver directly models the HW
capabilities. Also, if/when pinctrl re-gains the capability to request
mux options per-pin in addition to per-group, the conversion will likely
be quite trivial if you want to do so.

b) For each HW module, for each set of pins it makes sense to use for
that HW module (i.e. all the different sets of pins it can be mux'd to),
create a group for those pins. Many pins will be in multiple different
semi-arbitrarily overlapping groups. I personally call these "virtual
groups" since they don't correspond 1:1 with HW registers/fields. Create
a function for each HW module. Allow each HW module's function to be
mux'd onto each of the groups you created for it. There are probably
quite a few existing examples of this in drivers/pinctrl.

Hope this helps!
