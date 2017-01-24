From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 24 Jan 2017 16:14:07 +0100
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
Message-ID: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the UVC gadget with configfs and then reloading UDC controler driver
(pxa27x_udc) causes kernel to fail.

UDC subsystem was patched only in decreasing maxpacket size for UVC, addition
of more predefined endpoints for pxa27x_udc and addition of some debugging pr_info.

Practically same behaviour was observed on 4.7.0 too.

Script:

modprobe udc-core
modprobe pxa27x-udc
modprobe libcomposite
modprobe usb_f_uvc

mkdir -p /tmp/udc
cd /tmp/udc

mount none /tmp/udc -t configfs
mkdir -p usb_gadget/gcam

cd usb_gadget/gcam
mkdir -p configs/c.1

mkdir -p functions/uvc.usb0
mkdir -p strings/0x409
mkdir -p configs/c.1/strings/0x409

echo 0x1d6b > idVendor
echo 0x0102 > idProduct
echo 16 > bMaxPacketSize0
echo "Magician" > strings/0x409/serialnumber
echo "Linux Foundation" > strings/0x409/manufacturer
echo "Webcam/EEM" > strings/0x409/product
echo "Video" > configs/c.1/strings/0x409/configuration
echo 239 > bDeviceClass
echo 2 > bDeviceSubClass
echo 1 > bDeviceProtocol
echo 500 > configs/c.1/MaxPower
echo 0xc0 > configs/c.1/bmAttributes

mkdir -p functions/uvc.usb0/streaming/mjpeg/m/240p
cat <<EOF > functions/uvc.usb0/streaming/mjpeg/m/240p/dwFrameInterval
666666
1000000
5000000
EOF
echo "320" > functions/uvc.usb0/streaming/mjpeg/m/240p/wWidth 
echo "240" > functions/uvc.usb0/streaming/mjpeg/m/240p/wHeight
echo "2000000" >  functions/uvc.usb0/streaming/mjpeg/m/240p/dwDefaultFrameInterval

mkdir -p functions/uvc.usb0/streaming/header/h
cd functions/uvc.usb0/streaming/header/h
ln -s ../../mjpeg/m
cd ../../class/fs
ln -s ../../header/h

cd ../../class/hs
ln -s ../../header/h

cd ../../../control
mkdir header/h
ln -s header/h class/fs

ln -s header/h class/ss

cd ../../../
ln -s functions/uvc.usb0 configs/c.1

echo pxa27x-udc > UDC

rmmod pxa27x_udc

modprobe pxa27x_udc
	Segmentation fault

