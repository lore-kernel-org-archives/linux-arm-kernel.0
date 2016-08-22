From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 16:23:29 -0600
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160819173233.13260-6-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
Message-ID: <4d43ba58-9571-8038-b0e2-2a9f6ebccdb2@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The Boot and Power Management Processor (BPMP) is a co-processor found
> on Tegra SoCs. It is designed to handle the early stages of the boot
> process and offload power management tasks (such as clocks, resets,
> powergates, ...) as well as system control services.
>
> Compared to the ARM SCPI, the services provided by BPMP are message-
> based rather than method-based. The BPMP firmware driver provides the
> services to transmit data to and receive data from the BPMP. Users can
> also register an MRQ, for which a service routine will be run when a
> corresponding event is received from the firmware.
>
> A set of messages, called the BPMP ABI, are specified for a number of
> different services provided by the BPMP (such as clocks or resets).
>
> Based on work by Sivaram Nair <sivaramn@nvidia.com> and Joseph Lo
> <josephl@nvidia.com>.

Overall, this driver could use comments describing how it works. Even a 
few or a few tens of lines describing the general structure of how 
messages pass from the initial client's function call into the IPC 
memory and back up to the return to the original caller would be useful. 
There seem to be many varied paths for this, and it's a bit difficult to 
reverse engineer which are used when and why.

> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h

> +struct tegra_bpmp_soc {
> +	struct {
> +		struct {
> +			unsigned int offset;
> +			unsigned int count;
> +			unsigned int timeout;
> +		} cpu_tx, thread, cpu_rx;
> +	} channels;
> +	unsigned int num_resets;
> +};

This deserves a comment to describe what the offset/count/timeout 
represent. It took me a while to realize that each CPU had its own 
channel in IVC memory, and there was a pool of channels for threads to 
use. At least, that's what I reversed engineered is going on... (Having 
only used BPMP from U-Boot, where there's only a single CPU/thread 
active ever and no IRQs, hence we always use channel 0).

> +struct tegra_bpmp_mb_data {
> +	u32 code;
> +	u32 flags;
> +	u8 data[TEGRA_BPMP_MSG_DATA_SIZE];
> +} __packed;

Shouldn't struct mrq_request from bpmp_abi.h be used instead of 
redefining this?

> +struct tegra_bpmp {
...
> +	unsigned int num_clocks;
> +	struct clk_hw **clocks;
> +
> +	struct reset_controller_dev rstc;
> +};

As I mentioned elsewhere, I'm not totally convinced that the BPMP driver 
should be anything more than a fairly transparent IPC channel; all the 
clock/reset/... stuff could be shuffled entirely into child devices.

(out-of-order quote)
> +int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp);
> +int tegra_bpmp_init_resets(struct tegra_bpmp *bpmp);

Oh I see; the clock/reset code isn't actually separate drivers (like 
MFD), but just a set of functions that run "in the context of" the main 
BPMP driver. Maybe that's OK, but I was expected more MFD style, hence 
various other comments related to this topic, like just above.

(FWIW, I've been mostly in U-Boot-land recently, and the driver model 
there requires each device to be of a separate class like clock, reset, 
... so the only option is separate MFD style sub-devices. However, the 
Linux subsystems allow a single device to implement various subsystems 
at once. No doubt U-Boot's model has warped my thinking a bit.)

> +struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
> +void tegra_bpmp_put(struct tegra_bpmp *bpmp);

Those don't seem to be used; can they be dropped?

> +int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
> +			   tegra_bpmp_mrq_handler_t handler, void *data);
> +void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
> +			 void *data);

Those are only used inside the BPMP driver itself right now at least 
(i.e. not in the clock/reset drivers in this series). Can they be static 
rather than public?

> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c

> +#define MSG_ACK		BIT(0)
> +#define MSG_RING	BIT(1)

