From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 14 Sep 2011 11:13:18 -0600
Subject: [PATCH 2/2] input: samsung-keypad: Add device tree support
In-Reply-To: <CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
	<CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
Message-ID: <20110914171318.GA24425@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
> Hi Grant,
> 
> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
> >> Add device tree based discovery support for Samsung's keypad controller.
> >>
> >> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> >> Cc: Donghwa Lee <dh09.lee@samsung.com>
> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >> ---
> >> ?.../devicetree/bindings/input/samsung-keypad.txt ? | ? 88 ++++++++++
> >> ?drivers/input/keyboard/samsung-keypad.c ? ? ? ? ? ?| ?177 ++++++++++++++++++--
> >> ?2 files changed, 253 insertions(+), 12 deletions(-)
> >> ?create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> >> new file mode 100644
> >> index 0000000..e1c7237
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> >> @@ -0,0 +1,88 @@
> >> +* Samsung's Keypad Controller device tree bindings
> >> +
> >> +Samsung's Keypad controller is used to interface a SoC with a matrix-type
> >> +keypad device. The keypad controller supports multiple row and column lines.
> >> +A key can be placed at each intersection of a unique row and a unique column.
> >> +The keypad controller can sense a key-press and key-release and report the
> >> +event using a interrupt to the cpu.
> >> +
> >> +Required SoC Specific Properties:
> >> +- compatible: should be one of the following
> >> + ?- "samsung,s3c6410-keypad": For controllers compatible with s3c6410 keypad
> >> + ? ?controller.
> >> + ?- "samsung,s5pv210-keypad": For controllers compatible with s5pv210 keypad
> >> + ? ?controller.
> >> +
> >> +- reg: physical base address of the controller and length of memory mapped
> >> + ?region.
> >> +
> >> +- interrupts: The interrupt number to the cpu.
> >> +
> >> +Required Board Specific Properties:
> >> +- samsung,keypad-num-rows: Number of row lines connected to the keypad
> >> + ?controller.
> >> +
> >> +- samsung,keypad-num-columns: Number of column lines connected to the
> >> + ?keypad controller.
> >> +
> >> +- row-gpios: List of gpios used as row lines. The gpio specifier for
> >> + ?this property depends on the gpio controller to which these row lines
> >> + ?are connected.
> >> +
> >> +- col-gpios: List of gpios used as column lines. The gpio specifier for
> >> + ?this property depends on the gpio controller to which these column
> >> + ?lines are connected.
> >
> > I know we've got overlapping terminology here. ?When you say GPIOs
> > here, does it refer to the pin multiplexing feature of the samsung
> > parts, and thus how the keypad controller IO is routed to the pins?
> > Or does the driver manipulate GPIO lines manually?
> 
> It is intended to mean gpio and not the pinmux. But the way the gpio
> specifier is specified in the dts file, it includes information about
> both gpio number and the pin-control details. For instance, if 'gpa0'
> is a gpio controller (which includes pin-control functionality as well
> in the hardware), then the gpio specifier for the keypad would be as
> below.
> 
> row-gpios = <&gpa0 0 3 3 0>,
>                  <&gpa0 1 3 3 0>;
> 
> The syntax for the gpio specifier is
> <[phandle of gpio controller] [pin number within the gpio controller]
> [mux function] [pull up/down] [drive strength]>
> 
> The keypad driver does not know or use the mux function, pull up/down
> and drive strength details. The driver would call of_get_gpio to get
> the linux gpio number and then do a gpio_request on that gpio number.
> The gpio dt support manges the pin-mux and other settings
> transparently for the keypad driver. So even though the gpio specifier
> format changes, the dt support code for the driver does not change.
> 
> The driver does not manipulate the gpios directly. It just requests
> for the gpio number and makes a note of the number to free it when the
> driver unbinds.
> 
> >
> > If it is pin multiplexing, then using the GPIO binding seems rather
> > odd. It may be entirely appropriate, but it will need to play well
> > with the pinmux stuff that linusw is working on.
> 
> When pinmux/pin-ctrl functionality which linusw is developing is used
> for this driver, it would be a extension to this patch. The driver
> would request for the gpio and then use the pin-ctrl subsystem api to
> setup the pin-control. In that case, the gpio-specifier would change
> but that change would be break anything which this patch does.
> 
> >
> >> +
> >> +- Keys represented as child nodes: Each key connected to the keypad
> >> + ?controller is represented as a child node to the keypad controller
> >> + ?device node and should include the following properties.
> >> + ?- keypad,row: the row number to which the key is connected.
> >> + ?- keypad,column: the column number to which the key is connected.
> >> + ?- keypad,key-code: the key-code to be reported when the key is pressed
> >> + ? ?and released.
> >
> > What defines the meanings of the key codes?
> 
> The key-code could be any value which the system would want the keypad
> driver to report when that key is pressed.

Are they linux keycodes?  If so, then this property name can
probably be linux,code.  There is already precedence for that
usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt.  (I
would personally prefer "linux,key-code", but sometimes it is better
to go with existing precidence) You could also use linux,input-type as
specified in that binding.

> 
> >
> >> +
> >> +Optional Properties specific to linux:
> >> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> >> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
> >
> > Is this really a linux-specific feature?
> 
> Yes, it is a property defined by the linux subsystems. A non-linux
> system might not have such features.

I was specifically referring to the wakeup property, but okay, I can
see the argument that it is linux-specific because it is usage-policy
related.

g.
