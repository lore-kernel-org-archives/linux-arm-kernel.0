From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Tue, 16 Mar 2010 19:09:55 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <63386a3d1003151055v6d3e2ee0q848fcbb4c7a29a06@mail.gmail.com>
References: <4B9DB823.1040809@st.com>
	<63386a3d1003151055v6d3e2ee0q848fcbb4c7a29a06@mail.gmail.com>
Message-ID: <4B9F8A2B.9020307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On 3/15/2010 11:25 PM, Linus Walleij wrote:
> Please contemplate arch/arm/mach-u300/padmux.[c|h] if you have time.
> We have there a runtime padmuxing API similar to what is used for regulators
> and clocks. E.g in arch/arm/mach-u300/mmc.c:
> 
> /*
>  * Setup padmuxing for MMC. Since this must always be
>  * compiled into the kernel, pmx is never released.
>  */
> pmx = pmx_get(mmcsd_device, U300_APP_PMX_MMC_SETTING);
> 
> if (IS_ERR(pmx))
>       pr_warning("Could not get padmux handle\n");
> else {
>     ret = pmx_activate(mmcsd_device, pmx);
>     if (IS_ERR_VALUE(ret))
>          pr_warning("Could not activate padmuxing\n");
> }
> 
> This API can be used to switch in/out padmux settings in runtime. I think
> these things will always be platform-specific because people will always have
> their favourite way of configuring GPIO pins etc. (Note: we're not *just*
> muxing GPIO with this framework, far from, as you see above also the entire
> MMC/SD block connections can be muxed in/out.)

I was trying to go through u300 code and it looks clean enough. I need your
help in understanding it better. In your case you try to configure the pin mux
and then, even if it fails the device (through amba_device_register) is registered.
Now if the driver is enabled in the kernel (or it is insmod) then the driver in
its "probe" would stuck somewhere.
Do we need to handle such scenarios. Am I missing something?
Further, if you can describe what is onmask field (of pmx) and what
devices/options are multiplexed with (say) spi, it would help me better understand
the code.
 
> We've actually seen usecases where you need to dynamically remux while
> drivers are running but these have been rare and on older chips I think.

You mean to say dynamically remapping pins to achieve some function with
the same driver? or taking out one driver and inserting another after changing
mux config.
In any case one of the objective is to keep same linux image for different
configurations/boards. Isn't it ?

thanks a lot.
regards
Shiraz
