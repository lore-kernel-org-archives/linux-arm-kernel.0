From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 27 Aug 2014 09:44:02 -0700
Subject: [PATCH v2 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <53FB8CFE.3090007@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-5-git-send-email-abrestic@chromium.org>
 <53FB8CFE.3090007@wwwdotorg.org>
Message-ID: <CAL1qeaHMa_KrqQyPgvJssOnW8mefQ8KPO9+WdkVODbY2XJe_LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 12:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>
>> In addition to the PCIe and SATA PHYs, the XUSB pad controller also
>> supports 3 UTMI, 2 HSIC, and 2 USB3 PHYs.  Each USB3 PHY uses a single
>> PCIe or SATA lane and is mapped to one of the three UTMI ports.
>>
>> The xHCI controller will also send messages intended for the PHY driver,
>> so request and listen for messages on the mailbox's PHY channel.
>
>
> I'd like a review from Thierry here as the HW expert.
>
> I need an ack from LinusW in order to take this pinctrl patch through the
> Tegra tree.
>
>> diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c
>> b/drivers/pinctrl/pinctrl-tegra-xusb.c
>
>
>> +static int usb3_phy_power_on(struct phy *phy)
>> +{
>> +       struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
>> +       int port = usb3_phy_to_port(phy);
>> +       int lane = padctl->usb3_ports[port].lane;
>> +       u32 value, offset;
>> +
>> +       if (!is_pcie_or_sata_lane(lane)) {
>> +               dev_err(padctl->dev, "USB3 PHY %d mapped to invalid lane:
>> %d\n",
>> +                       port, lane);
>> +               return -EINVAL;
>> +       }
>
>
> An aside: This implies that the SATA driver should be talking to this
> pinctrl driver and explicitly powering on the XUSB pins. However, the SATA
> driver doesn't depend on this series. I'm a bit confused how that works.
> Perhaps it's just by accident? Mikko, can you comment?

As Mikko mentioned, the enabling of the SATA lane in
usb3_phy_power_on() is for when the SATA lane is being used for USB3.

>> +static int utmi_phy_to_port(struct phy *phy)
>> +{
>> +       struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
>> +       int i;
>> +
>> +       for (i = 0; i < TEGRA_XUSB_UTMI_PHYS; i++) {
>> +               if (phy == padctl->phys[TEGRA_XUSB_PADCTL_UTMI_P0 + i])
>> +                       break;
>> +       }
>> +       BUG_ON(i == TEGRA_XUSB_UTMI_PHYS);
>
>
> Can this be triggered by e.g. bad DT content? If so, returning an error
> would be nicer. The comment applies to other xxx_to_port() functions.

No, it cannot.  The struct phy that's passed in here comes from the
PHY core and must be a PHY that we registered earlier in probe().
