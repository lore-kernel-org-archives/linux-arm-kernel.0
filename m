From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 16 Aug 2016 18:44:11 +0200 (CEST)
Subject: [PATCH V2 RFC 1/6] usb: dwc2: core: Avoid nonsense error in
 gadget mode
In-Reply-To: <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
 <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
Message-ID: <2008594325.331112.5842a41f-9d6d-4b55-baac-1529d6cae164.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 16. August 2016 um 03:30
> geschrieben:
> 
> 
> On 7/26/2016 11:54 AM, Stefan Wahren wrote:
> > In gadget mode On bcm2835 platform the host tx fifo size could be zero.
> > So add zero to range and avoid such nonsense errors:
> > 
> > dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size.
> > dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
> > dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size.
> > dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
> 
> Hi Stefan,
> 
> Are those the power on reset values of GNPTXFSIZ and HPTXFSIZ?
> 
> If these values can be 0, I think the patch is ok. But I'm not sure
> about that. I can check with some hardware engineers to see under what
> conditions this is possible.

i'm not sure that i can answer your question correctly. Let me send you some
logs and i hope these answer your question.

Since the Raspberry Pi Zero with bcm2835 could handle all three dr_mode set in
DT ( otg, host, peripherial ), i made 3 logs before this patch is applied:

Raspberry Pi Zero
dr_mode = "host"

Linux raspberrypi 4.7.0-rc7-next-20160719+ #3 Thu Jul 21 17:12:23 UTC 2016
armv6l GNU/Linux

[    2.300866] dwc2_lowlevel_hw_init()
[    2.317961] dwc2 20980000.usb: dwc2: cannot get otg clock
[    2.327328] dwc2_lowlevel_hw_enable()
[    2.334868] dwc2_get_dr_mode()
[    2.341742] dwc2 20980000.usb: Forcing mode to host
[    2.459227] dwc2_get_hwparams()
[    2.466013] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
[    2.466028] dwc2 20980000.usb: hwcfg1=00000000
[    2.466040] dwc2 20980000.usb: hwcfg2=228ddd50
[    2.466051] dwc2 20980000.usb: hwcfg3=0ff000e8
[    2.466061] dwc2 20980000.usb: hwcfg4=1ff00020
[    2.466071] dwc2 20980000.usb: grxfsiz=00001000
[    2.466083] dwc2 20980000.usb: gnptxfsiz=01001000
[    2.466093] dwc2 20980000.usb: hptxfsiz=02002000
[    2.466106] dwc2 20980000.usb: Detected values from hardware:
[    2.466116] dwc2 20980000.usb:   op_mode=0
[    2.466126] dwc2 20980000.usb:   arch=2
[    2.466136] dwc2 20980000.usb:   dma_desc_enable=0
[    2.466146] dwc2 20980000.usb:   power_optimized=0
[    2.466156] dwc2 20980000.usb:   i2c_enable=0
[    2.466165] dwc2 20980000.usb:   hs_phy_type=1
[    2.466175] dwc2 20980000.usb:   fs_phy_type=1
[    2.466185] dwc2 20980000.usb:   utmi_phy_data_width=0
[    2.466194] dwc2 20980000.usb:   num_dev_ep=7
[    2.466204] dwc2 20980000.usb:   num_dev_perio_in_ep=0
[    2.466213] dwc2 20980000.usb:   host_channels=8
[    2.466223] dwc2 20980000.usb:   max_transfer_size=524287
[    2.466233] dwc2 20980000.usb:   max_packet_count=1023
[    2.466243] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
[    2.466253] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
[    2.466263] dwc2 20980000.usb:   dev_token_q_depth=0x8
[    2.466273] dwc2 20980000.usb:   enable_dynamic_fifo=1
[    2.466283] dwc2 20980000.usb:   en_multiple_tx_fifo=1
[    2.466293] dwc2 20980000.usb:   total_fifo_size=4080
[    2.466303] dwc2 20980000.usb:   host_rx_fifo_size=4096
[    2.466314] dwc2 20980000.usb:   host_nperio_tx_fifo_size=256
[    2.466324] dwc2 20980000.usb:   host_perio_tx_fifo_size=512
[    2.466332] dwc2 20980000.usb:
[    2.466342] dwc2 20980000.usb: dwc2_set_parameters()
[    2.466356] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
[    2.466384] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
[    2.466395] dwc2 20980000.usb: Setting hibernation to 0
[    2.466399] dwc2_force_dr_mode()
[    2.473127] dwc2 20980000.usb: Forcing mode to host
[    2.589175] dwc2_hcd_init()
[    2.595685] dwc2 20980000.usb: DWC OTG Controller
[    2.604051] dwc2 20980000.usb: new USB bus registered, assigned bus number 1
[    2.614688] dwc2 20980000.usb: irq 33, io mem 0x00000000
--------------------------------------------------------------------------------

Raspberry Pi Zero
dr_mode = "otg"

Linux raspberrypi 4.7.0-rc7-next-20160719+ #3 Thu Jul 21 17:12:23 UTC 2016
armv6l GNU/Linux

