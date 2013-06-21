From: xiechao.mail@gmail.com (Chao Xie)
Date: Fri, 21 Jun 2013 09:07:59 +0800
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
References: <20130620121749.GF9817@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
Message-ID: <CADApbejTBAv0+XxkGLXuMVrLatbNurR0XBkK2gt6eQnXr+5yEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 1:25 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 20 Jun 2013, Felipe Balbi wrote:
>
>> > In fact, the PHY setting and handling is related to platform or SOC,
>> > and for different SOC they can
>> > have same EHCI HCD but they PHY handling can be different.
>> > Omap'a case is the example, and i think some other vendors may have
>> > silimar cases.
>> > From above point, It is better to leave the PHY initialization and
>> > shutdown to be done by each echi-xxx driver.
>> >
>> > So Alan and Felipe
>> > What are your ideas about it?
>>
>> If we have so many exceptions, then sure. But eventually, the common
>> case should be added generically with a flag so that non-generic cases
>> (like OMAP) can request to handle the PHY by themselves.
>>
>> Alan ?
>
> I don't have very strong feelings about this; Felipe has much more
> experience with these things.
>
> However, when the common case is added into the core, the simplest way
> to indicate that the HCD wants to handle the PHY(s) by itself will be
> to leave hcd->phy set to NULL or an ERR_PTR value.
>
> One important thing that hasn't been pointed out yet: When we move
> these calls into the core, the same patch must also remove those calls
> from the glue drivers that currently do set hcd->phy.  And it must make
> sure that the glue drivers which handle the PHY by themselves do not
> set hcd->phy.
>

>From device point of view, EHCI is a standlone component. It has the
standard sepcification, so each
SOC vendor has EHCI HCD need to follow the standards. Then we have
common EHCI HCD driver.
The PHY is outside of EHCI component, each SOC vendor may have
different PHY implementation. Then
we have PHY driver.
The EHCI glue driver ehci-xxx works like a SOC depended driver. It is
its duty to handle the'
relationship between the EHCI HCD driver and PHY driver.
It is same as clk, irq requested by ehci-xxx driver.

So i think add a flag and use usb_get_phy() is not very good.
It is bette to make ehci-xxx to do the phy getting and EHCI HCD
initialize it and shut down as the patch did, or let ehci-xxx to
handle the PHY as Roger said.

Based on the generic work is not too much, and does not look so
meaningful. I suggest that let to echi-xxx
do it.

> Alan Stern
>
