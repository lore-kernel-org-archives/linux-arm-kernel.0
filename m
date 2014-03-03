From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 3 Mar 2014 10:19:04 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1569751.q5lJmQcb3K@avalon>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1393621768-12568-4-git-send-email-wsa@the-dreams.de>
 <1569751.q5lJmQcb3K@avalon>
Message-ID: <20140303091903.GA6531@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >  drivers/clk/shmobile/Makefile |   1 +
> >  drivers/clk/shmobile/clk-rz.c | 112 +++++++++++++++++++++++++++++++++++++++
> 
> There's one large missing piece here: the DT bindings documentation.

Yes, noticed that, too. Added already.

> > +	u32 val;
> > +	unsigned mult, frqcr_tab[4] = { 3, 2, 0, 1 };
> 
> I would declare the table as static const outside of this function.

Yup.

> > +	if (strcmp(name, "pll") == 0) {
> > +		/* FIXME: cpg_mode should be read from GPIO. But no GPIO support yet 
> */
> > +		unsigned cpg_mode = 0; /* hardcoded to EXTAL for now */
> 
> It won't make a difference yet, but shouldn't this be moved to 
> rz_cpg_clocks_init() ?

This is going to be a gpio_get_value() later and I'd prefer it in the
place where the value is needed.

> 
> > +		const char *parent_name = of_clk_get_parent_name(np, 0);
> 
> You should select the parent depending on the mode (again it won't make any 
> difference yet, but the code will be ready, and DT bindings should document 
> two parents).

Two parents? Yet, CPG only needs one as input. Either XTAL or USB_X1
which is board dependent. What I should do IMO is to put the parent
property for CPG from the dtsi to the board dts. Because this is
describing hardware. And from that parent, I can simply get its name
like above.

> > +	int num_clks;
> > +
> > +	num_clks = of_property_count_strings(np, "clock-output-names");
> > +	if (WARN(num_clks < 0, "can't count CPG clocks\n"))
> 
> Do such failures really deserve a WARN ? Isn't a pr_err() enough ?

Since the system won't probably boot, I'd think so. Also, it makes the
code more concise, no?

> What if num_clks == 0 ?

Good question.

> 
> > +		goto out;
> > +
> > +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> > +	if (WARN(!cpg, "out of memory!\n"))
> > +		goto out;
> > +
> > +	clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
> > +	if (WARN(!clks, "out of memory!\n"))
> > +		goto free_cpg;
> 
> Does kzalloc alloc warn internally when it fails to allocate memory ?

Ehrm, why don't you simply look this up instead of asking me? :)

> you could remove the error message. You could also perform the two allocations 
> and check the result once only.

What is the gain? Code savings?

> > +free_clks:
> > +	kfree(clks);
> > +free_cpg:
> > +	kfree(cpg);
> 
> I would remove that as done in the other CPG drivers, given that a small 
> memory leak when the system will anyway fail to boot isn't really an issue.

Again, now that I already coded it, what is the gain to remove it? The
drawback is that other people might get encouraged to find reasons to
allow them sloppy practices.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/aee9a2b4/attachment.sig>
