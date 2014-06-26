From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Jun 2014 14:00:14 -0600
Subject: [PATCH v1 3/9] of: Update Tegra XUSB pad controller binding for
 USB
In-Reply-To: <CAL1qeaEnOEgdNp8F1YyUAeco6WVY0XffpiEDsPGdcCQL62sw3Q@mail.gmail.com>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>	<1403072180-4944-4-git-send-email-abrestic@chromium.org>	<53AB432A.7010400@wwwdotorg.org>
 <CAL1qeaEnOEgdNp8F1YyUAeco6WVY0XffpiEDsPGdcCQL62sw3Q@mail.gmail.com>
Message-ID: <53AC7BCE.4030604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 04:25 PM, Andrew Bresticker wrote:
> Thanks for the review Stephen!
> 
> On Wed, Jun 25, 2014 at 2:46 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
>>> Add new bindings used for USB support by the Tegra XUSB pad controller.
>>> This includes additional PHY types, USB-specific pinconfig properties, etc.
>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
>>
>>> @@ -21,6 +21,12 @@ Required properties:
>>>    - padctl
>>>  - #phy-cells: Should be 1. The specifier is the index of the PHY to reference.
>>>    See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list of valid values.
>>> +- nvidia,xusb-mbox: Handle to the Tegra XUSB mailbox node.
>>
>> Why does the padctrl code need access to the XUSB mailbox?
> 
> The XUSB firmware sends messages which make requests of the PHY (XUSB
> pad controller), such as idling/un-idling the HSIC PHYs or saving USB3
> PHY context.
> 
>> Isn't the padctrl HW module something that provides services to the XUSB
>> code. I would have expected the XUSB node to reference the padctrl node.
> 
> The XUSB padctrl HW does provide services to the XUSB host in the form
> of PHYs and it is through the PHY bindings that the host references
> the padctrl node.
> 
>> If notifications need to be sent back from XUSB padctrl to XUSB, then that
>> seems like an internal SW detail that doesn't need to be represented in DT.
> 
> I think you mean notifications need to be sent back from the XUSB host
> to the XUSB padctrl?  This is what the mailbox is for and I chose to
> have the padctrl refer to the mailbox since messages are sent from the
> mailbox which make requests to the PHY specifically and not the host
> (see above).

I've looked at the details of the mailbox messages a bit more now. It
seems that the firmware running on the XUSB controller sends a variety
of different messages, some of which are relevant to the XHCI controller
driver and some relevant to the PHY/PAD driver. It's a pity these
different message streams are intermixed, but I guess that's not changing.

As such, I think at this stage it does make sense for the mailbox to be
represented as a separate node, with each of the XHCI controller and USB
PADCTL nodes referring to the mailbox node by phandle.

I'm still not 100% sure about whether the PHY driver is the same level
of abstraction intended by the Linux kernel's PHY layer. Pending that
discussion's results, the "PHY" message from the firmware may not go to
a Linux kernel PHY but some layer above which might get subsumed into
the overall XHCI controller driver, which would change my argument above
a bit.
