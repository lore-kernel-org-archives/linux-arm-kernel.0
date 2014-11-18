From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 18 Nov 2014 09:12:58 -0800
Subject: [PATCH V5 09/12] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <20141118003305.GB11280@saruman>
References: <1416264102-1323-1-git-send-email-abrestic@chromium.org>
 <1416264102-1323-10-git-send-email-abrestic@chromium.org>
 <20141117231240.GB9716@saruman>
 <CAL1qeaG1=g39gsRHPrmCTBFbn3XQmW_2N7rm7uWa=-xOzDiDHQ@mail.gmail.com>
 <20141118003305.GB11280@saruman>
Message-ID: <CAL1qeaFRPcTVABoEbip=Fq0nHo6aKSR7bhTo3QQYcZq2k1S3Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 4:33 PM, Felipe Balbi <balbi@ti.com> wrote:
>> >> +static int tegra_xhci_load_firmware(struct tegra_xhci_hcd *tegra)
>> >> +{
>> >> +     struct device *dev = tegra->dev;
>> >> +     struct tegra_xhci_fw_cfgtbl *cfg_tbl;
>> >> +     struct tm fw_tm;
>> >> +     u32 val, code_tag_blocks, code_size_blocks;
>> >> +     u64 fw_base;
>> >> +     time_t fw_time;
>> >> +     unsigned long timeout;
>> >> +
>> >> +     if (csb_readl(tegra, XUSB_CSB_MP_ILOAD_BASE_LO) != 0) {
>> >> +             dev_info(dev, "Firmware already loaded, Falcon state 0x%x\n",
>> >> +                      csb_readl(tegra, XUSB_FALC_CPUCTL));
>> >> +             return 0;
>> >> +     }
>> >
>> > won't this prevent rmmod && insmod from succeeding ? Maybe not, as you
>> > return 0 anyway, but if the firmware side craps out, it might be useful
>> > to reload the firmware and reset that block. I wonder if this prevents
>> > that.
>>
>> rmmod && insmod does work with the above since, as you mentioned, we
>> return successfully if the controller is already running.  Attempting
>> to re-load the firmware if the controller is already running won't
>> work - it requires a full power-gate/ungate sequence of the
>> controller.  Unfortunately, that sequence is rather complicated and I
>> haven't had a chance to implement it yet.  it will hopefully be coming
>> later, though.
>
> Alright, could you add a comment on the source code stating that ?
> Perhaps a REVISIT note or FIXME ?

Sure, will do.
