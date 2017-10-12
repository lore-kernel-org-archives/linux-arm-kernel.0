From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 12 Oct 2017 14:20:12 -0700
Subject: [PATCH v3 15/22] firmware: arm_scmi: abstract mailbox interface
In-Reply-To: <f316b938-c6d5-3aa9-4f03-6b5c6ad4bfa7@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0EUr_aEZdOrjHixzp44yXqsNxTMzBceSBTmk-x8x2MAg@mail.gmail.com>
 <f316b938-c6d5-3aa9-4f03-6b5c6ad4bfa7@arm.com>
Message-ID: <CAOCOHw7HOfnFZBpy6XmzGhDzbAczPJ0t8z_dyTYFz25U=Y9uEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 4:32 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 04/10/17 12:24, Arnd Bergmann wrote:
>> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> Some of the mailbox controller expects controller specific data in order
>>> to implement simple doorbell mechanism as expected by SCMI specification.
>>>
>>> This patch creates a shim layer to abstract the mailbox interface so
>>> that it can support any mailbox controller. It also provides default
>>> implementation which maps to standard mailbox client APIs, so that
>>> controllers implementing doorbell mechanism need not require any
>>> additional layer.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Another level? Now we have three levels of stacked mailboxes, with
>> the highest level being the combined mailbox/memory, then the shim,
>> and below it the hardware mailbox.
>>
>> Can you try to come up with a way to do this with fewer abstractions?
>>
>
> I completely agree with you. I was against this but Jassi recommended
> this. I just wanted this SCMI to work with mailbox controllers that
> support simple doorbell mechanism as specified in the specification but
> Jassi disagrees with that.
>
>> Maybe you could assume that the mailbox itself can take variable-length
>> data packets, and then use the shim here for those that require
>> something else?
>>
>
> As per SCMI specification, we pass all the data in shared memory and it
> just expects to use a simple doorbell feature from hardware mailbox
> controllers. It's done that way intentionally to avoid dependency on h/w
> and we for sure will have variety of it and that defeats the purpose
> of this standard specification.
>
> Also, I have added shim only for specific controllers that need them.
> E.g. ARM MHU as Jassi disagreed to add doorbell mechanism to that.
> mbox_if provides default implementation that just calls direct mailbox
> APIs.
>

drivers/mailbox is a framework for interfacing/abstracting hardware
mailboxes. If you're starting to layer mailboxes ontop of each-other
chances are very high that you're confusing it with the computer
science term "mailbox".

Abstracting a doorbell-like piece of hardware behind the mbox
framework makes a lot of sense, but the interface between your clients
and the code that fills out shared memory and then invokes said
doorbell is a higher level of "mailbox" and is probably better
implemented using a direct function call.

Regards,
Bjorn
