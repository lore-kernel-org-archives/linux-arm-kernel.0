From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 15:28:33 +0200
Subject: [PATCH v3 11/12] clk: tegra: Add BPMP clock driver
In-Reply-To: <0d7080bc-9e82-75dd-7169-0a5b7429801e@nvidia.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-12-thierry.reding@gmail.com>
 <0d7080bc-9e82-75dd-7169-0a5b7429801e@nvidia.com>
Message-ID: <20160822132833.GD17367@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 11:11:57AM +0100, Jon Hunter wrote:
> 
> On 19/08/16 18:32, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This driver uses the services provided by the BPMP firmware driver to
> > implement a clock driver based on the MRQ_CLK request. This part of the
> > BPMP ABI provides a means to enumerate and control clocks and should
> > allow the driver to work on any chip that supports this ABI.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/clk/tegra/Makefile   |   1 +
> >  drivers/clk/tegra/clk-bpmp.c | 565 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 566 insertions(+)
> >  create mode 100644 drivers/clk/tegra/clk-bpmp.c
> > 
> > diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> > index 33fd0938d79e..130df5685d21 100644
> > --- a/drivers/clk/tegra/Makefile
> > +++ b/drivers/clk/tegra/Makefile
> > @@ -22,3 +22,4 @@ obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
> >  obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
> >  obj-y					+= cvb.o
> >  obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
> > +obj-$(CONFIG_ARCH_TEGRA_186_SOC)	+= clk-bpmp.o
> > diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
> > new file mode 100644
> > index 000000000000..96cd6becf73e
> > --- /dev/null
> > +++ b/drivers/clk/tegra/clk-bpmp.c
> > @@ -0,0 +1,565 @@
> > +#define DEBUG
> 
> Do we want DEBUG by default?

That was left-over from debugging. I've removed it.

