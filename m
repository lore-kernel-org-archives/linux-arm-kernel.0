From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 26 Nov 2014 16:53:50 -0800
Subject: [PATCH v12 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1417047195-18978-4-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Wed, 26 Nov 2014 17:13:08 -0700")
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
 <1417047195-18978-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hk32hcvkx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> SPM is a hardware block that controls the peripheral logic surrounding
> the application cores (cpu/l$). When the core executes WFI instruction,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the core
> out of low power mode.
>
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions.
> SPM is a finite state machine block to which a sequence is provided and
> it interprets the bytes and executes them in sequence. Each low power
> mode that the core can enter into is provided to the SPM as a sequence.
>
> Configure the SPM to set the core (cpu or L2) into its low power mode,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the rest
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>
> Add support for an idle driver to set up the SPM to place the core in
> Standby or Standalone power collapse mode when the core is idle.
>
> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
> Original tree available at -
> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> new file mode 100644
> index 0000000..e5d3ebd
> --- /dev/null
> +++ b/drivers/soc/qcom/spm.c
> @@ -0,0 +1,328 @@
> +/* Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.

nit: one more multi-line coding style missed (no need to repost just for
this, feel free to just updated it locally)

After that, feel free to add:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
