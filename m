From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Feb 2018 12:32:39 +0100
Subject: [PATCH v5 11/20] firmware: arm_scmi: add support for polling
 based SCMI transfers
In-Reply-To: <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a31CMsLUSm0rsHLdvM4sbjZ6fwocKmA1JiuCtF97vj3PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +#define SCMI_MAX_POLLING_TIMEOUT_NS    (100 * NSEC_PER_USEC)
>  /**
>   * scmi_do_xfer() - Do one transfer
>   *
> @@ -389,14 +406,30 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)

> +       if (xfer->hdr.poll_completion) {
> +               ktime_t stop, cur;
> +
> +               stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLLING_TIMEOUT_NS);
> +               do {
> +                       udelay(5);
> +                       cur = ktime_get();
> +               } while (!scmi_xfer_poll_done(info, xfer) &&
> +                        ktime_before(cur, stop));

The 5 microsecond back-off isn't that much smaller than the 100 microsecond
timeout, given that udelay() often waits much longer than the specified time.

How did you come up with those two numbers? Are you sure this is better
than just using a cpu_relax() instead of the udelay()?

      Arnd
