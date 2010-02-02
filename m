From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 2 Feb 2010 09:22:58 -0500
Subject: [PATCH 1/4] mfd: update i2c driver for max8925
In-Reply-To: <20100129195405.GB23130@sortiz.org>
References: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
	<20100129195405.GB23130@sortiz.org>
Message-ID: <771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 2:54 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> This has to be rewritten, but first let me try to understand something: You
> need the max9825 core to have pointers to the other i2c devices because of how
> it handles IRQs right ? In your max9825 irq handler you need to be able to
> access the rtc and the adc devices, right ? And then on yourrtc and power
> drivers, you actually only access the max8925 core i2c registers ?
> I would appreciate if most of your answers to those questions could morph into
> code comments to this probe routine.
>
> Then, about the code design: Having your probe routine relying on those static
> variable is not ok. If I undersand you correctly, what you trying to achieve
> here is not calling max8925_device_init() before you actually have the core,
> the i2c and the adc pointer setup ?
> If that's so, why not simply use i2c_new_dummy() instead of having to handle
> recursive calls of your probe routine ?
>

I wants to initialize max8925 after all three components probed. In
core driver, irq handling needs to access all three components. In
power supply driver, both adc and generic components are accessed.
It's the reason that using three i2c clients in one driver.

Yes, the code is not very clear. Now I use i2c_new_dummy() now. Now I
attache new patches now.

Updates are in below.
1. use i2c_new_dummy() to replace i2c_new_probed_device().
2. add onkey driver
3. remove unused i2c pointer in rtc driver

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-update-i2c-driver-for-max8925.patch
Type: text/x-patch
Size: 3590 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/ef1c8d48/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mfd-update-irq-handler-in-max8925.patch
Type: text/x-patch
Size: 29175 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/ef1c8d48/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-rtc-enable-rtc-in-max8925.patch
Type: text/x-patch
Size: 10219 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/ef1c8d48/attachment-0007.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-power-enable-power-supply-of-max8925.patch
Type: text/x-patch
Size: 16348 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/ef1c8d48/attachment-0008.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-input-enable-onkey-driver-of-max8925.patch
Type: text/x-patch
Size: 5956 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/ef1c8d48/attachment-0009.bin>
