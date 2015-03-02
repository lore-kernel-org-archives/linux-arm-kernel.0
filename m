From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 08:16:06 +0000
Subject: [STLinux Kernel] [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <54F173B7.9030305@st.com>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
 <54F173B7.9030305@st.com>
Message-ID: <20150302081606.GC31325@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Feb 2015, Maxime Coquelin wrote:

> Hi Lee,
> 
> On 02/27/2015 10:14 PM, Lee Jones wrote:
> >Lots of platforms contain clocks which if turned off would prove fatal.
> >The only way to recover from these catastrophic failures is to restart
> >the board(s).  Now, when a clock is registered with the framework it is
> >compared against a list of provided always-on clock names which must be
> >kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
> >flag, which will prevent the common clk framework from attempting to
> >gate it during the clk_disable_unused() procedure.
> 
> Please correct me if I'm wrong, but your patch does not fix the
> issue you had initially.
> Let's take an example:
> A clock is critical for the system, and should never be gated, so
> you add the CLK_IGNORE_UNUSED
> flag so that it is not disabled by clk_disable_unused() procedure.
> The same clock is also used by other IPs, for example spi 0 instance.
> When starting a spi transfer, clk_enable() is called on this clock,
> so its usecount becomes 1.
> Once transfer done, clk_disable() is called, usecount becomes 0 and
> the clock gets disabled: system freeze.

You're right.  I also need to extend clk_core_disable() to take notice
of CLK_IGNORE_UNUSED.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
