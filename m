From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Dec 2017 15:40:35 +0100
Subject: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531D9C@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
 <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531D9C@NT-Mail07.beckhoff.com>
Message-ID: <20171206144035.5brxvavkx2u2tk23@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 10:17:06AM +0000, Patrick Br?nn wrote:
> >From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> >Sent: Mittwoch, 6. Dezember 2017 09:36
> >On Tue, Dec 05, 2017 at 03:06:46PM +0100, linux-kernel-dev at beckhoff.com
> >wrote:
> >> +static int mxc_rtc_wait_for_flag(void *__iomem ioaddr, int flag)
> >> +{
> >> +    unsigned int timeout = REG_READ_TIMEOUT;
> >> +
> >> +    while (!(readl(ioaddr) & flag)) {
> >> +            if (!--timeout) {
> >> +                    pr_err("Wait timeout for 0x%x@%p!\n", flag, ioaddr);
> >
> >Please use dev_* functions for printing. In this case the message should
> >probably be printed from the caller.
> Do you have a link at hand about dev_* vs. pr_*? I just choose pr_err here,
> because I would have to change the functions signature to get a device.
> However, I will drop the message and move it to the caller.

No, I don't have a link. However, a message printed with pr_err comes
with absolutely no context, so without grepping the source you do not
get a clue which device has a problem. You could add more context
using some prefix either to each message or by using

#define pr_fmt(fmt) "mydriver: " fmt

but then you still not know which instance the message throws. Using
dev_* just does the right thing without much thinking.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