[    2.310924] dwc2_lowlevel_hw_init()
[    2.328029] dwc2 20980000.usb: dwc2: cannot get otg clock
[    2.337385] dwc2_lowlevel_hw_enable()
[    2.344917] dwc2_get_dr_mode()
[    2.469263] dwc2_get_hwparams()
[    2.476042] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
[    2.476059] dwc2 20980000.usb: hwcfg1=00000000
[    2.476072] dwc2 20980000.usb: hwcfg2=228ddd50
[    2.476082] dwc2 20980000.usb: hwcfg3=0ff000e8
[    2.476093] dwc2 20980000.usb: hwcfg4=1ff00020
[    2.476104] dwc2 20980000.usb: grxfsiz=00001000
[    2.476115] dwc2 20980000.usb: Forcing mode to host
[    2.519251] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.519267] dwc2 20980000.usb: hptxfsiz=00000000
[    2.569237] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.569255] dwc2 20980000.usb: Detected values from hardware:
[    2.569266] dwc2 20980000.usb:   op_mode=0
[    2.569276] dwc2 20980000.usb:   arch=2
[    2.569286] dwc2 20980000.usb:   dma_desc_enable=0
[    2.569296] dwc2 20980000.usb:   power_optimized=0
[    2.569306] dwc2 20980000.usb:   i2c_enable=0
[    2.569315] dwc2 20980000.usb:   hs_phy_type=1
[    2.569325] dwc2 20980000.usb:   fs_phy_type=1
[    2.569335] dwc2 20980000.usb:   utmi_phy_data_width=0
[    2.569345] dwc2 20980000.usb:   num_dev_ep=7
[    2.569354] dwc2 20980000.usb:   num_dev_perio_in_ep=0
[    2.569364] dwc2 20980000.usb:   host_channels=8
[    2.569375] dwc2 20980000.usb:   max_transfer_size=524287
[    2.569386] dwc2 20980000.usb:   max_packet_count=1023
[    2.569397] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
[    2.569407] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
[    2.569417] dwc2 20980000.usb:   dev_token_q_depth=0x8
[    2.569427] dwc2 20980000.usb:   enable_dynamic_fifo=1
[    2.569437] dwc2 20980000.usb:   en_multiple_tx_fifo=1
[    2.569447] dwc2 20980000.usb:   total_fifo_size=4080
[    2.569458] dwc2 20980000.usb:   host_rx_fifo_size=4096
[    2.569468] dwc2 20980000.usb:   host_nperio_tx_fifo_size=32
[    2.569478] dwc2 20980000.usb:   host_perio_tx_fifo_size=0
[    2.569487] dwc2 20980000.usb:
[    2.569497] dwc2 20980000.usb: dwc2_set_parameters()
[    2.569511] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
[    2.569535] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
[    2.569547] dwc2 20980000.usb: Setting hibernation to 0
[    2.569573] dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size. Check
HW configuration.
[    2.585354] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
[    2.585361] dwc2_force_dr_mode()
[    2.709215] dwc2_gadget_init()
[    2.715815] dwc2 20980000.usb: NonPeriodic TXFIFO size: 16
[    2.724903] dwc2 20980000.usb: RXFIFO size: 256
[    2.733024] dwc2 20980000.usb: Periodic TXFIFO 0 size: 0
[    2.741929] dwc2 20980000.usb: Periodic TXFIFO 1 size: 256
[    2.750902] dwc2 20980000.usb: Periodic TXFIFO 2 size: 128
[    2.759776] dwc2 20980000.usb: Periodic TXFIFO 3 size: 128
[    2.768438] dwc2 20980000.usb: Periodic TXFIFO 4 size: 64
[    2.776888] dwc2 20980000.usb: Periodic TXFIFO 5 size: 64
[    2.785266] dwc2 20980000.usb: Periodic TXFIFO 6 size: 64
[    2.793496] dwc2 20980000.usb: Periodic TXFIFO 7 size: 32
[    2.801570] dwc2 20980000.usb: Periodic TXFIFO 8 size: 0
[    2.809443] dwc2 20980000.usb: Periodic TXFIFO 9 size: 0
[    2.817055] dwc2 20980000.usb: Periodic TXFIFO10 size: 0
[    2.824633] dwc2 20980000.usb: Periodic TXFIFO11 size: 0
[    2.832100] dwc2 20980000.usb: Periodic TXFIFO12 size: 0
[    2.839457] dwc2 20980000.usb: Periodic TXFIFO13 size: 0
[    2.846659] dwc2 20980000.usb: Periodic TXFIFO14 size: 0
[    2.853852] dwc2 20980000.usb: Periodic TXFIFO15 size: 0
[    2.861043] dwc2 20980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
[    2.887000] dwc2 20980000.usb: bound driver zero
[    2.893565] dwc2_hcd_init()
[    2.898407] dwc2 20980000.usb: DWC OTG Controller
[    2.905079] dwc2 20980000.usb: new USB bus registered, assigned bus number 1
[    2.914160] dwc2 20980000.usb: irq 33, io mem 0x00000000
------------------------------------------------------------------------------

Raspberry Pi Zero
dr_mode = "peripheral"

