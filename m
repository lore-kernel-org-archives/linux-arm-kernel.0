From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 20 Jun 2014 18:48:12 +0530
Subject: [PATCH v3 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <CAJAp7Ogw967gbBGmiifhtNTsZ57g8MMy4mUR1YwvpWVSZnmOjA@mail.gmail.com>
References: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
 <7hvbrzbh1u.fsf@paris.lan>
 <CAJAp7OhHr4Cgcp9pvQ3=MAie_zSnFJxG28Vf37qJ98BK7P1jaQ@mail.gmail.com>
 <7hzjha8b97.fsf@paris.lan>
 <842A7147-A2CC-42BD-9947-CBADF738DC92@codeaurora.org>
 <7hegym6uca.fsf@paris.lan>
 <CAJAp7Ogw967gbBGmiifhtNTsZ57g8MMy4mUR1YwvpWVSZnmOjA@mail.gmail.com>
Message-ID: <CAJe_Zhcp_TODswcsGRBPqfuC8s-LkM8iGBSAQEnzveKi6QJdqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2014 10:47, Bjorn Andersson <bjorn@kryo.se> wrote:
> On Wed, Jun 18, 2014 at 9:44 AM, Kevin Hilman <khilman@linaro.org> wrote:
> [...]
>> Thinking more about what this RPM driver actually does, and since you
>> mentioned patterns across SoCs, it seems to me the RPM driver bascially
>> just doing the IPC.
>>
>
> Yes, technically this is IPC. But it's all exposed in memory as if it
> was hardware, so there's no messages or packets to be interpreted by
> the other side.
>
>> So, rather than MFD or drivers/soc, it seems to me that it should be
>> implmented as a controller in the new common mailbox framwork[1] being
>> worked on by Jassi Brar (added to Cc.)
>>
>> IIUC, RPM is actually only doing one-way IPC (it only exposes a write()
>> interface to clients) so it seems like a rather simple implementation of
>> a mailbox controller.
>>
>
> What I think you miss here is the detail of that what the regulator
> writes is not what is passed over the IPC, but rather is just an
> interface to abstract away how things are spread our in the register
> space.
>
> So the only place where we do have a "mailbox" here is the actual
> function call between the regulator and the rpm drivers; not between
> the rpm driver and the rpm.
>
Is the RPM a firmware running on a separate processor outside the
scope of Linux ?

Is an irq raised to the RPM when you do  writel(RPM_SIGNAL, rpm->ipc_rpm_reg) ?

Do you get the qcom_rpm_ack_interrupt() only when the RPM firmware has
taken action on Linux's request (i.e, values filled in 80ish
registers)?

I maybe wrong but I think the answer to all above is Yes, and that is
the reason I think its no different than other mailbox controllers.
For example, look at pl320_ipc_transmit()


>> I believe Bjorn is already on the list of folks Cc'd on the common
>> mailbox framework, so it would be good to hear from him why RPM wouldn't
>> fit under that framework.
>>
>
> In a separate group of Qualcomm platforms the communication with the
> RPM is done by passing messages over a shared memory channel; as this
> requires a completely different implementation of the rpm driver, I
> have started to look at Jassi's patch series.
>
> Unfortunately at this point it does not look like the proposed mailbox
> framework would reduce the complexity of the implementation nor
> provide any additional benefits when it comes to being able to
> exchange the underlaying communication methods.
>
For your simple one-way communication, using mailbox api isn't going
to change lives.

Cheers,
-Jassi
