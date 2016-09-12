From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Sep 2016 12:58:54 -0700
Subject: [PATCH v2 00/17] Make rpmsg a framework
In-Reply-To: <7682a26a-310b-b283-dfe8-56d114f92dcb@codeaurora.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
 <20160912165233.GB21885@linaro.org> <20160912180015.GH405@tuxbot>
 <bc618ac9-13c8-e9bf-c7e9-fe5b7309a585@codeaurora.org>
 <20160912184957.GI405@tuxbot>
 <7682a26a-310b-b283-dfe8-56d114f92dcb@codeaurora.org>
Message-ID: <20160912195854.GJ405@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Sep 12:21 PDT 2016, Jeffrey Hugo wrote:

> On 9/12/2016 12:49 PM, Bjorn Andersson wrote:
> >On Mon 12 Sep 11:13 PDT 2016, Jeffrey Hugo wrote:
> >
> >>On 9/12/2016 12:00 PM, Bjorn Andersson wrote:
[..]
> >>>Can you point me to the downstream code where this is implemented so I
> >>>can have a look? Do you expect to get the response on that request?
> >>
> >>Have a look at -
> >>smd_mask_receive_interrupt()
> >>smd_is_pkt_avail()
> >>
> >
> >In msm-3.18 these still seems to only come from either
> >msm_rpm_enter_sleep() and the rpm-clock driver, related to flushing
> >cached sleep state requests.
> >
> >>Every request to the RPM generates a response.  The Linux RPM driver may
> >>decide to let the response sit in the fifo, or it may need to read and
> >>process it.
> >>
> >
> >Right, I presume we save some time by not waiting for these responses as
> >we want to reach sleep as soon as possible. The answer I got last time
> >this was discussed was that it was an optimization, not a functional
> >requirement.
> 
> Two optimizations in play here.
> 
> First, disabling interrupts prevents an immediate wakeup.  When the system
> is entering sleep, IRQs are disabled.  The sleep request to RPM will trigger
> a response, and the IRQ for that response will be queued. Once the sleep
> processing is done, IRQs get enabled, so the pending IRQ from RPM will cause
> an immediate wakeup.  The system will process the wakeup, and then go back
> to sleep (sans request because nothing has changed).  This down-up-down
> processing burns a lot of power.
> 

But which "sleep request" is this? The only one I can find is the
flushing of sleep state values from the rpm resource tables.

> Second is not waiting for the response.  Linux doesn't really do anything
> with the sleep request response, so we can enter sleep faster by not waiting
> for the response and processing (discarding) it when the system wakes up as
> scheduled.

Right, as long as the RPM code doesn't consider it a timeout don't have
a problem if those ack's are handled after the resume.

> However, Linux needs to ensure there is enough fifo space to
> hold that response while asleep, otherwise the RPM will panic and crash the
> system.  Therefore, if there are a number of outstanding requests that would
> fill the fifo, then the RPM driver on Linux needs to spin and drain requests
> from the fifo until a minimum free space buffer to hold additional expected
> pending responses is established.  This has to occur with IRQs disabled.
> 

Right. Which means that the RPM driver needs to know how large the rx
fifo is, what overhead the underlaying transport mechanism has and then
calculate how many responses it should leave room for.

[..]
> >>If I recall correctly, there was a parameter in the RPM driver
> >>for the transmit function that indicated if the request was being made in
> >>atomic context or not, which would change the behavior of how the transmit
> >>was handled.
> >>
> >
> >You're correct, the question is still which of these code paths are
> >actually needed and to motivate the endless maintenance of the extra
> >code.
> 
> If we are just talking about transmitting in atomic context (not necessarily
> related to sleep), if I recall correctly, some bus requests are sent to RPM
> in atomic context, some APR requests to the Audio DSP are done in atomic
> context, and I think IPC Router uses atomic context in some cases.  As a
> generic framework that should support usecases to all processors/subsystems,
> I don't think transmitting in atomic context is a special case for
> RPM/sleep.
> 

I have not looked through all of APR yet and don't know where msm_bus is
heading, but for IPC-router your correct that the downstream driver does
indeed require this; but that's a side effect of the downstream
ipcrouter implementation, not the problem itself.

Regards,
Bjorn
