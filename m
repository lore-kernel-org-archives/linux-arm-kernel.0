From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 13:49:43 +0800
Subject: [GIT PULL] SPEAr clk updates for v-3.5
In-Reply-To: <CAOesGMg+fNwxPYo+oDZm=uDKj4s7jZw_U91wfs=JE15xCZPomQ@mail.gmail.com>
References: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
 <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
 <20120510085939.GC3190@n2100.arm.linux.org.uk>
 <20120510153745.GQ17875@S2101-09.ap.freescale.net>
 <20120510155327.GB12727@n2100.arm.linux.org.uk>
 <CAOesGMg+fNwxPYo+oDZm=uDKj4s7jZw_U91wfs=JE15xCZPomQ@mail.gmail.com>
Message-ID: <20120511054940.GU17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 10:33:24PM -0700, Olof Johansson wrote:
> How about adding the __must_check patch on your for-next branch for a
> bit, so we can find and fix build fallout on the arm-soc branches
> through linux-next, maintainers can add build fixes that we pick up
> and then, after that, the __must_check fix can go upstream? That
> maintains bisectability on the branches we already have and should
> avoid more non-checking code to be introduced down the road.
> 
The function clk_register_clkdev is created to run-time register clk
lookup.  Mostly the users of the function (platform clk code) will
have a long list like the below (arch/arm/mach-imx/clk-imx6q.c).

        clk_register_clkdev(clk[mmdc_ch0_axi], NULL, "mmdc_ch0_axi");
        clk_register_clkdev(clk[mmdc_ch1_axi], NULL, "mmdc_ch1_axi");
        clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
        clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
        clk_register_clkdev(clk[twd], NULL, "smp_twd");
        clk_register_clkdev(clk[usboh3], NULL, "usboh3");
        clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
        clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.serial");
        clk_register_clkdev(clk[uart_serial], "per", "21ec000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.serial");
        clk_register_clkdev(clk[uart_serial], "per", "21f0000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
        clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
        clk_register_clkdev(clk[enet], NULL, "2188000.ethernet");
        clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
        clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
        clk_register_clkdev(clk[usdhc3], NULL, "2198000.usdhc");
        clk_register_clkdev(clk[usdhc4], NULL, "219c000.usdhc");
        clk_register_clkdev(clk[i2c1], NULL, "21a0000.i2c");
        clk_register_clkdev(clk[i2c2], NULL, "21a4000.i2c");
        clk_register_clkdev(clk[i2c3], NULL, "21a8000.i2c");
        clk_register_clkdev(clk[ecspi1], NULL, "2008000.ecspi");
        clk_register_clkdev(clk[ecspi2], NULL, "200c000.ecspi");
        clk_register_clkdev(clk[ecspi3], NULL, "2010000.ecspi");
        clk_register_clkdev(clk[ecspi4], NULL, "2014000.ecspi");
        clk_register_clkdev(clk[ecspi5], NULL, "2018000.ecspi");
        clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
        clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
        clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
        clk_register_clkdev(clk[ssi1_ipg], NULL, "2028000.ssi");
        clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
        clk_register_clkdev(clk[ahb], "ahb", NULL);
        clk_register_clkdev(clk[cko1], "cko1", NULL);

We probably do not want to make the whole clk initialization fail on
individual clk_register_clkdev call, but just give an error message and
continue trying to boot.  In that case, clk_register_clkdev can just
do the job to save users from return checking on every single call in
that long list?

-- 
Regards,
Shawn