Linux raspberrypi 4.7.0-rc7-next-20160719+ #3 Thu Jul 21 17:12:23 UTC 2016
armv6l GNU/Linux

[    2.310942] dwc2_lowlevel_hw_init()
[    2.328044] dwc2 20980000.usb: dwc2: cannot get otg clock
[    2.337405] dwc2_lowlevel_hw_enable()
[    2.344937] dwc2_get_dr_mode()
[    2.351820] dwc2 20980000.usb: Forcing mode to device
[    2.469267] dwc2_get_hwparams()
[    2.476052] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
[    2.476067] dwc2 20980000.usb: hwcfg1=00000000
[    2.476078] dwc2 20980000.usb: hwcfg2=228ddd50
[    2.476089] dwc2 20980000.usb: hwcfg3=0ff000e8
[    2.476100] dwc2 20980000.usb: hwcfg4=1ff00020
[    2.476110] dwc2 20980000.usb: grxfsiz=00001000
[    2.476123] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.476135] dwc2 20980000.usb: Detected values from hardware:
[    2.476146] dwc2 20980000.usb:   op_mode=0
[    2.476156] dwc2 20980000.usb:   arch=2
[    2.476166] dwc2 20980000.usb:   dma_desc_enable=0
[    2.476176] dwc2 20980000.usb:   power_optimized=0
[    2.476186] dwc2 20980000.usb:   i2c_enable=0
[    2.476196] dwc2 20980000.usb:   hs_phy_type=1
[    2.476206] dwc2 20980000.usb:   fs_phy_type=1
[    2.476216] dwc2 20980000.usb:   utmi_phy_data_width=0
[    2.476225] dwc2 20980000.usb:   num_dev_ep=7
[    2.476235] dwc2 20980000.usb:   num_dev_perio_in_ep=0
[    2.476245] dwc2 20980000.usb:   host_channels=8
[    2.476256] dwc2 20980000.usb:   max_transfer_size=524287
[    2.476266] dwc2 20980000.usb:   max_packet_count=1023
[    2.476277] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
[    2.476288] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
[    2.476297] dwc2 20980000.usb:   dev_token_q_depth=0x8
[    2.476308] dwc2 20980000.usb:   enable_dynamic_fifo=1
[    2.476318] dwc2 20980000.usb:   en_multiple_tx_fifo=1
[    2.476328] dwc2 20980000.usb:   total_fifo_size=4080
[    2.476338] dwc2 20980000.usb:   host_rx_fifo_size=4096
[    2.476349] dwc2 20980000.usb:   host_nperio_tx_fifo_size=0
[    2.476359] dwc2 20980000.usb:   host_perio_tx_fifo_size=0
[    2.476368] dwc2 20980000.usb:
[    2.476378] dwc2 20980000.usb: dwc2_set_parameters()
[    2.476391] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
[    2.476418] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
[    2.476429] dwc2 20980000.usb: Setting hibernation to 0
[    2.476449] dwc2 20980000.usb: 0 invalid for host_rx_fifo_size. Check HW
configuration.
[    2.491704] dwc2 20980000.usb: Setting host_rx_fifo_size to 4096
[    2.491727] dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size. Check
HW configuration.
[    2.507853] dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
[    2.507875] dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size. Check
HW configuration.
[    2.524246] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
[    2.524252] dwc2_force_dr_mode()
[    2.531473] dwc2 20980000.usb: Forcing mode to device
[    2.649220] dwc2_gadget_init()
[    2.656183] dwc2 20980000.usb: NonPeriodic TXFIFO size: 16
[    2.665634] dwc2 20980000.usb: RXFIFO size: 256
[    2.674009] dwc2 20980000.usb: Periodic TXFIFO 0 size: 0
[    2.683076] dwc2 20980000.usb: Periodic TXFIFO 1 size: 256
[    2.692256] dwc2 20980000.usb: Periodic TXFIFO 2 size: 128
[    2.701280] dwc2 20980000.usb: Periodic TXFIFO 3 size: 128
[    2.710152] dwc2 20980000.usb: Periodic TXFIFO 4 size: 64
[    2.718734] dwc2 20980000.usb: Periodic TXFIFO 5 size: 64
[    2.727175] dwc2 20980000.usb: Periodic TXFIFO 6 size: 64
[    2.735545] dwc2 20980000.usb: Periodic TXFIFO 7 size: 32
[    2.743812] dwc2 20980000.usb: Periodic TXFIFO 8 size: 0
[    2.751878] dwc2 20980000.usb: Periodic TXFIFO 9 size: 0
[    2.759850] dwc2 20980000.usb: Periodic TXFIFO10 size: 0
[    2.767724] dwc2 20980000.usb: Periodic TXFIFO11 size: 0
[    2.775557] dwc2 20980000.usb: Periodic TXFIFO12 size: 0
[    2.783321] dwc2 20980000.usb: Periodic TXFIFO13 size: 0
[    2.791008] dwc2 20980000.usb: Periodic TXFIFO14 size: 0
[    2.798604] dwc2 20980000.usb: Periodic TXFIFO15 size: 0
[    2.806106] dwc2 20980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
[    2.832686] dwc2 20980000.usb: bound driver zero
