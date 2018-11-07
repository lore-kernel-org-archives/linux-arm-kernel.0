From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2018 15:55:22 +0100
Subject: [RFC PATCH 10/12] soc: qcom: ipa: data path
In-Reply-To: <20181107003250.5832-11-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-11-elder@linaro.org>
Message-ID: <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> This patch contains "ipa_dp.c", which includes the bulk of the data
> path code.  There is an overview in the code of how things operate,
> but there are already plans to rework this portion of the driver.
>
> In particular:
>   - Interrupt handling will be replaced with a threaded interrupt
>     handler.  Currently handling occurs in a combination of
>     interrupt and workqueue context, and this requires locking
>     and atomic operations for proper synchronization.

You probably don't want to use just a threaded IRQ handler to
start the poll function, that would still require an extra indirection.

However, you can probably use the top half of the threaded
handler to request the poll function if necessary but use
the bottom half for anything that does not go through poll.

>   - Currently, only receive endpoints use NAPI.  Transmit
>     completion interrupts are disabled, and are handled in batches
>     by periodically scheduling an interrupting no-op request.
>     The plan is to arrange for transmit requests to generate
>     interrupts, and their completion will be processed with other
>     completions in the NAPI poll function.  This will also allow
>     accurate feedback about packet sojourn time to be provided to
>     queue limiting mechanisms.

Right, that is definitely required here. I also had a look at
the gsi_channel_queue() function, which sits in the middle of
the transmit function and is rather unoptimized. I'd suggest moving
that into the caller so we can see what is going on, and then
optimizing it from there.

>   - Not all receive endpoints use NAPI.  The plan is for *all*
>     endpoints to use NAPI.  And because all endpoints share a
>     common GSI interrupt, a single NAPI structure will used to
>     managing the processing for all completions on all endpoints.
>   - Receive buffers are posted to the hardware by a workqueue
>     function.  Instead, the plan is to have this done by the
>     NAPI poll routine.

Makes sense, yes.

      Arnd
