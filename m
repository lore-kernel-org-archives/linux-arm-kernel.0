From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 2 Feb 2015 10:45:04 +0800
Subject: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support
 noinit option
In-Reply-To: <54CE53F3.5040709@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <54CE53F3.5040709@hurleysoftware.com>
Message-ID: <1422845104.5512.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, 2015-02-01 at 11:27 -0500, Peter Hurley wrote:
> Hi Eddie,
> 
> On 01/12/2015 08:08 AM, Eddie Huang wrote:
> > Add earlycon support not only baudrate option, but also add noinit option.
> > If use noinit option, 8250 earlycon will not init serial hardware and use
> > loader setting.
> 
> I see this went into Greg's tty-testing branch.
> 
> The only point of this is to not program the divisor, right?
In this case, yes.

> I ask because early_serial8250_setup() could already handle this without
> extra options by simply not doing divisor programming if no baud option is
> present.
MTK support high speed UART, which means baudrate can be more than
115200. You can reference mtk8250_set_termios() function in 8250_mtk.c.
Unfortunately, the early_serial8250_setup() can not handle high speed
case. This is why I add noinit parameter.

Besides, I think "no baud option" is a little tricky, and maybe someday
someone not only care about divisor, but also flow. Legacy earlyprintk
and other uart drivers like msm_serial.c also don't init uart hardware.

> 
> And this blows up if the optional console= form is used:
>     console=uart,mmio32,<addr>,noinit
> because the ttyS console will expect line settings for console match.
> 
Yes, you are right. console parameter case will fail, I only consider
earlycon parameter case.

> 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/tty/serial/8250/8250_early.c |  7 ++++---
> >  drivers/tty/serial/earlycon.c        | 17 ++++++++++++-----
> >  include/linux/serial_8250.h          |  2 ++
> >  include/linux/serial_core.h          |  1 +
> >  4 files changed, 19 insertions(+), 8 deletions(-)
> > 
