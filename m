From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2018 13:34:56 +0100
Subject: [RFC PATCH 12/12] soc: qcom: ipa: build and "ipa_i.h"
In-Reply-To: <20181107003250.5832-13-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-13-elder@linaro.org>
Message-ID: <CAK8P3a2X1zstSWP89uDxyf+rvyzzDY98_cvE4fzc-ZGbyVz23w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> +config IPA_ASSERT
> +       bool "Enable IPA assertions"
> +       depends on IPA
> +       default y
> +       help
> +        Incorporate IPA assertion verification in the build.  This
> +        cause various design assumptions to be checked at runtime,
> +        generating a report (and a crash) if any assumed condition
> +        does not hold.  You may wish to disable this to avoid the
> +        overhead of checking.

Maybe remove this from the submission.

> +#define ipa_debug(fmt, args...)        dev_dbg(ipa_ctx->dev, fmt, ## args)
> +#define ipa_err(fmt, args...)  dev_err(ipa_ctx->dev, fmt, ## args)

These macros refer to variables in the caller that are not passed as arguments,
which is generally a bad idea. They also trivially wrap a standard kernel
interface, so better just that directly.

> +#define ipa_bug() \
> +       do {                                                            \
> +               ipa_err("an unrecoverable error has occurred\n");       \
> +               BUG();                                                  \
> +       } while (0)
> +
> +#define ipa_bug_on(condition)                                          \
> +       do {                                                            \
> +               if (condition) {                                \
> +                       ipa_err("ipa_bug_on(%s) failed!\n", #condition); \
> +                       ipa_bug();                                      \
> +               }                                                       \
> +       } while (0)

According to a discussion at the kernel summit, we should generally
try to avoid BUG() as it rarely does anything useful: it crashes the
current task, but in a network driver that usually means killing the
entire kernel since you are not in process context.

Try questioning each one to see if it can possibly happen, or if the
code can be rewritten in a way to guarantee that it cannot.

If continuing after the bug was detected does not cause a security
hole or permanent data corruption, you can also use WARN_ON()
or WARN_ONCE() (without a wrapper).

> +int ipa_wwan_init(void);
> +void ipa_wwan_cleanup(void);
> +
> +int ipa_stop_gsi_channel(u32 ep_id);
> +
> +void ipa_cfg_ep(u32 ep_id);
> +
> +int ipa_tx_dp(enum ipa_client_type dst, struct sk_buff *skb);
> +
> +bool ipa_endp_aggr_support(u32 ep_id);
> +enum ipa_seq_type ipa_endp_seq_type(u32 ep_id);
> +
> +void ipa_endp_init_hdr_cons(u32 ep_id, u32 header_size,
> +                           u32 metadata_offset, u32 length_offset);
> +void ipa_endp_init_hdr_prod(u32 ep_id, u32 header_size,
> +                           u32 metadata_offset, u32 length_offset);

I'm surprised to see many functions that don't take a pointer
to an instance as the first argument, which often indicates
that you have global state variables and the driver won't
work with multiple hardware instances.

      Arnd
