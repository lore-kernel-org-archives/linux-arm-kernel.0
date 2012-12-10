From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Dec 2012 22:08:51 +0000
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
Message-ID: <201212102208.52347.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 October 2012, Viresh Kumar wrote:
> dw_dmac driver already supports device tree but it used to have its platform
> data passed the non-DT way.
> 
> This patch does following changes:
> - pass platform data via DT, non-DT way still takes precedence if both are used.
> - create generic filter routine
> - Earlier slave information was made available by slave specific filter routines
>   in chan->private field. Now, this information would be passed from within dmac
>   DT node. Slave drivers would now be required to pass bus_id (a string) as
>   parameter to this generic filter(), which would be compared against the slave
>   data passed from DT, by the generic filter routine.
> - Update binding document
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm deeply sorry for the very late complaint on this, but I only now
noticed this patch as I was seeing build breakage in linux-next
because of it.

The build bug is not the problem however, but the abuse of the
API is. Andy, are you sure you understood what this does when
you gave you Reviewed-by comment?

Viresh, there are multiple problems with your approach unfortunately:

* It does not follow the binding from
  Documentation/devicetree/bindings/dma/dma.txt

* It requires slave drivers to know that they are using the dw_dmac
  driver and pass a pointer to dw_generic_filter, which is not
  generic at all

* It requires the dmac node to have information about all slaves

There are also some minor issues, such as the naming of DT
properties, but the above need to be resolved first.

	Arnd
