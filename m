From: clemens.gruber@pqgruber.com (Clemens Gruber)
Date: Sun, 2 Jul 2017 22:17:15 +0200
Subject: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
In-Reply-To: <CAOMZO5A-fF5V4obGD-XEnSbt8TB2wsCTJRjvKXfxM_SjKXdQXQ@mail.gmail.com>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
 <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com>
 <20170621140556.GA766@archie.localdomain>
 <CAOMZO5DXxaJ6PveJb9912rog8xvfqgsg3O3u3a-ffWUj9ZnpCg@mail.gmail.com>
 <CAOMZO5A-fF5V4obGD-XEnSbt8TB2wsCTJRjvKXfxM_SjKXdQXQ@mail.gmail.com>
Message-ID: <20170702201715.GA26018@archie.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio, Hi Romain,

On Fri, Jun 30, 2017 at 09:15:31AM -0300, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Wed, Jun 21, 2017 at 11:12 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> >> I'd also prefer fixing the underlying problem.
> >
> > Yes, that would be much better.
> 
> Just saw Romain's patch series that addresses several imx uart DMA issues:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/516845.html
> 
> If you have a chance, please give it a try to see if it helps on the
> RS485 DMA case.

Thanks, I just finished my first tests with Romain's patch series:

It looks like these patches fixed some of the bugs, causing this
behavior, but not all: The behavior changed, the rest of the circular
buffer is no longer sent out as seen in the previous bug report
(https://pqgruber.com/rs485_results.png)

But now, with the patch series applied, if I transmit "Test", the logic
analyzer records the following:
https://pqgruber.com/rs485txtest.png

Most of the time it looked like this (T e T e s s t t LF LF), but in a
few cases I observed another pattern (T e T s e s t t LF LF) when
transmitting "Test" by calling echo Test > /dev/ttymxc4.

If I do a echo A > /dev/ttymxc4 as in my first bug report, now I always
see the pattern A LF A LF on the TX line, but no longer A LF A LF 0 0 ..

Interestingly, the bug does not appear the first time I try echo A after
a reboot.

Romain: What board did you use to test your patch series?
The RS485 bug, I reported, only appears on i.MX6D and i.MX6Q, but not on
single-core / non-SMP systems. Would be great if you could reproduce it!

Regards,
Clemens
