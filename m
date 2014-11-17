From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 17 Nov 2014 15:51:29 -0800
Subject: [PATCH V5 09/12] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <20141117231240.GB9716@saruman>
References: <1416264102-1323-1-git-send-email-abrestic@chromium.org>
 <1416264102-1323-10-git-send-email-abrestic@chromium.org>
 <20141117231240.GB9716@saruman>
Message-ID: <CAL1qeaG1=g39gsRHPrmCTBFbn3XQmW_2N7rm7uWa=-xOzDiDHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Mon, Nov 17, 2014 at 3:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 17, 2014 at 02:41:39PM -0800, Andrew Bresticker wrote:
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index a3ca137..e2415d3 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -50,6 +50,15 @@ config USB_XHCI_RCAR
>>         Say 'Y' to enable the support for the xHCI host controller
>>         found in Renesas R-Car ARM SoCs.
>>
>> +config USB_XHCI_TEGRA
>> +     tristate "xHCI support for NVIDIA Tegra SoCs"
>> +     depends on ARCH_TEGRA
>
> it would be nice if you could still leave || COMPILE_TEST here.

Sure.

>> +static const struct {
>> +     const char *name;
>> +     unsigned int num;
>> +} tegra_xhci_phy_types[] = {
>> +     {
>> +             .name = "usb3",
>> +             .num = TEGRA_XUSB_USB3_PHYS,
>> +     }, {
>> +             .name = "utmi",
>> +             .num = TEGRA_XUSB_UTMI_PHYS,
>> +     }, {
>> +             .name = "hsic",
>> +             .num = TEGRA_XUSB_HSIC_PHYS,
>> +     },
>
> these should be using the generic PHY subsystem (drivers/phy).

This driver does use the generic PHY subsystem, see patch 7 in this series :).

>> +static int tegra_xhci_load_firmware(struct tegra_xhci_hcd *tegra)
>> +{
>> +     struct device *dev = tegra->dev;
>> +     struct tegra_xhci_fw_cfgtbl *cfg_tbl;
>> +     struct tm fw_tm;
>> +     u32 val, code_tag_blocks, code_size_blocks;
>> +     u64 fw_base;
>> +     time_t fw_time;
>> +     unsigned long timeout;
>> +
>> +     if (csb_readl(tegra, XUSB_CSB_MP_ILOAD_BASE_LO) != 0) {
>> +             dev_info(dev, "Firmware already loaded, Falcon state 0x%x\n",
>> +                      csb_readl(tegra, XUSB_FALC_CPUCTL));
>> +             return 0;
>> +     }
>
> won't this prevent rmmod && insmod from succeeding ? Maybe not, as you
> return 0 anyway, but if the firmware side craps out, it might be useful
> to reload the firmware and reset that block. I wonder if this prevents
> that.

rmmod && insmod does work with the above since, as you mentioned, we
return successfully if the controller is already running.  Attempting
to re-load the firmware if the controller is already running won't
work - it requires a full power-gate/ungate sequence of the
controller.  Unfortunately, that sequence is rather complicated and I
haven't had a chance to implement it yet.  it will hopefully be coming
later, though.
