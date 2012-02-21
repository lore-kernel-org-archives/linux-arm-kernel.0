From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Feb 2012 11:29:07 -0200
Subject: [PATCH] i.MX31: mxc-rnga: implement waiting for data in driver
In-Reply-To: <1329826410-21739-1-git-send-email-michael.thalmeier@hale.at>
References: <1329826410-21739-1-git-send-email-michael.thalmeier@hale.at>
Message-ID: <CAOMZO5BGVa0HRKqv9nKQUy9iGnQ3FV_6OnguMyk3rAinaJkb6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 10:13 AM, Michael Thalmeier
<michael.thalmeier@hale.at> wrote:

> -static int mxc_rnga_data_present(struct hwrng *rng)
> +static int mxc_rnga_data_present(struct hwrng *rng, int wait)

This looks good, but ...

> ?{
> - ? ? ? int level;
> + ? ? ? int level, i;
> ? ? ? ?void __iomem *rng_base = (void __iomem *)rng->priv;
>
> - ? ? ? /* how many random numbers is in FIFO? [0-16] */
> - ? ? ? level = ((__raw_readl(rng_base + RNGA_STATUS) &
> - ? ? ? ? ? ? ? ? ? ? ? RNGA_STATUS_LEVEL_MASK) >> 8);
> + ? ? ? for (i = 0; i < 20; i++) {

Why the magic "20" here?

It would be better to add a proper timeout mechanism instead, such as
time_after(jiffies, timeout)
