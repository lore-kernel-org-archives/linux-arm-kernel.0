From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:24:03 +0200
Subject: [PATCH v3 15/22] firmware: arm_scmi: abstract mailbox interface
In-Reply-To: <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-16-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a0EUr_aEZdOrjHixzp44yXqsNxTMzBceSBTmk-x8x2MAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Some of the mailbox controller expects controller specific data in order
> to implement simple doorbell mechanism as expected by SCMI specification.
>
> This patch creates a shim layer to abstract the mailbox interface so
> that it can support any mailbox controller. It also provides default
> implementation which maps to standard mailbox client APIs, so that
> controllers implementing doorbell mechanism need not require any
> additional layer.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Another level? Now we have three levels of stacked mailboxes, with
the highest level being the combined mailbox/memory, then the shim,
and below it the hardware mailbox.

Can you try to come up with a way to do this with fewer abstractions?

Maybe you could assume that the mailbox itself can take variable-length
data packets, and then use the shim here for those that require
something else?

        Arnd
