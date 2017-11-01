From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 1 Nov 2017 23:33:34 +0530
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 10:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>
> Such controllers don't need to transmit any data, they just transmit
> the signal. In such controllers the data pointer passed to
> mbox_send_message is passed to client via it's tx_prepare callback.
> Controller doesn't need any data to be passed from the client.
>
Some controllers need a non-zero value written to a register in order
to trigger the signal.
That register is visible to the remote. While the data/packet is setup
during tx_prepare() callback.
You are overlooking this class of doorbell controllers.

>
> This is rough idea I have on extending mailbox interface to support
> the doorbell requirements.
>
What doorbell requirements does the api not support?
QComm's APCS IPC is what you call a "doorbell" controller and is
already supported by the API. It could run SCMI even easier than MHU
(your controller).

> The new API send_signal will eliminate the
> issue Jassi has explained in earlier discussion with respect to generic
> message format using Rockchip example.
>
Sorry I don't see how.
Please explain how can send_signal() api be used by, say, rockchip to
support SCMI?

I am not convinced we should clone an api just so that a client driver
becomes simpler. Esp when it shifts, and not avoid, the additional
code (to support the client) onto the provider side.

Thanks.