> > +static u8 tegra_bpmp_clk_get_parent(struct clk_hw *hw)
> > +{
> > +	struct tegra_bpmp_clk *clk = to_tegra_bpmp_clk(hw);
> > +	struct cmd_clk_get_parent_response response;
> > +	struct tegra_bpmp_clk_message msg;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +	msg.cmd = CMD_CLK_GET_PARENT;
> > +	msg.clk = clk->id;
> > +	msg.rx.data = &response;
> > +	msg.rx.size = sizeof(&response);
> > +
> > +	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
> > +	if (err < 0)
> > +		return err;
> 
> tegra_bpmp_clk_transfer returns an int, but this function returns a u8.

I've added an error message containing the error code and made this
return U8_MAX.

> > +
> > +	for (i = 0; i < clk->num_parents; i++)
> > +		if (clk->parents[i] == response.parent_id)
> > +			return i;
> > +
> > +	return U8_MAX;
> 
> Is there any chance the U8_MAX == num_parents? Should we warn here
> somewhere?

I've added a check to the function registration code that will refuse to
add clocks with num_parents >= U8_MAX. This should never happen because
the MRQ_CLK_MAX_PARENTS is the upper bound for this, and it's currently
very small.

> > +static int tegra_bpmp_clk_get_max_id(struct tegra_bpmp *bpmp)
> > +{
> > +	struct cmd_clk_get_max_clk_id_response response;
> > +	struct tegra_bpmp_clk_message msg;
> > +	int err;
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +	msg.cmd = CMD_CLK_GET_MAX_CLK_ID;
> > +	msg.rx.data = &response;
> > +	msg.rx.size = sizeof(response);
> > +
> > +	err = tegra_bpmp_clk_transfer(bpmp, &msg);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return response.max_id;
> 
> response.max_id is a uint32

I've added a check to make sure this doesn't overflow.

> > +}
> > +
> > +static int tegra_bpmp_clk_get_info(struct tegra_bpmp *bpmp, unsigned int id,
> > +				   struct tegra_bpmp_clk_info *info)
> > +{
> > +	struct cmd_clk_get_all_info_response response;
> > +	struct tegra_bpmp_clk_message msg;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +	msg.cmd = CMD_CLK_GET_ALL_INFO;
> > +	msg.clk = id;
> > +	msg.rx.data = &response;
> > +	msg.rx.size = sizeof(response);
> > +
> > +	err = tegra_bpmp_clk_transfer(bpmp, &msg);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	strlcpy(info->name, response.name, MRQ_CLK_NAME_MAXLEN);
> > +	info->num_parents = response.num_parents;
> > +
> > +	for (i = 0; i < info->num_parents; i++)
> > +		info->parents[i] = response.parents[i];
> > +
> > +	info->flags = response.flags;
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_bpmp_probe_clocks(struct tegra_bpmp *bpmp,
> > +				   struct tegra_bpmp_clk_info **clocksp)
> > +{
> > +	struct tegra_bpmp_clk_info *clocks;
> > +	unsigned int max_id, id, count = 0;
> > +	int err;
> > +
> > +	err = tegra_bpmp_clk_get_max_id(bpmp);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	max_id = err;
> > +
> > +	dev_dbg(bpmp->dev, "maximum clock ID: %u\n", max_id);
> > +
> > +	clocks = kcalloc(max_id + 1, sizeof(*clocks), GFP_KERNEL);
> > +	if (!clocks)
> > +		return -ENOMEM;
> > +
> > +	for (id = 0; id <= max_id; id++) {
> > +		struct tegra_bpmp_clk_info *info = &clocks[count];
> > +#if 0
> > +		const char *prefix = "";
> > +		struct seq_buf buf;
> > +		unsigned int i;
> > +		char flags[64];
> > +#endif
> > +
> > +		err = tegra_bpmp_clk_get_info(bpmp, id, info);
> > +		if (err < 0) {
> > +			dev_err(bpmp->dev, "failed to query clock %u: %d\n",
> > +				id, err);
> > +			continue;
> > +		}
> > +
> > +#if 0
> > +		seq_buf_init(&buf, flags, sizeof(flags));
> > +
> > +		if (info->flags)
> > +			seq_buf_printf(&buf, "(");
> > +
> > +		if (info->flags & TEGRA_BPMP_CLK_HAS_MUX) {
> > +			seq_buf_printf(&buf, "%smux", prefix);
> > +			prefix = ", ";
> > +		}
> > +
> > +		if ((info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE) == 0) {
> > +			seq_buf_printf(&buf, "%sfixed", prefix);
> > +			prefix = ", ";
> > +		}
> > +
> > +		if (info->flags & TEGRA_BPMP_CLK_IS_ROOT) {
> > +			seq_buf_printf(&buf, "%sroot", prefix);
> > +			prefix = ", ";
> > +		}
> > +
> > +		if (info->flags)
> > +			seq_buf_printf(&buf, ")");
> > +
> > +		dev_dbg(bpmp->dev, "  %03u: %s\n", id, info->name);
> > +		dev_dbg(bpmp->dev, "    flags: %lx %s\n", info->flags, flags);
> > +		dev_dbg(bpmp->dev, "    parents: %u\n", info->num_parents);
> > +
> > +		for (i = 0; i < info->num_parents; i++)
> > +			dev_dbg(bpmp->dev, "      %03u\n", info->parents[i]);
> > +#endif
> > +
> > +		/* clock not exposed by BPMP */
> > +		if (info->name[0] == '\0')
> > +			continue;
> > +
> > +		info->id = id;
> > +		count++;
> > +	}
> > +
> > +	*clocksp = clocks;
> 
> Nit we could just return the pointer.
> 
> > +
> > +	return count;
> 
> We return unsigned int here and not int. Why do we bother returning
> count and just store it directly in the bpmp->num_clocks here (see
> tegra_bpmp_register_clocks)?

Hm... I'm not sure but I think I had initially imagined this to be used
in two steps: call tegra_bpmp_probe_clocks() without passing in a clocks
buffer to get a count for how many clocks to allocate, allocate a buffer
with the proper size in the caller and call again, this time passing in
the new buffer. It looks like halfway through the code I changed my mind
and it's no longer consistent with what I had intended originally.

I'll rewrite this so that it (hopefully) makes more sense.

> > +	for (i = 0; i < info->num_parents; i++) {
> > +		/* keep a private copy of the ID to parent index map */
> > +		priv->parents[i] = info->parents[i];
> > +
> > +		for (j = 0; j < num_clocks; j++) {
> > +			const struct tegra_bpmp_clk_info *parent = &clocks[j];
> > +
> > +			if (parent->id == info->parents[i]) {
> > +				parents[i] = parent->name;
> > +				break;
> > +			}
> > +		}
> 
> Is it necessary to loop through all the clocks again here? This function
> is called from tegra_bpmp_register_clocks() which is already looping
> through all the clocks. So for each clock we loop through all the clocks
> again.

Yes, it's unfortunately necessary because clocks aren't topologically
sorted. That is, in the earlier loop we may encounter clocks for which a
parent hasn't been probed yet. That's not a problem for the common clock
framework because it supports orphan clocks and reparenting when their
parent becomes available. However, given that the driver queries all the
clock names from BPMP, we first need to get all names before we can save
the parent names for the CCFs consumption.

> 
> > +		if (!parents[i])
> > +			dev_err(bpmp->dev, "no parent %u found for %u\n",
> > +				info->parents[i], info->id);
> > +	}
> > +
> > +	init.parent_names = parents;
> > +
> > +	clk = clk_register(bpmp->dev, &priv->hw);
> 
> IS_ERR?

Yes, I've added a check.

> > +int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp)
> > +{
> > +	struct tegra_bpmp_clk_info *clocks;
> > +	unsigned int count;
> > +	int err;
> > +
> > +	dev_dbg(bpmp->dev, "> %s(bpmp=%p)\n", __func__, bpmp);
> > +
> > +	err = tegra_bpmp_probe_clocks(bpmp, &clocks);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	count = err;
> > +
> > +	dev_dbg(bpmp->dev, "%u clocks probed\n", count);
> > +
> > +	err = tegra_bpmp_register_clocks(bpmp, clocks, count);
> > +	if (err < 0) {
> > +		kfree(clocks);
> > +		return err;
> > +	}
> > +
> > +	kfree(clocks);
> > +
> > +	of_clk_add_hw_provider(bpmp->dev->of_node, tegra_bpmp_clk_of_xlate,
> > +			       bpmp);
> 
> We should check the return code.

Yes, I suppose we should also make sure to remove all clocks if this
ever fails. I'll see how difficult it is to implement that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/c063c82c/attachment.sig>
