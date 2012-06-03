From: joe@perches.com (Joe Perches)
Date: Sun, 03 Jun 2012 09:34:20 -0700
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
Message-ID: <1338741260.1881.14.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-29 at 19:11 -0600, Sagar Dharia wrote:
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.

Just a few trivial notes before stopped reading as it was
very long.

> diff --git a/drivers/of/of_slimbus.c b/drivers/of/of_slimbus.c
[]
> +		name = kzalloc(SLIMBUS_NAME_SIZE, GFP_KERNEL);
> +		if (!name) {
> +			dev_err(&ctrl->dev, "of_slim: out of memory");

OOM messages aren't necessary as they are reported
with a dump_stack in the alloc functions and please
make sure all messages are newline terminated.

[]

> +		binfo = krealloc(binfo, (n + 1) * sizeof(struct slim_boardinfo),
> +					GFP_KERNEL);

Reallocs should _always_ use a new temporary.
Otherwise, there will be a memory leak of the
original pointer memory on failure.

> diff --git a/drivers/slimbus/slimbus.c b/drivers/slimbus/slimbus.c
[]
> +	if (ctrl->nchans) {
> +		ctrl->chans = kzalloc(ctrl->nchans * sizeof(struct slim_ich),
> +					GFP_KERNEL);

please use kcalloc where appropriate.

> +		ctrl->sched.chc1 =
> +			kzalloc(ctrl->nchans * sizeof(struct slim_ich *),
> +			GFP_KERNEL);
[]
> +		ctrl->sched.chc3 =
> +			kzalloc(ctrl->nchans * sizeof(struct slim_ich *),
> +			GFP_KERNEL);

kcalloc...

> +			ctrl->txnt = krealloc(ctrl->txnt,
> +					(i + 1) * sizeof(struct slim_msg_txn *),
> +					GFP_KERNEL);

that realloc ptr use again.

> +int slim_assign_laddr(struct slim_controller *ctrl, struct slim_eaddr *e_addr,
> +				u8 *laddr)
[]
> +			ctrl->addrt = krealloc(ctrl->addrt,
> +					(ctrl->num_dev + 1) *
> +					sizeof(struct slim_addrt),
> +					GFP_KERNEL);

and again, I won't look for it again.

> +static u16 slim_slicesize(u32 code)
> +{
> +	static const u8 sizetocode[16] = {0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6,
> +						6, 6, 7};

Perhaps more style conformant as:

	static const u8 sizetocode[16] = {
		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
	};

> +	if (code == 0)
> +		code = 1;
> +	if (code > ARRAY_SIZE(sizetocode))
> +		code = 16;

clamp()
