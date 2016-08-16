From: John.Youn@synopsys.com (John Youn)
Date: Tue, 16 Aug 2016 12:20:47 -0700
Subject: [PATCH V2 RFC 1/6] usb: dwc2: core: Avoid nonsense error in
 gadget mode
In-Reply-To: <2008594325.331112.5842a41f-9d6d-4b55-baac-1529d6cae164.open-xchange@email.1und1.de>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
 <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
 <2008594325.331112.5842a41f-9d6d-4b55-baac-1529d6cae164.open-xchange@email.1und1.de>
Message-ID: <69b9522a-ca23-cc32-ec90-8d59f63e4e03@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/16/2016 9:44 AM, Stefan Wahren wrote:
> Hi John,
> 
>> John Youn <John.Youn@synopsys.com> hat am 16. August 2016 um 03:30
>> geschrieben:
>>
>>
>> On 7/26/2016 11:54 AM, Stefan Wahren wrote:
>>> In gadget mode On bcm2835 platform the host tx fifo size could be zero.
>>> So add zero to range and avoid such nonsense errors:
>>>
>>> dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size.
>>> dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
>>> dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size.
>>> dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
>>
>> Hi Stefan,
>>
>> Are those the power on reset values of GNPTXFSIZ and HPTXFSIZ?
>>
>> If these values can be 0, I think the patch is ok. But I'm not sure
>> about that. I can check with some hardware engineers to see under what
>> conditions this is possible.
> 
> i'm not sure that i can answer your question correctly. Let me send you some
> logs and i hope these answer your question.
> 
> Since the Raspberry Pi Zero with bcm2835 could handle all three dr_mode set in
> DT ( otg, host, peripherial ), i made 3 logs before this patch is applied:
> 

...

> 
> Raspberry Pi Zero
> dr_mode = "peripheral"
> 
> Linux raspberrypi 4.7.0-rc7-next-20160719+ #3 Thu Jul 21 17:12:23 UTC 2016
> armv6l GNU/Linux
> 
> [    2.310942] dwc2_lowlevel_hw_init()
> [    2.328044] dwc2 20980000.usb: dwc2: cannot get otg clock
> [    2.337405] dwc2_lowlevel_hw_enable()
> [    2.344937] dwc2_get_dr_mode()
> [    2.351820] dwc2 20980000.usb: Forcing mode to device
> [    2.469267] dwc2_get_hwparams()
> [    2.476052] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
> [    2.476067] dwc2 20980000.usb: hwcfg1=00000000
> [    2.476078] dwc2 20980000.usb: hwcfg2=228ddd50
> [    2.476089] dwc2 20980000.usb: hwcfg3=0ff000e8
> [    2.476100] dwc2 20980000.usb: hwcfg4=1ff00020
> [    2.476110] dwc2 20980000.usb: grxfsiz=00001000
> [    2.476123] dwc2 20980000.usb: gnptxfsiz=00201000
> [    2.476135] dwc2 20980000.usb: Detected values from hardware:
> [    2.476146] dwc2 20980000.usb:   op_mode=0
> [    2.476156] dwc2 20980000.usb:   arch=2
> [    2.476166] dwc2 20980000.usb:   dma_desc_enable=0
> [    2.476176] dwc2 20980000.usb:   power_optimized=0
> [    2.476186] dwc2 20980000.usb:   i2c_enable=0
> [    2.476196] dwc2 20980000.usb:   hs_phy_type=1
> [    2.476206] dwc2 20980000.usb:   fs_phy_type=1
> [    2.476216] dwc2 20980000.usb:   utmi_phy_data_width=0
> [    2.476225] dwc2 20980000.usb:   num_dev_ep=7
> [    2.476235] dwc2 20980000.usb:   num_dev_perio_in_ep=0
> [    2.476245] dwc2 20980000.usb:   host_channels=8
> [    2.476256] dwc2 20980000.usb:   max_transfer_size=524287
> [    2.476266] dwc2 20980000.usb:   max_packet_count=1023
> [    2.476277] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
> [    2.476288] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
> [    2.476297] dwc2 20980000.usb:   dev_token_q_depth=0x8
> [    2.476308] dwc2 20980000.usb:   enable_dynamic_fifo=1
> [    2.476318] dwc2 20980000.usb:   en_multiple_tx_fifo=1
> [    2.476328] dwc2 20980000.usb:   total_fifo_size=4080
> [    2.476338] dwc2 20980000.usb:   host_rx_fifo_size=4096
> [    2.476349] dwc2 20980000.usb:   host_nperio_tx_fifo_size=0
> [    2.476359] dwc2 20980000.usb:   host_perio_tx_fifo_size=0
> [    2.476368] dwc2 20980000.usb:
> [    2.476378] dwc2 20980000.usb: dwc2_set_parameters()
> [    2.476391] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
> [    2.476418] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
> [    2.476429] dwc2 20980000.usb: Setting hibernation to 0
> [    2.476449] dwc2 20980000.usb: 0 invalid for host_rx_fifo_size. Check HW
> configuration.
> [    2.491704] dwc2 20980000.usb: Setting host_rx_fifo_size to 4096
> [    2.491727] dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size. Check
> HW configuration.
> [    2.507853] dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
> [    2.507875] dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size. Check
> HW configuration.
> [    2.524246] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0

Thanks for the logs.

It looks like if dr_mode == peripheral, dwc2 doesn't populate the
following host-only values from the reset values of the registers.

* hw_params->host_nperio_tx_fifo_size
* hw_params->host_perio_tx_fifo_size

Thus when it goes to set the core_params based on the hw_params you
get the error. As peripheral-only, they are never used so it's fine.

To get rid of the error we can skip setting the host-only parameters
if dr_mode == peripheral.

John
