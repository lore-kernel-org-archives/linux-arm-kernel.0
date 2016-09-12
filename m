From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 12 Sep 2016 11:49:57 -0700
Subject: [PATCH v2 00/17] Make rpmsg a framework
In-Reply-To: <bc618ac9-13c8-e9bf-c7e9-fe5b7309a585@codeaurora.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
 <20160912165233.GB21885@linaro.org> <20160912180015.GH405@tuxbot>
 <bc618ac9-13c8-e9bf-c7e9-fe5b7309a585@codeaurora.org>
Message-ID: <20160912184957.GI405@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Sep 11:13 PDT 2016, Jeffrey Hugo wrote:

> On 9/12/2016 12:00 PM, Bjorn Andersson wrote:
> >On Mon 12 Sep 09:52 PDT 2016, Lina Iyer wrote:
> >
> >>Hi Bjorn,
> >>
> >>On Thu, Sep 01 2016 at 16:28 -0600, Bjorn Andersson wrote:
> >>>This series splits the virtio rpmsg bus driver into a rpmsg bus and a virtio
> >>>backend/wireformat.
> >>>
> >>>
> >>>As we discussed the Qualcomm SMD implementation a couple of years back people
> >>>suggested that I should make it "a rpmsg thingie". With the introduction of the
> >>>Qualcomm 8996 platform, we must support a variant of the communication
> >>>mechanism that share many of the characteristics of SMD, but are different
> >>>enough that it can't be done in a single implementation. As such there is
> >>>enough benefit to do the necessary work and being able to make SMD a "rpmsg
> >>>thingie".
> >>>
> >>>On-top of this series I have patches to switch the current smd clients over to
> >>>rpmsg (and by that drop the existing SMD implementation).
> >>>
> >>>All this allows me to implement the new backend and reuse all existing SMD
> >>>drivers with the new mechanism.
> >>>
> >>
> >>RPM Communication has to supported even when IRQs are disabled. The most
> >>important use of this communication is to set the wake up time for the
> >>CPU subsystem when all the CPUs are powered off.
> >
> >Can you point me to the downstream code where this is implemented so I
> >can have a look? Do you expect to get the response on that request?
> 
> Have a look at -
> smd_mask_receive_interrupt()
> smd_is_pkt_avail()
> 

In msm-3.18 these still seems to only come from either
msm_rpm_enter_sleep() and the rpm-clock driver, related to flushing
cached sleep state requests.

> Every request to the RPM generates a response.  The Linux RPM driver may
> decide to let the response sit in the fifo, or it may need to read and
> process it.
> 

Right, I presume we save some time by not waiting for these responses as
we want to reach sleep as soon as possible. The answer I got last time
this was discussed was that it was an optimization, not a functional
requirement.


I'm not at all against having the rpm driver cache the state
information and the smd driver process read/writes from the rpm driver
in IRQ context. I do however not know how to trigger the flush in a sane
way.

> >
> >>In addition to that,
> >>"sleep" votes that are sent by the application processor subsystem to
> >>allow system to go into deep sleep modes can only be triggered when the
> >>CPU PM domains are power collapsed, drivers do not have a knowledge of
> >>when that happens.
> >
> >Do you mean the actual sleep votes can only be with the CPU PM domains
> >collapsed?
> >
> >It's been a while since I dug through that code, but there was several
> >cases where sleep votes would be sent out during normal execution as
> >well, and then there's the optimization of flushing out all cached sleep
> >votes when we're on the way down.
> >
> >>This has to be done by a platform code that registers
> >>for CPU PM domain power_off/on callbacks.
> >>
> >
> >Ok, sounds like we have a legit use case for improving this.
> >
> >>Using rpmsg may be nice for RPM SMD communication, but mutexes need to
> >>go away for this driver to be any useful than bare bones active mode
> >>resource requests for QCOM SoCs. By not doing that now, we lock
> >>ourselves out of using this SMD driver in the near future when CPU PM
> >>domains are available in the kernel with an ability to do system low
> >>power modes.
> >>
> >
> >The last time I looked at this there where no cases when it was
> >_required_ to support transmitting requests to the rpm from IRQ context.
> 
> I no longer work on SMD, but when I did this was in fact a strict
> requirement.

When I dissected all the users of the API I came to the conclusion that
this requirement (on the SMD driver) came from above mentioned
optimization.

> If I recall correctly, there was a parameter in the RPM driver
> for the transmit function that indicated if the request was being made in
> atomic context or not, which would change the behavior of how the transmit
> was handled.
> 

You're correct, the question is still which of these code paths are
actually needed and to motivate the endless maintenance of the extra
code.


Nice to see you on the mailing list again Jeff.

Regards,
Bjorn
