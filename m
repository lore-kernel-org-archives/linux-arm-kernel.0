From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 11:17:53 +0200
Subject: [PATCH 14/32] dmaengine: ste_dma40: Remove 'always true' checking
In-Reply-To: <1366279934-30761-15-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ5BzmjFNxHrhXVyRhMTMsH4Cq1XRmgiWQjU2e6cCO1bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Before allocating memory for logical channels, the current driver
> checks to see if there are any. Well as the dma40_memcpy_channels[]
> array is always populated, the check is always true. Best to
> remove the check.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

(...)

> -       if (num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) {

So I guess this was changed when moving the memcpy channels
into the driver.

> -               /*
> -                * The max number of logical channels are event lines for all
> -                * src devices and dst devices
> -                */
> -               base->lookup_log_chans = kzalloc(num_log_chans *
> -                                                sizeof(struct d40_chan *),
> -                                                GFP_KERNEL);

And at that point you forgot to rewrite this as
kzalloc((num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)), ...)?

> -               if (!base->lookup_log_chans)
> -                       goto failure;
> -       }
> +       base->lookup_log_chans = kzalloc(num_log_chans *
> +                                        sizeof(struct d40_chan *),
> +                                        GFP_KERNEL);
> +       if (!base->lookup_log_chans)
> +               goto failure;

So this change should also include the memcpy channels.

I'll go back and comment again on the patch moving the
memcpy channels into the driver.

Yours,
Linus Walleij
