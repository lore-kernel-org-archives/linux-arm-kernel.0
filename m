From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Mar 2015 11:43:21 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <5513F0D9.5080807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/03/15 11:01, Vincent Yang wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Add driver for the ARM Primecell Message-Handling-Unit(MHU) controller.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
> ---
>   .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 +++++
>   drivers/mailbox/Kconfig                            |   9 +
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/arm_mhu.c                          | 195 +++++++++++++++++++++
>   4 files changed, 249 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>   create mode 100644 drivers/mailbox/arm_mhu.c
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> new file mode 100644
> index 0000000..4971f03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> @@ -0,0 +1,43 @@
> +ARM MHU Mailbox Driver
> +======================
> +
> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
> +3 independent channels/links to communicate with remote processor(s).
> + MHU links are hardwired on a platform. A link raises interrupt for any
> +received data. However, there is no specified way of knowing if the sent
> +data has been read by the remote. This driver assumes the sender polls
> +STAT register and the remote clears it after having read the data.
> +The last channel is specified to be a 'Secure' resource, hence can't be
> +used by Linux running NS.
> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,mhu" & "arm,primecell"
> +- reg:			Contains the mailbox register address range (base
> +			address and length)
> +- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- interrupts:		Contains the interrupt information corresponding to
> +			each of the 3 links of MHU.
> +

I tried using this driver and found that AMBA driver expects apb_clk
without which probe fails. Though your example have it, it's not
explicit from the binding. Also AMBA binding expects the primecell id in
the binding.

Regards,
Sudeep
