From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 15 Mar 2010 18:55:53 +0100
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9DB823.1040809@st.com>
References: <4B9DB823.1040809@st.com>
Message-ID: <63386a3d1003151055v6d3e2ee0q848fcbb4c7a29a06@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/15 Viresh KUMAR <viresh.kumar@st.com>:

> In our SOC's (SPEArxxx), we have many peripheral sharing PL_GPIO pins and so
> only few peripherals can be selected in a configuration. This is configurable
> using a set of registers. Now the problem is to make following work:
>
> 1. How to do this selection in kernel in a simple way?
> 2. Based on this selection hardware registers needs to be configured.

Please contemplate arch/arm/mach-u300/padmux.[c|h] if you have time.
We have there a runtime padmuxing API similar to what is used for regulators
and clocks. E.g in arch/arm/mach-u300/mmc.c:

/*
 * Setup padmuxing for MMC. Since this must always be
 * compiled into the kernel, pmx is never released.
 */
pmx = pmx_get(mmcsd_device, U300_APP_PMX_MMC_SETTING);

if (IS_ERR(pmx))
      pr_warning("Could not get padmux handle\n");
else {
    ret = pmx_activate(mmcsd_device, pmx);
    if (IS_ERR_VALUE(ret))
         pr_warning("Could not activate padmuxing\n");
}

This API can be used to switch in/out padmux settings in runtime. I think
these things will always be platform-specific because people will always have
their favourite way of configuring GPIO pins etc. (Note: we're not *just*
muxing GPIO with this framework, far from, as you see above also the entire
MMC/SD block connections can be muxed in/out.)

We've actually seen usecases where you need to dynamically remux while
drivers are running but these have been rare and on older chips I think.

Yours,
Linus Walleij