It'd be nice if bpmp_abi.h defined those, but I know it doesn't:-(

> +struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct tegra_bpmp *bpmp;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(dev->of_node, "nvidia,bpmp", 0);
> +	if (!np)
> +		return ERR_PTR(-ENOENT);

That property name isn't defined by any DT binding. I think it's 
left-over from an old I2C sub-node binding.

> +static bool tegra_bpmp_master_free(struct tegra_bpmp_channel *channel)
> +{
> +	void *frame;
> +
> +	frame = tegra_ivc_write_get_next_frame(channel->ivc);
> +	if (IS_ERR_OR_NULL(frame)) {
> +		channel->ob = NULL;
> +		return false;
> +	}
> +
> +	channel->ob = frame;
> +
> +	return true;
> +}

I'm confused by the function name; this doesn't seem to be freeing 
anything. Is it really tegra_bpmp_get_next_free_tx_frame() or something 
like that? Same for tegra_bpmp_wait_master_free() below.

> +static struct tegra_bpmp_mrq *tegra_bpmp_find_mrq(struct tegra_bpmp *bpmp,
> +						  unsigned int mrq)
> +{
> +	struct tegra_bpmp_mrq *entry;
> +
> +	list_for_each_entry(entry, &bpmp->mrqs, list)
> +		if (entry->mrq == mrq)
> +			return entry;
> +
> +	return NULL;
> +}

I believe an MRQ is a type of message, not the identity of an individual 
message. As such, there can be multiple instances (message) of a 
particular type/MRQ. Is there code somewhere to ensure that only a 
single request of any given type is outstanding at a time? I'm not sure 
why anything would ever be looked up by MRQ...

> +static int tegra_bpmp_get_firmware_tag(struct tegra_bpmp *bpmp, char *tag,
> +				       size_t size)
...
> +	virt = dma_alloc_coherent(bpmp->dev, TEGRA_BPMP_MSG_DATA_SIZE, &phys,
> +				  GFP_KERNEL | GFP_DMA32);
> +	if (!virt)
> +		return -ENOMEM;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.addr = phys;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq = MRQ_QUERY_TAG;
> +	msg.tx.data = &request;
> +	msg.tx.size = sizeof(request);
> +
> +	local_irq_save(flags);
> +	err = tegra_bpmp_transfer_atomic(bpmp, &msg);
> +	local_irq_restore(flags);
> +
> +	if (err == 0)
> +		strlcpy(tag, virt, size);

virt seems to be allocated and copied from, but never used in the IPC 
transaction.

> +static void tegra_bpmp_channel_signal(struct tegra_bpmp_channel *channel)
> +{
> +	unsigned long flags = channel->ob->flags;
> +
> +	if ((flags & MSG_RING) == 0)
> +		return;
> +
> +	complete(&channel->completion);
> +}

Shouldn't that always call complete()? tegra_bpmp_transfer() always call 
wait_for_completion_timeout(), irrespective of the flags value.

> +static int tegra_bpmp_channel_init(struct tegra_bpmp_channel *channel,
> +				   struct tegra_bpmp *bpmp,
> +				   unsigned int index)
> +{
> +	size_t message, queue;
...
> +	message = tegra_ivc_align(TEGRA_BPMP_MSG_SIZE);
> +	queue = tegra_ivc_total_queue_size(message);

I suspect those should be message_size and message_queue, otherwise the 
variable names sound like they should be pointers to objects, not 
properties of the objects.

...
> +	/* reset the channel state */
> +	tegra_ivc_reset(channel->ivc);
> +
> +	/* sync the channel state with BPMP */
> +	while (tegra_ivc_notified(channel->ivc))
> +		;

I think this synchronously waits for the single channel in question to 
reset, one-by-one. Won't that take rather a long time; wouldn't it be 
better to initialize an start-the-reset-of all channels, then wait for 
the reset to complete across all channels in parallel?

> +static int tegra_bpmp_init_powergates(struct tegra_bpmp *bpmp)

Is this function necessary? It doesn't seem to do anything with the 
response data except pass it to dev_dbg() which probably doesn't do 
anything.

> +static int __init tegra_bpmp_init(void)
> +{
> +	return platform_driver_register(&tegra_bpmp_driver);
> +}
> +core_initcall(tegra_bpmp_init);

Can that boiler-plat be replaced with module_init_driver(); IIRC that's 
appropriate and often used even for non-modular drivers?
