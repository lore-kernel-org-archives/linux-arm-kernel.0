From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Dec 2016 11:50:06 +0100
Subject: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
In-Reply-To: <20161205083535.GB14004@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
 <20161205065350.GA18069@ulmo.ba.sec> <20161205083535.GB14004@dell>
Message-ID: <20161205105006.GA19891@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 08:35:35AM +0000, Lee Jones wrote:
> On Mon, 05 Dec 2016, Thierry Reding wrote:
> 
> > On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
> > > Define bindings for pwm-stm32
> > > 
> > > version 2:
> > > - use parameters instead of compatible of handle the hardware configuration
> > > 
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> > > new file mode 100644
> > > index 0000000..575b9fb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> > > @@ -0,0 +1,38 @@
> > > +STMicroelectronics PWM driver bindings for STM32
> > 
> > Technically this bindings describe devices, so "driver binding" is a
> > somewhat odd wording. Perhaps:
> > 
> > 	STMicroelectronics STM32 General Purpose Timer PWM bindings
> > 
> > ?
> > 
> > > +
> > > +Must be a sub-node of STM32 general purpose timer driver
> > > +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
> > 
> > Again, "driver parent node" is odd. Perhaps:
> > 
> > 	Must be a sub-node of an STM32 General Purpose Timer device tree
> > 	node. See ../mfd/stm32-general-purpose-timer.txt for details about
> > 	the parent node.
> > 
> > ?
> > 
> > > +Required parameters:
> > > +- compatible:		Must be "st,stm32-pwm"
> > > +- pinctrl-names: 	Set to "default".
> > > +- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> > > +			for PWM module.
> > > +			For Pinctrl properties, please refer to [1].
> > 
> > Your indentation and capitalization are inconsistent. Also, please refer
> > to the pinctrl bindings by relative path and inline, rather than as a
> > footnote reference.
> > 
> > > +
> > > +Optional parameters:
> > > +- st,breakinput:	Set if the hardware have break input capabilities
> > > +- st,breakinput-polarity: Set break input polarity. Default is 0
> > > +			 The value define the active polarity:
> > > +			  - 0 (active LOW)
> > > +			  - 1 (active HIGH)
> > 
> > Could we fold these into a single property? If st,breakinput-polarity is
> > not present it could simply mean that there is no break input, and if it
> > is present you don't have to rely on a default.
> > 
> > > +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
> > 
> > The pwm- prefix is rather redundant since the node is already named pwm.
> > Why not simply st,channels? Or simply channels, since it's not really
> > anything specific to this hardware.
> > 
> > Come to think of it, might be worth having a discussion with our DT
> > gurus about what their stance is on using the # as prefix for numbers
> > (such as in #address-cells or #size-cells). This could be #channels to
> > mark it more explicitly as representing a count.
> 
> Unfortunately that ship has sailed.
> 
> st,pwm-num-chan already exists (with your blessing).  It's usually

I think I did at the time object, though very mildly. The property here
is somewhat different, though. For one this is a PWM specific node, so
the pwm- prefix is completely redundant. Also for pwm-sti where you had
introduced st,pwm-num-chan, the property denoted how many PWM channels
vs. capture channels (st,capture-num-chan) the device was supposed to
use. Here there are only one type of channels.

> suggested to reuse exiting properties when writing new bindings.

Given the above I think this case is different. Further my understanding
is that the desire to reuse existing properties is primarily for generic
properties. Vendor specific properties are always going to have to be
defined in the specific bindings, so it doesn't matter very much whether
they are reused or not.

Lastly, I think st,pwm-num-chan is not optimal, and while it isn't very
bad either, I do believe that when we see ways of improving things then
we should do so, regardless of whether existing ways to describe things
already exist. Especially if it comes at no additional cost.

All of that said, this is my opinion and if everybody thinks that the
st,pwm-num-chan is the better choice I'll merge it. Anyway, we'll need
the Acked-by from one of the device tree bindings maintainers and I'd
like to see at least an attempt at a discussion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/36f76394/attachment.sig>