dmesg
	configfs-gadget gadget: uvc_unbind
	configfs-gadget gadget: uvc_function_bind
	kobject (c2902870): tried to init an initialized object, something is seriously wrong.
	CPU: 0 PID: 340 Comm: modprobe Not tainted 4.10.0-rc5+ #1
	Hardware name: HTC Magician
	[<c000edcc>] (unwind_backtrace) from [<c000cb6c>] (show_stack+0x10/0x14)
	[<c000cb6c>] (show_stack) from [<c01d15a0>] (kobject_init+0x74/0x94)
	[<c01d15a0>] (kobject_init) from [<c02467e8>] (device_initialize+0x20/0x9c)
	[<c02467e8>] (device_initialize) from [<c0248970>] (device_register+0xc/0x18)
	[<c0248970>] (device_register) from [<bf143360>] (__video_register_device+0xdd0/0x1684 [videodev])
	[<bf143360>] (__video_register_device [videodev]) from [<bf5bfc24>] (uvc_function_bind+0x324/0x470 [usb_f_uvc])
	[<bf5bfc24>] (uvc_function_bind [usb_f_uvc]) from [<bf5a8974>] (usb_add_function+0x70/0x1bc [libcomposite])
	[<bf5a8974>] (usb_add_function [libcomposite]) from [<bf5ac2ac>] (configfs_composite_bind+0x224/0x320 [libcomposite])
	[<bf5ac2ac>] (configfs_composite_bind [libcomposite]) from [<bf593640>] (udc_bind_to_driver+0x34/0xf8 [udc_core])
	[<bf593640>] (udc_bind_to_driver [udc_core]) from [<bf593f10>] (usb_add_gadget_udc_release+0x190/0x23c [udc_core])
	[<bf593f10>] (usb_add_gadget_udc_release [udc_core]) from [<bf5d3790>] (pxa_udc_probe+0x238/0x320 [pxa27x_udc])
	[<bf5d3790>] (pxa_udc_probe [pxa27x_udc]) from [<c024c9f8>] (platform_drv_probe+0x38/0x94)
	[<c024c9f8>] (platform_drv_probe) from [<c024b02c>] (driver_probe_device+0x230/0x420)
	[<c024b02c>] (driver_probe_device) from [<c024b300>] (__driver_attach+0xe4/0xf8)
	[<c024b300>] (__driver_attach) from [<c02494d4>] (bus_for_each_dev+0x58/0x88)
	[<c02494d4>] (bus_for_each_dev) from [<c024a4f0>] (bus_add_driver+0x148/0x234)
	[<c024a4f0>] (bus_add_driver) from [<c024bbbc>] (driver_register+0x78/0xf4)
	[<c024bbbc>] (driver_register) from [<c00096a4>] (do_one_initcall+0x48/0x19c)
	[<c00096a4>] (do_one_initcall) from [<c00680b0>] (do_init_module+0x54/0x37c)
	[<c00680b0>] (do_init_module) from [<c0062794>] (load_module+0x1c98/0x1f6c)
	[<c0062794>] (load_module) from [<c0062c4c>] (SyS_finit_module+0x88/0xbc)
	[<c0062c4c>] (SyS_finit_module) from [<c000a420>] (ret_fast_syscall+0x0/0x38)
	Unable to handle kernel paging request at virtual address bf5a0718
	pgd = c28dc000
	[bf5a0718] *pgd=a28b8811, *pte=00000000, *ppte=00000000
	Internal error: Oops: 7 [#1] ARM
	Modules linked in: pxa27x_udc(+) usb_f_uvc videobuf2_vmalloc libcomposite udc_core ppp_deflate zlib_inflate zlib_deflate bsd_comp ppp_async ppp_generic slhc ircomm_tty ircomm configfs btusb btintel bluetooth firmware_class ads7846 max1586 pxaficp_ir soc_mediabus ohci_pxa27x irda ohci_hcd fixed snd_soc_pxa2xx spi_pxa2xx_platform snd_pxa2xx_lib snd_pcm_dmaengine snd_soc_pxa_ssp videobuf2_dma_sg usbcore snd_soc_core videobuf2_memops v4l2_common videobuf2_v4l2 i2c_pxa pwm_bl videodev backlight snd_pcm videobuf2_core usb_common snd_timer pwm_pxa i2c_core snd ssp rtc_pxa rtc_sa1100 soundcore leds_gpio htc_pasic3 led_class mfd_core pda_power [last unloaded: pxa27x_udc]
	CPU: 0 PID: 340 Comm: modprobe Not tainted 4.10.0-rc5+ #1
	Hardware name: HTC Magician
	task: c3b40c00 task.stack: c33fc000
	PC is at kobject_get+0x10/0xa4
	LR is at get_device+0x14/0x1c
	pc : [<c01d16b8>]    lr : [<c02461a8>]    psr: a0000013
	sp : c33fdbb8  ip : 00000000  fp : 00000001
	r10: bf15a920  r9 : 000001bc  r8 : bf15ad20
	r7 : c04f900c  r6 : 00000000  r5 : c2902868  r4 : bf5a06f8
	r3 : c2971580  r2 : 00000000  r1 : c04730a8  r0 : bf5a06f8
	Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
	Control: 0000397f  Table: a28dc000  DAC: 00000051
	Process modprobe (pid: 340, stack limit = 0xc33fc198)
	Stack: (0xc33fdbb8 to 0xc33fe000)
	dba0:                                                       bf152ee8 bf15ad20
	dbc0: c2902868 c02461a8 c2971580 c0248370 00000000 00000000 00000001 c003bb2c
	dbe0: c2902868 2ce51e4e c2902868 c2902860 c2902868 00000000 bf152ee8 bf15ad20
	...
	dfe0: bee048a8 bee04898 00016490 b6e33020 60000010 00000003 00000000 00000000
	[<c01d16b8>] (kobject_get) from [<c02461a8>] (get_device+0x14/0x1c)
	[<c02461a8>] (get_device) from [<c0248370>] (device_add+0xa4/0x550)
	[<c0248370>] (device_add) from [<bf143360>] (__video_register_device+0xdd0/0x1684 [videodev])
	[<bf143360>] (__video_register_device [videodev]) from [<bf5bfc24>] (uvc_function_bind+0x324/0x470 [usb_f_uvc])
	[<bf5bfc24>] (uvc_function_bind [usb_f_uvc]) from [<bf5a8974>] (usb_add_function+0x70/0x1bc [libcomposite])
	[<bf5a8974>] (usb_add_function [libcomposite]) from [<bf5ac2ac>] (configfs_composite_bind+0x224/0x320 [libcomposite])
	[<bf5ac2ac>] (configfs_composite_bind [libcomposite]) from [<bf593640>] (udc_bind_to_driver+0x34/0xf8 [udc_core])
	[<bf593640>] (udc_bind_to_driver [udc_core]) from [<bf593f10>] (usb_add_gadget_udc_release+0x190/0x23c [udc_core])
	[<bf593f10>] (usb_add_gadget_udc_release [udc_core]) from [<bf5d3790>] (pxa_udc_probe+0x238/0x320 [pxa27x_udc])
	[<bf5d3790>] (pxa_udc_probe [pxa27x_udc]) from [<c024c9f8>] (platform_drv_probe+0x38/0x94)
	[<c024c9f8>] (platform_drv_probe) from [<c024b02c>] (driver_probe_device+0x230/0x420)
	[<c024b02c>] (driver_probe_device) from [<c024b300>] (__driver_attach+0xe4/0xf8)
	[<c024b300>] (__driver_attach) from [<c02494d4>] (bus_for_each_dev+0x58/0x88)
	[<c02494d4>] (bus_for_each_dev) from [<c024a4f0>] (bus_add_driver+0x148/0x234)
	[<c024a4f0>] (bus_add_driver) from [<c024bbbc>] (driver_register+0x78/0xf4)
	[<c024bbbc>] (driver_register) from [<c00096a4>] (do_one_initcall+0x48/0x19c)
	[<c00096a4>] (do_one_initcall) from [<c00680b0>] (do_init_module+0x54/0x37c)
	[<c00680b0>] (do_init_module) from [<c0062794>] (load_module+0x1c98/0x1f6c)
	[<c0062794>] (load_module) from [<c0062c4c>] (SyS_finit_module+0x88/0xbc)
	[<c0062c4c>] (SyS_finit_module) from [<c000a420>] (ret_fast_syscall+0x0/0x38)
	Code: e92d4010 e2504000 e24dd008 0a00000b (e5d43020) 
	---[ end trace 113e46a0092a6b29 ]---
