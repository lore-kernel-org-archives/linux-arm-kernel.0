From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:13:54 +0200
Subject: [PATCH v3 11/22] firmware: arm_scmi: add support for polling
 based SCMI transfers
In-Reply-To: <1506604306-20739-12-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-12-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a2wRFif2zYKKmdcNm5wgbGdhqwLdA-YV7AX_0LmM+OiQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> It would be useful to have options to perform some SCMI transfers
> atomically by polling for the completion flag instead of interrupt
> driven. The SCMI specification has option to disable the interrupt and
> poll for the completion flag in the shared memory.
>
> This patch adds support for polling based SCMI transfers using that
> option. This might be used for uninterrupted/atomic DVFS operations
> from the scheduler context.

multi-millisecond timeouts from inside the scheduler sound like a
really bad idea. Could this maybe get changed to an asynchronous
operation?

> +       if (xfer->hdr.poll_completion) {
> +               timeout = info->desc->max_rx_timeout_ms * 100;
> +               while (!scmi_xfer_poll_done(info, xfer) && timeout--)
> +                       udelay(10);

The timeout calculation is bad as well, since both the
scmi_xfer_poll_done() call and udelay() can take much longer
than the 10 microsecond delay that you use for the calculation.

If you want to do a timeout check like this, it should generally
be done using ktime_get()/ktime_add()/ktime_before().

       Arnd
