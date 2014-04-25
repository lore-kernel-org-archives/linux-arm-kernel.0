From: robherring2@gmail.com (Rob Herring)
Date: Fri, 25 Apr 2014 13:01:30 -0500
Subject: [PATCH v7 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <1398446835-5532-4-git-send-email-ashwin.chaugule@linaro.org>
References: <1398446835-5532-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398446835-5532-4-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CAL_JsqKYXL1Egp=hF1ykESjQiMdFBNa0GAQsvZXoSsmRtHr8Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 12:27 PM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> PSCIv0.2 adds a new function called AFFINITY_INFO, which
> can be used to query if a specified CPU has actually gone
> offline. Calling this function via cpu_kill ensures that
> a CPU has quiesced after a call to cpu_die.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/kernel/psci_smp.c | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/psci.h  |  5 +++++
>  2 files changed, 37 insertions(+)

[...]

> +retry_once:
> +       err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
> +
> +       if (err != PSCI_AFFINITY_INFO_RET_OFF) {
> +               if (!retry++) {
> +                       msleep(100);

It would be better to sleep 10ms 10 times rather than a single 100ms
sleep. And please do this with a loop rather than a goto.

Rob
