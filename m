From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 07:38:48 +0100
Subject: [PATCH resend] GPIO PL061: Adding Clk framework support
In-Reply-To: <1277101943-6887-1-git-send-email-viresh.kumar@st.com>
References: <1277101943-6887-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100621063848.GA7582@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 12:02:23PM +0530, Viresh KUMAR wrote:
> @@ -56,8 +59,33 @@ struct pl061_gpio {
>  	void __iomem		*base;
>  	unsigned		irq_base;
>  	struct gpio_chip	gc;
> +	unsigned		usage_count;
> +	struct clk		*clk;
>  };
>  
> +static int pl061_request(struct gpio_chip *gc, unsigned offset)
> +{
> +	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
> +
> +	if (offset >= gc->ngpio)
> +		return -EINVAL;
> +
> +	if (!chip->usage_count)
> +		clk_enable(chip->clk);

Clocks are already use-counted.
