From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jul 2010 10:02:41 +0100
Subject: [PATCH 2/4] ARM: S5PV210: Powerdomain/Clock-gating Support
In-Reply-To: <1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100719090241.GB8641@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 05:30:34PM +0900, MyungJoo Ham wrote:
> +static int powerdomain_set(struct powerdomain *pd, int enable)
> +{
> +	unsigned long ctrlbit;
> +	void __iomem *reg;
> +	void __iomem *stable_reg;
> +	unsigned long reg_dat;
> +
> +	if (pd == NULL)
> +		return -EINVAL;

If someone calls this function with a NULL pd argument, is it better
to ignore it, or better to use WARN_ON and get a backtrace so it can
be fixed?  I don't see much reason for this function to ever be called
with a NULL powerdomain argument.

> +
> +	ctrlbit = pd->pd_ctrlbit;
> +	reg = (void __iomem *)pd->pd_reg;
> +	stable_reg = (void __iomem *)pd->pd_stable_reg;

Why not ensure that the element in the structure is correctly typed to
start with?

It's good practice to avoid casts whenever-possible - they hide bugs.
