From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 15 Feb 2015 21:17:51 -0800
Subject: [PATCH 1/2] Input: bcm-keypad: add device tree bindings
In-Reply-To: <54DF7C8B.3050103@broadcom.com>
References: <sbranden@broadcom.com>
 <1423526861-29579-1-git-send-email-sbranden@broadcom.com>
 <1423526861-29579-2-git-send-email-sbranden@broadcom.com>
 <20150210005134.GA13695@dtor-ws> <54DF7C8B.3050103@broadcom.com>
Message-ID: <20150216051751.GA15948@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Sat, Feb 14, 2015 at 08:49:15AM -0800, Scott Branden wrote:
> Hi Dmitry,
> 
> Comments inline.  I still have an issue with vendor prefix as there
> are not documented guidelines I can find in this area?

I looked and I could not locate it written down either. I think Grant is
in Santa Rosa this week, I'll ask him to clarify.

> 
> 
> On 15-02-09 04:51 PM, Dmitry Torokhov wrote:
> >Hi Scott,
> >
> >On Mon, Feb 09, 2015 at 04:07:40PM -0800, Scott Branden wrote:
> >>Documents the Broadcom keypad controller device tree bindings.
> >>
> >>Reviewed-by: Ray Jui <rjui@broadcom.com>
> >>Signed-off-by: Scott Branden <sbranden@broadcom.com>
> >>---
> >>  .../devicetree/bindings/input/brcm,bcm-keypad.txt  | 118 +++++++++++++++++++++
> >>  1 file changed, 118 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
> >>new file mode 100644
> >>index 0000000..645829d
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
> >>@@ -0,0 +1,118 @@
> >>+* Broadcom Keypad Controller device tree bindings
> >>+
> >>+Broadcom Keypad controller is used to interface a SoC with a matrix-type
> >>+keypad device. The keypad controller supports multiple row and column lines.
> >>+A key can be placed at each intersection of a unique row and a unique column.
> >>+The keypad controller can sense a key-press and key-release and report the
> >>+event using a interrupt to the cpu.
> >>+
> >>+This binding is based on the matrix-keymap binding with the following
> >>+changes:
> >>+
> >>+keypad,num-rows and keypad,num-columns are required.
> >>+
> >>+Required SoC Specific Properties:
> >>+- compatible: should be "brcm,bcm-keypad"
> >>+
> >>+- reg: physical base address of the controller and length of memory mapped
> >>+  region.
> >>+
> >>+- interrupts: The interrupt number to the cpu.
> >>+
> >>+Board Specific Properties:
> >>+- keypad,num-rows: Number of row lines connected to the keypad
> >>+  controller.
> >>+
> >>+- keypad,num-columns: Number of column lines connected to the
> >>+  keypad controller.
> >>+
> >>+- key-interrupt-trigger-type: The type of interrupt trigger asociated with the Keypad matrix.
> >>+
> >>+	KEYPAD_INTERRUPT_NO_TRIGGER	=	0
> >>+	KEYPAD_INTERRUPT_RISING_EDGE	=	1
> >>+	KEYPAD_INTERRUPT_FALLING_EDGE	=	2
> >>+	KEYPAD_INTERRUPT_BOTH_EDGES	=	3
> >
> >Can we get this data from the interrupt spec?
> I don't understand your question. Could you elaborate?
> But, looking at this closer this determines when the hardware should
> generate interrupts.  I think we would always need to set it to both
> edges and this binding option can probably we removed?

What I meant that interrupt binding allows specifying the trigger and
you have separate binding for trigger here. It would be nice to have
just one (the standard interrupt binding).

> >
> >>+
> >>+- col-debounce-filter-period: The debounce period for the Column filter.
> >>+
> >>+	KEYPAD_DEBOUNCE_1_ms	=	0
> >>+	KEYPAD_DEBOUNCE_2_ms	=	1
> >>+	KEYPAD_DEBOUNCE_4_ms	=	2
> >>+	KEYPAD_DEBOUNCE_8_ms	=	3
> >
> >>+	KEYPAD_DEBOUNCE_16_ms	=	4
> >>+	KEYPAD_DEBOUNCE_32_ms	=	5
> >>+	KEYPAD_DEBOUNCE_64_ms	=	6
> >>+	KEYPAD_DEBOUNCE_128_ms	=	7
> >>+
> >>+- status-debounce-filter-period: The debounce period for the Status filter.
> >>+
> >>+	KEYPAD_DEBOUNCE_1_ms	=	0
> >>+	KEYPAD_DEBOUNCE_2_ms	=	1
> >>+	KEYPAD_DEBOUNCE_4_ms	=	2
> >>+	KEYPAD_DEBOUNCE_8_ms	=	3
> >>+	KEYPAD_DEBOUNCE_16_ms	=	4
> >>+	KEYPAD_DEBOUNCE_32_ms	=	5
> >>+	KEYPAD_DEBOUNCE_64_ms	=	6
> >>+	KEYPAD_DEBOUNCE_128_ms	=	7
> >
> >I could swear device-specific properties should be in form of
> ><vendor-prefix>,<property-name> to ensure it won't clash with changes on
> >subsystem level later on. Device-tree folks, what say you?
> I see examples with and without vendor-prefix.
> qcom,pm8xxx-keypad.txt does not have prefixes
> st-keyscan.txt does have a prefix
> 
> I can't find any documented guidelines for this.

As I mentioned I'll try to get clarification on this.

> Clash changes should not happen because as new standard properties
> are added the drivers should be adjusted to use the new dt-bindings?

This is a misconception: device tree bindings are supposed to form ABI
(and the goal to eventually separate them from the kernel) and so we
need to support old bindings in new kernels.

Thanks.

-- 
Dmitry
