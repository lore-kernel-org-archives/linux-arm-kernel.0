From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 11 Jul 2013 17:25:36 +0800
Subject: [PATCH v12 10/13] usb: chipidea: add wait vbus lower than
 OTGSC_BSV before role starts
In-Reply-To: <51DE5DC8.8020605@pengutronix.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-11-git-send-email-peter.chen@freescale.com>
 <51DE5DC8.8020605@pengutronix.de>
Message-ID: <20130711092535.GA11728@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 09:24:56AM +0200, Marc Kleine-Budde wrote:
> On 07/11/2013 08:27 AM, Peter Chen wrote:
> > When the gadget role starts, we need to make sure the vbus is lower
> > than OTGSC_BSV, or there will be an vbus interrupt since we use
> > B_SESSION_VALID as vbus interrupt to indicate connect and disconnect.
> > When the host role starts, it may not be useful to wait vbus to lower
> > than OTGSC_BSV, but it can indicate some hardware problems like the
> > vbus is still higher than OTGSC_BSV after we disconnect to host some
> > time later (500 jiffies currently), which is obvious not correct.
> 
> Jiffies ist not constant. I think you have to specify the timeout in
> fractions of HZ. The system ticks with HZ jiffies per second. So a
> timeout of 500ms is "HZ / 2".

Thanks, I will use msecs_to_jiffies.

> > +/**
> > + * hw_wait_reg: wait the register value
> > + *
> > + * Sometimes, it needs to wait register value before going on.
> > + * Eg, when switch to device mode, the vbus value should be lower
> > + * than OTGSC_BSV before connects to host.
> > + *
> > + * @ci: the controller
> > + * @reg: register index
> > + * @mask: mast bit
> > + * @value: the bit value to wait
> > + * @timeout: timeout to indicate an error
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Better: timeout in jiffies
> 

As I will use msecs_to_jiffies, @timeout: timeout in millisecond.

Thanks.

-- 

Best Regards,
Peter Chen
