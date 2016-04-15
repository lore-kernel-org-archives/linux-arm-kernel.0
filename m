From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 15 Apr 2016 08:41:07 +0300
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
In-Reply-To: <CAJ+vNU3-Ht7mVUn+T6n1YmYMwxzAW7X-ryccCZw0U_uNiGv2=A@mail.gmail.com>
References: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
 <20160414133237.GE2092@tarshish>
 <CAJ+vNU3-Ht7mVUn+T6n1YmYMwxzAW7X-ryccCZw0U_uNiGv2=A@mail.gmail.com>
Message-ID: <20160415054107.GH2092@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Thu, Apr 14, 2016 at 07:39:40AM -0700, Tim Harvey wrote:
> On Thu, Apr 14, 2016 at 6:32 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Thu, Apr 14, 2016 at 06:19:09AM -0700, Tim Harvey wrote:
> >> The GW52xx/GW53xx/GW54xx have an on-board RS485 transceiver for half-duplex
> >> RS485 using uart1. The active-high TXEN is GPIO7__IO1 which we can configure
> >> as the rts-gpio as long as we specify it as active-low to invert the polarity
> >> managed by mctrl_gpio helpers. This allows for RS485 to be used from
> >> userspace by setting flags to SER_RS485_RTS_ON_SEND in the serial_rs485
> >> struct when using the TIOCGRS485 ioctl.
> >
> > Do you use http://article.gmane.org/gmane.linux.ports.arm.kernel/482641 for
> > that?
> 
> No - that wasn't in my tree, but I will test it and respond to that thread.

I see that the MAX14840 transceiver has built-in Rx disable on Tx logic, so 
you don't strictly need this patch. But since my patch changes the behaviour 
when SER_RS485_RX_DURING_TX is not set, it would be nice if you give it a spin 
to verify that it doesn't break you use case.

I think though that a SER_RS485_DISABLE_RX_ON_TX flag that inverts the logic 
of SER_RS485_RX_DURING_TX would make much more sense, both on serial drivers 
side, and on userspace. But that's history now since we can't break the ABI.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
