From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Oct 2017 12:32:22 +0100
Subject: [PATCH v3 15/22] firmware: arm_scmi: abstract mailbox interface
In-Reply-To: <CAK8P3a0EUr_aEZdOrjHixzp44yXqsNxTMzBceSBTmk-x8x2MAg@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0EUr_aEZdOrjHixzp44yXqsNxTMzBceSBTmk-x8x2MAg@mail.gmail.com>
Message-ID: <f316b938-c6d5-3aa9-4f03-6b5c6ad4bfa7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/17 12:24, Arnd Bergmann wrote:
> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Some of the mailbox controller expects controller specific data in order
>> to implement simple doorbell mechanism as expected by SCMI specification.
>>
>> This patch creates a shim layer to abstract the mailbox interface so
>> that it can support any mailbox controller. It also provides default
>> implementation which maps to standard mailbox client APIs, so that
>> controllers implementing doorbell mechanism need not require any
>> additional layer.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Another level? Now we have three levels of stacked mailboxes, with
> the highest level being the combined mailbox/memory, then the shim,
> and below it the hardware mailbox.
> 
> Can you try to come up with a way to do this with fewer abstractions?
> 

I completely agree with you. I was against this but Jassi recommended
this. I just wanted this SCMI to work with mailbox controllers that
support simple doorbell mechanism as specified in the specification but
Jassi disagrees with that.

> Maybe you could assume that the mailbox itself can take variable-length
> data packets, and then use the shim here for those that require
> something else?
> 

As per SCMI specification, we pass all the data in shared memory and it
just expects to use a simple doorbell feature from hardware mailbox
controllers. It's done that way intentionally to avoid dependency on h/w
and we for sure will have variety of it and that defeats the purpose
of this standard specification.

Also, I have added shim only for specific controllers that need them.
E.g. ARM MHU as Jassi disagreed to add doorbell mechanism to that.
mbox_if provides default implementation that just calls direct mailbox
APIs.

-- 
Regards,
Sudeep
