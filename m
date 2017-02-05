From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 6 Feb 2017 00:01:30 +0100
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
In-Reply-To: <87shnt1sue.fsf@belgarion.home>
References: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
 <87shnt1sue.fsf@belgarion.home>
Message-ID: <1812a959-f4e7-3b40-e8f5-0a068576a537@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 4.2.2017 v 23:42 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Setting the UVC gadget with configfs and then reloading UDC controler driver
>> (pxa27x_udc) causes kernel to fail.
>>
>> UDC subsystem was patched only in decreasing maxpacket size for UVC, addition
>> of more predefined endpoints for pxa27x_udc and addition of some debugging pr_info.
>>
>> Practically same behaviour was observed on 4.7.0 too.
> Hi Petr,
> 
> If you could provide me your "debug patch" for the new endpoints, packet size
> and pr_infos, I could try to reproduce on my platform and have a look.
> 

Sent it in the attachment, along with the belonging error log and a script to reproduce.

Not all patched parts (UDC+webcam) are probably necessary as the failure can be reproduced
without using webcam at all. Warning: patch is probably dirty formatted (I tried to
clean it a little bit, but still ...). Patch is from vanilla kernel (4.10.0-rc5) at commit:

	a4685d2f58e2230d4e27fb2ee581d7ea35e5d046 

Failure starts after last:

	modprobe pxa27x_udc

which is commented in the script. Modprobe command fails with:

	Segmentation fault

> I must say that I'm not familiar with uvc, so I can only suppose you're trying
> to stream the magician camera to USB to "act" like a Webcam, is it what you're
> trying to achieve ?

Exactly! With USB 1.1 there is little bit problem with bandwidth for raw YUV :-), but
JPEG 320x240 is fine (although I had to patch UVC function and g_webcam). UVC gadget requires
userspace part of driver. I heavily changed one from there (to sends the images from filesystem),
but it is not required to reproduce the error:

	http://git.ideasonboard.org/uvc-gadget.git

With the configfs method this userspace driver does not work, but it cannot be properly debugged
unless gadget driver/kernel oopses after reload.

Petr 

> 
> Cheers.
> 
> --
> Robert
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-PXA27x-UDC-more-endpoints-for-more-gadgets-UVC-gadge.patch
Type: text/x-patch
Size: 13988 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/345cdad4/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: uvc_failure_kernel.log
Type: text/x-log
Size: 10405 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/345cdad4/attachment-0003.bin>
-------------- next part --------------
#!/bin/sh
rm -r /tmp/udc/usb_gadget/
rm -r /tmp/udc/usb_gadget/
rm -r /tmp/udc/usb_gadget/
umount /tmp/udc

rmmod usb_f_eem g_ether usb_f_rndis u_ether
rmmod usb_f_eem g_ether usb_f_rndis u_ether
rmmod usb_f_eem g_ether usb_f_rndis u_ether
rmmod usb_f_eem g_ether usb_f_rndis u_ether
rmmod usb_f_uvc libcomposite pxa27x_udc udc_core
rmmod usb_f_uvc libcomposite pxa27x_udc udc_core




modprobe udc-core
modprobe pxa27x-udc
modprobe libcomposite
modprobe usb_f_uvc

mkdir -p /tmp/udc
cd /tmp/udc

mount none /tmp/udc -t configfs
sleep 1
mkdir -p /tmp/udc/usb_gadget/gcam
sleep 1
cd /tmp/udc/usb_gadget/gcam
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

#modprobe pxa27x_udc
