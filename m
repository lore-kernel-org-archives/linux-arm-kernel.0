From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Jun 2014 12:08:57 -0600
Subject: [PATCH v1 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <CAL1qeaHhoqEPu-j+drNiRMyeutz=qqZPxSP8H+v-sgjZSfS5tQ@mail.gmail.com>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>	<1403072180-4944-5-git-send-email-abrestic@chromium.org>	<53AB493F.3030802@wwwdotorg.org>
 <CAL1qeaHhoqEPu-j+drNiRMyeutz=qqZPxSP8H+v-sgjZSfS5tQ@mail.gmail.com>
Message-ID: <53AC61B9.5030408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 05:30 PM, Andrew Bresticker wrote:
> On Wed, Jun 25, 2014 at 3:12 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
>>> In addition to the PCIe and SATA PHYs, the XUSB pad controller also
>>> supports 3 UTMI, 2 HSIC, and 2 USB3 PHYs.  Each USB3 PHY uses a single
>>> PCIe or SATA lane and is mapped to one of the three UTMI ports.
>>>
>>
>>> diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c
>>
>>> @@ -372,6 +720,193 @@ static int tegra_xusb_padctl_pinconf_group_set(struct pinctrl_dev *pinctrl,
>>>                       padctl_writel(padctl, regval, lane->offset);
>>>                       break;
>>>
>>> +             case TEGRA_XUSB_PADCTL_USB3_PORT_NUM:
>>> +                     if (value >= TEGRA_XUSB_PADCTL_USB3_PORTS) {
>>> +                             dev_err(padctl->dev, "Invalid USB3 port: %lu\n",
>>> +                                     value);
>>> +                             return -EINVAL;
>>> +                     }
>>> +                     if (!is_pcie_sata_lane(group)) {
>>> +                             dev_err(padctl->dev,
>>> +                                     "USB3 port not applicable for pin %d\n",
>>> +                                     group);
>>> +                             return -EINVAL;
>>> +                     }
>>> +                     padctl->usb3_ports[value].lane = group;
>>> +                     break;
>>
>> It feels odd to use pinctrl for a SW-only purpose. In other words, that
>> chunk of code isn't writing the pinconf data to HW, but rather some
>> internal variable.
> 
> Well the mapping of lanes to USB3 ports is a hardware property and we
> do use it when programming the hardware later to choose which set of
> lane registers to program given a USB3 port, but it's true that it's
> not some value we program into HW directly.
> 
>> Perhaps it would make more sense for the DT binding to represent this
>> data directly in a custom property that's parsed at probe() time. That
>> way, pinctrl only touches "real" HW stuff.
> 
> I'm on the fence about this.  If you or others feel strongly about
> this then I can make it a separate DT property and move it out of the
> pinctrl properties.

I'd certainly prefer to use pinctrl bindings only for things that get
directly written into HW. Other configuration data should be easy to
retrieve directly from properties.
