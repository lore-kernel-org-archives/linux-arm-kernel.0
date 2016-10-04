From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 4 Oct 2016 20:39:24 +0530
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com>
 <57C41582.1030604@linux.intel.com> <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
 <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
 <1475578687.1912.28.camel@mniewoehner.de>
 <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
Message-ID: <CANAwSgQ2j+NtDwgn972-1UdY=j4DEsB+0d7VdhoC9i9WHRc9yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 4 October 2016 at 17:32, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> Hi Michael,
>
>
> On Tue, Oct 4, 2016 at 4:28 PM, Michael Niew?hner <linux@mniewoehner.de> wrote:
>
>> > > > > > [1.] One line summary of the problem:
>> > > > > > DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
>> > > > > >
>> > > > > > [2.] Full description of the problem/report:
>> > > > > > No usb 3.0 devices are being detected when attached while USB 2.0
>> > > > > > devices work on the same port.
>> > > > > > USB 3.0 works after applying patches [9.1] and [9.2], but seems
>> > > > > > to be
>> > > > > > buggy. The usb hub is redetected every time an usb device is
>> > > > > > attached.
>
> [snip]
>
>>> > > > > > [9.] Other notes, patches, fixes, workarounds:
>>> > > > > > [9.1] https://lkml.org/lkml/2014/4/28/234
>>> > > > > > [9.2] https://lkml.org/lkml/2015/2/2/259
>>>
>>> These patches are required to get USB super-speed working on Exynos5420/5800.
>>> But they did not make to upstream. There was resistance on adding new
>>> phy_calibrate()
>>> callback.
>>>
>>> Without these patches the Exynos5420/5800 will enumerate all
>>> super-speed capable devices
>>> as high-speed devices.
>>> Last time we checked with exynos542x smdk boards and peach-* boards,
>>> we could get the
>>> Super - speed devices working. I have not tested odroid anytime so
>>> don't have much idea about the
>>> its intricacies.
>>> I guess Anand was able to use these patches to get his kernel working in past.
>>
>>
>> The patches don't work anymore with 4.8-rc* / 4.8. They worked - but very
>> unstable - with 4.7.
>>
>> One more problem appeared since one of the 4.8-RCs: reboot hangs when the dwc3
>> module is loaded. If I unload it before reboot / shutdown everything is fine.
>>
>>
>>>
>>> When you have a downstream on-board usb hub, ideally it should be able
>>> to detect the devices
>>> and not reset everytime you connect a new device (like you mentioned earlier).
>>> There can be two possible reasons why the hub keeps getting reset ever
>>> after applying the above
>>> mentioned patches:
>>> 1) the clock rates are not proper.
>>> 2) the regulator load setting is not enough to drive the hub.
>>>
>>> Anand, can you please point Michael to an older kernel with which you
>>> could test usb on odroid successfully ?
>>> You can compare the clocks with an older version and see if there'a
>>> any difference.
>>>
>>> Any possibility of any other framework (such as, bus-freq) trimming
>>> down the clock - rates ?
>>
>>
>> ################################
>> # v4.7.5
>> ################################
>>
>> $ cat /sys/kernel/debug/clk/clk_summary | grep usb
>>  sclk_usbh20_scan_clk                     0            0   480000000          0
>>  sclk_usbh20                              0            0    48000
>> 000          0
>>     mout_usbd300                          1            1    24000000          0
>>        dout_usbd300                       0            0    24000000          0
>>           sclk_usbd300
>>                  0            0    24000000          0
>>        dout_usbphy300                     1            1    24000000          0
>>           sclk_usbphy300                  4            4    24000
>> 000          0
>>     mout_usbd301                          1            1    24000000          0
>>        dout_usbd301                       0            0    24000000          0
>>           sclk_usbd301
>>                  0            0    24000000          0
>>        dout_usbphy301                     1            1    24000000          0
>>           sclk_usbphy301                  3            3    24000
>> 000          0
>>                          usbd301           1            1   100000000
>>                          usbd300           1            1   100000000
>>
>> usbh20           3            3   100000000          0
>
>>
>> ################################
>> # v4.8.0
>> ################################
>>
>> $ cat /sys/kernel/debug/clk/clk_summary | grep usb
>>  sclk_usbh20_scan_clk                     0            0   480000000          0
>>  sclk_usbh20                              0            0    48000000
>>         0
>>     mout_usbd300                          1            1    24000000          0
>>        dout_usbd300                       0            0    24000000          0
>>           sclk_usbd300
>>             0            0    24000000          0
>>        dout_usbphy300                     1            1    24000000          0
>>           sclk_usbphy300                  4            4    24000000
>>         0
>>     mout_usbd301                          1            1    24000000          0
>>        dout_usbd301                       0            0    24000000          0
>>           sclk_usbd301
>>             0            0    24000000          0
>>        dout_usbphy301                     1            1    24000000          0
>>           sclk_usbphy301                  3            3    24000000
>>         0
>>                          usbd301           1            1   100000000
>
> This clock should have been 200MHz.
>
>>                          usbd300           1            1   100000000
>>                          usbh2
>> 0           3            3   100000000          0
>>
>> $ cat /sys/kernel/debug/usb/devices
>> <<system hangs>>
>>
>
> The clocks are same across working/non-working.
> Is it possible to bisect the commit that's causing hang for 4.8x ?
>
> Adding few of the folks from Samsung who can test dwc3 usb on smdk/peach boards.
> +Alim, Pankaj
>
> Hi Alim, Pankaj,
> can you please give a try with 4.8 kernel on peach/smdk542x board and
> see if dwc3 usb works or not.
> You may need to the patches mentioned in [9.1] and [9.2] mentioned above.
>
>

[9.1] https://lkml.org/lkml/2014/4/28/234  base: platform: name the
device already during allocation

Dose not help. it's not useful at all.

What I feel is that their need to be some reset of usb phy so that
device are assigned to respective bus ports.
odroid at odroid:~$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
        |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
    |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 480M


Bus 06.Port should register the Realtek Ethernet r8153 device.
But I am not able to trace out how it's should happen.

-Best Regards
Anand Moon

> [snip]
>
>
> Thanks
> Vivek
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
