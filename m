From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 May 2013 22:24:22 +0100
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20130510212422.GY3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:31:31AM -0700, Soren Brinkmann wrote:

> +Example:
> +	usclk: usclk {
> +		compatible = "clk-userspace";
> +		clocks = <&foo 15>, <&bar>;
> +		clock-count = <2>;
> +	};

This is clearly *very* Linux specific so needs to be a linux vendor
thing (everything should have a namespaced name anyway).  It's not at
all obvious to me that this should be in device tree, though, since it's
not hardware description but a detail of how the OS is currently
implemented.

For your use case should these things be exposed by the FPGA device
asking for that rather than by having the clocks available separately?
Or is this part of the DT blob that's loaded incrementally along with
the FPGA (which does make things more interesting of course...).

> + * Expose clock controls through sysfs to userspace.

> + * By writing 0/1 to 'enable' the clock can be disabled/enabled. Reading
> + * that file returns the current state - 0 = disabled, 1 = enabled.

> + * Reading 'set_rate' returns the current clock frequency in Hz. Writing
> + * the file requests setting a new frequency in Hz.

This needs to be covered in Documentation/ABI since it's adding new
sysfs stuff.

> +	if (enable)
> +		ret = clk_prepare_enable(pdata->clk);
> +	else
> +		clk_disable_unprepare(pdata->clk);

> +	if (ret)
> +		return -EBUSY;

Why not pass back the actual error?

> +	pdata = kzalloc(clock_count * sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;

devm?

> +late_initcall(usclk_setup);

Why not just a regular driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130510/98d46afb/attachment-0001.sig>
