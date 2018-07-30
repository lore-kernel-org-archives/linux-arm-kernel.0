From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 30 Jul 2018 07:30:43 -0700
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
Message-ID: <20180730143043.qu66ttzwyjbw6si7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 06:01:54PM +0800, Yangbo Lu wrote:
> The ptp_qoriq driver initialized the 1588 timer with the
> configurations provided by the properties of device tree
> node. For example,
> 
>   fsl,tclk-period = <5>;
>   fsl,tmr-prsc    = <2>;
>   fsl,tmr-add     = <0xaaaaaaab>;
>   fsl,tmr-fiper1  = <999999995>;
>   fsl,tmr-fiper2  = <99990>;
>   fsl,max-adj     = <499999999>;
> 
> These things actually were runtime configurations which
> were not proper to be put into dts.

That is debatable.  While I agree that the dts isn't ideal for these,
still it is the lesser of two or more evils.

> This patch is to convert
> to use module parameters for 1588 timer initialization, and
> to support initial register values calculation.

It is hard for me to understand how using module parameters improves
the situation.

> If the parameters are not provided, the driver will calculate
> register values with a set of default parameters. With this
> patch, those dts properties are no longer needed for new
> platform to support 1588 timer, and many QorIQ DPAA platforms
> (some P series and T series platforms of PowerPC, and some
> LS series platforms of ARM64) could use this driver for their
> fman ptp timer with default module parameters. However, this
> patch didn't remove the dts method. Because there were still
> many old platforms using the dts method. We need to clean up
> their dts files, verify module parameters on them, and convert
> them to the new method gradually in case of breaking any
> function.

In addition, like it or not, because the dts is an ABI, you must
continue support of the dts values as a legacy option.

Thanks,
Richard
