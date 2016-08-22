From: John.Youn@synopsys.com (John Youn)
Date: Mon, 22 Aug 2016 13:06:11 -0700
Subject: [Bug] usb: dwc2: host function broken in OTG mode on bcm283x
In-Reply-To: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
References: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
Message-ID: <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/20/2016 6:03 AM, Stefan Wahren wrote:
> Hi John,
> 
> on bcm2835 in OTG mode the USB host function broken (USB devices don't
> enumerate) with the following settings:
> 
> CONFIG_USB=y
> CONFIG_USB_OTG=y
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_DUAL_ROLE=y
> CONFIG_USB_PHY=y
> CONFIG_NOP_USB_XCEIV=y
> CONFIG_USB_GADGET=y
> CONFIG_USB_ZERO=y
> 
> and DT don't provide any optional gadget fifo settings. During boot the kernel
> give a warning about insufficient fifo memory.
> 
> Here is the relevant log with some debug messages:
> 
> [    2.373718] dwc2_lowlevel_hw_init()
> [    2.389306] dwc2_set_all_params()
> [    2.404927] dwc2_lowlevel_hw_enable()
> [    2.420331] dwc2_get_dr_mode()
> [    2.434894] dwc2_get_dr_mode: OF suggests 3
> [    2.450592] dwc2_get_dr_mode: No PHY found
> [    2.466161] dwc2_core_reset_and_force_dr_mode()
> [    2.517779] mmc0: new SDHC card at address 1234
> [    2.535005] mmcblk0: mmc0:1234 SA32G 29.3 GiB
> [    2.553421]  mmcblk0: p1 p2
> [    2.619213] dwc2_get_hwparams()
> [    2.633611] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
> [    2.633628] dwc2 20980000.usb: hwcfg1=00000000
> [    2.633640] dwc2 20980000.usb: hwcfg2=228ddd50
> [    2.633651] dwc2 20980000.usb: hwcfg3=0ff000e8
> [    2.633663] dwc2 20980000.usb: hwcfg4=1ff00020
> [    2.633674] dwc2 20980000.usb: grxfsiz=00001000
> [    2.633688] dwc2 20980000.usb: gnptxfsiz=01001000
> [    2.633698] dwc2 20980000.usb: hptxfsiz=02002000
> [    2.633710] dwc2 20980000.usb: Forcing mode to device
> [    2.679241] dwc2 20980000.usb: gnptxfsiz=01001000
> [    2.729220] dwc2 20980000.usb: Detected values from hardware:
> [    2.729237] dwc2 20980000.usb:   op_mode=0
> [    2.729249] dwc2 20980000.usb:   arch=2
> [    2.729259] dwc2 20980000.usb:   dma_desc_enable=0
> [    2.729271] dwc2 20980000.usb:   power_optimized=0
> [    2.729285] dwc2 20980000.usb:   i2c_enable=0
> [    2.729294] dwc2 20980000.usb:   hs_phy_type=1
> [    2.729305] dwc2 20980000.usb:   fs_phy_type=1
> [    2.729315] dwc2 20980000.usb:   utmi_phy_data_width=0
> [    2.729325] dwc2 20980000.usb:   num_dev_ep=7
> [    2.729335] dwc2 20980000.usb:   num_dev_perio_in_ep=0
> [    2.729345] dwc2 20980000.usb:   host_channels=8
> [    2.729356] dwc2 20980000.usb:   max_transfer_size=524287
> [    2.729367] dwc2 20980000.usb:   max_packet_count=1023
> [    2.729377] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
> [    2.729387] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
> [    2.729398] dwc2 20980000.usb:   dev_token_q_depth=0x8
> [    2.729408] dwc2 20980000.usb:   enable_dynamic_fifo=1
> [    2.729418] dwc2 20980000.usb:   en_multiple_tx_fifo=1
> [    2.729429] dwc2 20980000.usb:   total_fifo_size=4080
> [    2.729439] dwc2 20980000.usb:   host_rx_fifo_size=4096
> [    2.729450] dwc2 20980000.usb:   host_nperio_tx_fifo_size=256
> [    2.729461] dwc2 20980000.usb:   host_perio_tx_fifo_size=512
> [    2.729469] dwc2 20980000.usb:
> [    2.729474] dwc2_set_parameters()
> [    2.743824] dwc2 20980000.usb: dwc2_set_parameters()
> [    2.743848] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
> [    2.743881] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
> [    2.743895] dwc2 20980000.usb: Setting hibernation to 0
> [    2.743899] dwc2_force_dr_mode()
> [    2.869216] dwc2_gadget_init()
> [    2.883027] dwc2 20980000.usb: Specified GNPTXFDEP=1024 > 256
> [    2.899480] dwc2 20980000.usb: NonPeriodic TXFIFO size: 256
> [    2.899497] dwc2 20980000.usb: RXFIFO size: 2048
> [    2.899511] dwc2 20980000.usb: Periodic TXFIFO 0 size: 0
> [    2.899523] dwc2 20980000.usb: Periodic TXFIFO 1 size: 256
> [    2.899536] dwc2 20980000.usb: Periodic TXFIFO 2 size: 256
> [    2.899547] dwc2 20980000.usb: Periodic TXFIFO 3 size: 256
> [    2.899559] dwc2 20980000.usb: Periodic TXFIFO 4 size: 256
> [    2.899572] dwc2 20980000.usb: Periodic TXFIFO 5 size: 768
> [    2.899584] dwc2 20980000.usb: Periodic TXFIFO 6 size: 768
> [    2.899595] dwc2 20980000.usb: Periodic TXFIFO 7 size: 768
> [    2.899607] dwc2 20980000.usb: Periodic TXFIFO 8 size: 768
> [    2.899619] dwc2 20980000.usb: Periodic TXFIFO 9 size: 0
> [    2.899630] dwc2 20980000.usb: Periodic TXFIFO10 size: 0
> [    2.899640] dwc2 20980000.usb: Periodic TXFIFO11 size: 0
> [    2.899652] dwc2 20980000.usb: Periodic TXFIFO12 size: 0
> [    2.899662] dwc2 20980000.usb: Periodic TXFIFO13 size: 0
> [    2.899674] dwc2 20980000.usb: Periodic TXFIFO14 size: 0
> [    2.899686] dwc2 20980000.usb: Periodic TXFIFO15 size: 0
> [    2.899720] dwc2 20980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
> [    2.918197] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
> [    2.935109] zero gadget: zero ready
> [    2.949235] ------------[ cut here ]------------
> [    2.964357] WARNING: CPU: 0 PID: 6 at drivers/usb/dwc2/gadget.c:227
> dwc2_hsotg_init_fifo+0xd0/0x1ac
> [    2.984089] insufficient fifo memory
> [    2.987649] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted
> 4.7.0-rc7-next-20160719+ #29
> [    3.016940] Hardware name: BCM2835
> [    3.031145] Workqueue: deferwq deferred_probe_work_func
> [    3.047436] [<c010e480>] (unwind_backtrace) from [<c010b97c>]
> (show_stack+0x20/0x24)
> [    3.066350] [<c010b97c>] (show_stack) from [<c035dc54>]
> (dump_stack+0x20/0x28)
> [    3.084726] [<c035dc54>] (dump_stack) from [<c011c96c>] (__warn+0xe0/0x10c)
> [    3.102866] [<c011c96c>] (__warn) from [<c011c9e0>]
> (warn_slowpath_fmt+0x48/0x50)
> [    3.121564] [<c011c9e0>] (warn_slowpath_fmt) from [<c0480cd0>]
> (dwc2_hsotg_init_fifo+0xd0/0x1ac)
> [    3.141678] [<c0480cd0>] (dwc2_hsotg_init_fifo) from [<c0483f18>]
> (dwc2_hsotg_udc_start+0x1e4/0x2b8)
> [    3.162222] [<c0483f18>] (dwc2_hsotg_udc_start) from [<c0490a40>]
> (udc_bind_to_driver+0x60/0x108)
> [    3.182462] [<c0490a40>] (udc_bind_to_driver) from [<c04913d8>]
> (usb_add_gadget_udc_release+0x144/0x244)
> [    3.203338] [<c04913d8>] (usb_add_gadget_udc_release) from [<c0491578>]
> (usb_add_gadget_udc+0x1c/0x20)
> [    3.224024] [<c0491578>] (usb_add_gadget_udc) from [<c0484f90>]
> (dwc2_gadget_init+0x460/0x4f8)
> [    3.244022] [<c0484f90>] (dwc2_gadget_init) from [<c0474698>]
> (dwc2_driver_probe+0x360/0x4bc)
> [    3.264058] [<c0474698>] (dwc2_driver_probe) from [<c040236c>]
> (platform_drv_probe+0x68/0xb0)
> [    3.284186] [<c040236c>] (platform_drv_probe) from [<c0400b2c>]
> (driver_probe_device+0x180/0x42c)
> [    3.304727] [<c0400b2c>] (driver_probe_device) from [<c04010e0>]
> (__device_attach_driver+0xc0/0x108)
> [    3.325628] [<c04010e0>] (__device_attach_driver) from [<c03ff1e8>]
> (bus_for_each_drv+0x5c/0xa4)
> [    3.346260] [<c03ff1e8>] (bus_for_each_drv) from [<c04007ec>]
> (__device_attach+0x9c/0x138)
> [    3.366460] [<c04007ec>] (__device_attach) from [<c0401164>]
> (device_initial_probe+0x1c/0x20)
> [    3.386971] [<c0401164>] (device_initial_probe) from [<c03ff3fc>]
> (bus_probe_device+0x38/0x90)
> [    3.407720] [<c03ff3fc>] (bus_probe_device) from [<c0400218>]
> (deferred_probe_work_func+0x5c/0xa4)
> [    3.429054] [<c0400218>] (deferred_probe_work_func) from [<c0130e28>]
> (process_one_work+0x1d0/0x37c)
> [    3.450717] [<c0130e28>] (process_one_work) from [<c01312a8>]
> (worker_thread+0x294/0x414)
> [    3.471563] [<c01312a8>] (worker_thread) from [<c01363e4>]
> (kthread+0xec/0x100)
> [    3.491662] [<c01363e4>] (kthread) from [<c01080f8>]
> (ret_from_fork+0x14/0x3c)
> [    3.511770] ---[ end trace 00841c75e25fed43 ]---
> [    3.532627] dwc2 20980000.usb: bound driver zero
> ...
> [    4.092616] dwc2_hcd_init()
> [    4.108117] dwc2 20980000.usb: DWC OTG Controller
> [    4.125318] dwc2 20980000.usb: new USB bus registered, assigned bus number 1
> [    4.144876] dwc2 20980000.usb: irq 33, io mem 0x00000000
> [    4.164367] hub 1-0:1.0: USB hub found
> [    4.180746] hub 1-0:1.0: 1 port detected
> 
> Since there are no gadget fifo sizes specified the dwc2 drivers uses legacy
> settings.
> 
> I think there are 2 causes for this warning:
> 
> 1. The array behind DWC2_G_P_LEGACY_TX_FIFO_SIZE specify 8 values plus the
> separate ep0 which makes in sum 9 EPs. So dwc2_hsotg_init_fifo tries to setup 9
> EPs with legacy settings. But bcm2835 only support 8 EPs. I don't know of any
> platform with less EPs. 
> 
> 2. The legacy settings for gadget are to high. They need to be adjusted to the
> "smallest" platform.
> 
> Here is a patch which fixes the problem (USB devices enumerate and warning
> disappear) for me:
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 9fae029..289ad3c 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -263,8 +263,8 @@ enum dwc2_lx_state {
>   * Gadget periodic tx fifo sizes as used by legacy driver
>   * EP0 is not included
>   */
> -#define DWC2_G_P_LEGACY_TX_FIFO_SIZE {256, 256, 256, 256, 768, 768, 768, \
> -					   768, 0, 0, 0, 0, 0, 0, 0}
> +#define DWC2_G_P_LEGACY_TX_FIFO_SIZE {256, 128, 128, 64, 64, 64, 64, \
> +					   0, 0, 0, 0, 0, 0, 0, 0}
>  
>  /* Gadget ep0 states */
>  enum dwc2_ep0_state {
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index af46adf..2d0bc2a 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -3868,8 +3868,8 @@ int dwc2_gadget_init(struct dwc2_hsotg *hsotg, int irq)
>  	u32 p_tx_fifo[] = DWC2_G_P_LEGACY_TX_FIFO_SIZE;
>  
>  	/* Initialize to legacy fifo configuration values */
> -	hsotg->g_rx_fifo_sz = 2048;
> -	hsotg->g_np_g_tx_fifo_sz = 1024;
> +	hsotg->g_rx_fifo_sz = 256;
> +	hsotg->g_np_g_tx_fifo_sz = 128;
>  	memcpy(&hsotg->g_tx_fifo_sz[1], p_tx_fifo, sizeof(p_tx_fifo));
>  	/* Device tree specific probe */
>  	dwc2_hsotg_of_probe(hsotg);
> 

Hi Stefan,

Why doesn't DT work? I think all the properties are there to set
these.

I hesitate to change the legacy/default settings in case it breaks any
existing drivers that depend on them.

Regards,
John
