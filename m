From: john.stultz@linaro.org (John Stultz)
Date: Tue, 5 Jul 2016 12:33:50 -0700
Subject: [PATCH 00/21] Support qcom's HSIC USB and rewrite USB2 HS phy
 support
In-Reply-To: <146774653916.32648.3323628902201136171@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <CALAqxLUHfsJBTQS=p5oThnOdiAZwu48puRhREx+2G9+KajDA9g@mail.gmail.com>
 <146710289677.3879.15364764209076318827@sboyd-linaro>
 <CALAqxLW--yFb2YwX3+x7PB-g_5D0gb6j8CiJwnCC+meb7xqbig@mail.gmail.com>
 <146774653916.32648.3323628902201136171@sboyd-linaro>
Message-ID: <CALAqxLUi9_OnqU06Vsa_VxmtYof9+me3p5eTn_fK3O=J1Zhtzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 12:22 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Quoting John Stultz (2016-07-01 23:03:38)
>> On Tue, Jun 28, 2016 at 1:34 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
>> > Quoting John Stultz (2016-06-27 20:09:30)
>> >>
>> >> I haven't yet been able to test with this, as I need some other fixes
>> >> it seems too to deal with some of the iommu changes in my flo-WIP tree
>> >> (it can't find of_dma_configure), but will let you know how things
>> >> work once I have all that sorted.
>> >
>> > Cool, thanks for testing.
>>
>> So after working out some merge issues w/ my flo-WIP branch for the
>> nexus7, I was still having trouble, so I backed out to just your
>> (updated) branch.
>>
>> But even there, I'm not able to get the usb gadget up. I see:
>
> I can get the gadget working on the ifc6410 device I have. I'm using
> this script to test things:
>
> modprobe libcomposite
> mkdir config
> mount none config -t configfs
> mkdir config/usb_gadget/g1
> mkdir config/usb_gadget/g1/strings/0x409
> echo 012345678 > config/usb_gadget/g1/strings/0x409/serialnumber
> echo "manufacturer" > config/usb_gadget/g1/strings/0x409/manufacturer
> echo "db8074" > config/usb_gadget/g1/strings/0x409/product
> echo 0x1d6b > config/usb_gadget/g1/idVendor
> echo 0x0104 > config/usb_gadget/g1/idProduct
> mkdir config/usb_gadget/g1/functions/acm.GS0
> mkdir config/usb_gadget/g1/functions/acm.GS1
> mkdir config/usb_gadget/g1/functions/ecm.usb0
> mkdir config/usb_gadget/g1/configs/c.1
> mkdir config/usb_gadget/g1/configs/c.1/strings/0x409/
> echo "CDC 2xACM+ECM" >
> config/usb_gadget/g1/configs/c.1/strings/0x409/configuration
> ln -s config/usb_gadget/g1/functions/acm.GS0
> config/usb_gadget/g1/configs/c.1
> ln -s config/usb_gadget/g1/functions/acm.GS1
> config/usb_gadget/g1/configs/c.1
> ln -s config/usb_gadget/g1/functions/ecm.usb0
> config/usb_gadget/g1/configs/c.1
> echo $(ls /sys/class/udc/) > config/usb_gadget/g1/UDC
>
>>
>> [    1.869717] msm_hsusb 12500000.usb: failed to get phandle in
>> /soc/usb at 12500000 node
>
> This is sort of ok (I've seen it before with the HSIC controller on
> 8074). The extcon is optional and so the error message should be
> silenced. I sent a patch to move it to debug level.
>
> I don't see an extcon in mainline for apq8064, but I think it may be
> needed. At the least, I see that we're using a PMIC interrupt in the
> msm-3.4 kernel for the ID pin and the charger is notifying of vbus
> events similar to how smbb is doing it for apq8074.
>
>> [    1.882347] 12500000.usb supply vbus not found, using dummy regulator
>
> This is not great. We don't have a regulator specified on apq8064 so we
> can't turn on vbus and really support host mode. This seems to already
> be the case on mainline though, so it's not like we're any worse here.
> To properly support this we need a regulator driver. I suppose if the
> RPM supports it we can just use that, but if it doesn't support this
> regulator then we need to port over the SSBI regulator driver to do
> native regulator control. So far I haven't been able to test host mode
> on apq8064 because of this.
>
>>
>> So I'm not sure if the dts changes were quite right. I've got all the
>> ULPI configs enabled. Any ideas?
>>
>
> The phy and controller are both probing? If they're not failing to probe
> then it's probably the phy that isn't working properly. Does gadget work
> without my patches on nexus7?

Without your patch, I need one dts tweak on nexus7 (which I sent out
on friday[1]) to get the default direction set to OTG or gadget. But
yea, it works with that against mainline.

I'll dig in some more on your suggestions above and let you know if I
figure it out.

thanks
-john

[1]: http://www.spinics.net/lists/devicetree/msg134274.html
