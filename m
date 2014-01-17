From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jan 2014 11:14:56 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAGb2v640Qeb60dMq2kH6M6NqkVbdUh1JcCus3a7D7icQeDdKNg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
 <CAGb2v640Qeb60dMq2kH6M6NqkVbdUh1JcCus3a7D7icQeDdKNg@mail.gmail.com>
Message-ID: <20140117101456.GD2348@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 06:06:41PM +0800, Chen-Yu Tsai wrote :
> On Fri, Jan 17, 2014 at 5:39 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Maybe it is not completely related but I think it needs to be thought
> > about while you are it:
> >
> > The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
> > UART but they share the same clock. So, the next question would be what
> > if I just want to enable one or the other (and take that decision at
> > runtime) ?
> 
> Some Broadcom chips (BCM4329/4330) and the AP6210 found on CubieTruck
> are like this as well. In our case, the SD/MMC host driver hasn't been
> mainlined yet. But BT on UART is independent and usable.
> 
> > Where do I put the pinctrl/clocks/regulators in the DT ? I guess it can
> > become an issue to enable both WiFi and BT at the same time if both SDIO
> > and UART are trying to handle the same pinctrl and regulators.
> 
> Shouldn't the clocks and regulators be registered in the DT _AS_ clocks
> and regulators? fixed-regulator already accepts GPIO lines. fixed-rate-clock
> mentions GPIOs in DT bindings, but doesn't seem to use them in the code.
> We'd still need a device to tie them to, especially in the UART use case.
> 

Yeah, I meant if you tie your clock/pinctrl/reset/regulator to both the
BT and the WiFI nodes because it is shared, you'll at least get a
warning or one of the two won't be working.

> Or we could try rfkill devices. Not saying it's the correct way, but it is
> a solution.
> 

You'll get the same issue there. Two rfkill devices sharing the same
clock or reset for example.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/d440c2f6/attachment.sig>
