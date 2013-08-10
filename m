From: dsd@laptop.org (Daniel Drake)
Date: Sat, 10 Aug 2013 08:57:27 -0600
Subject: [PATCH v6 09/11] clk: mmp: parse clock from dts
In-Reply-To: <1374833133-21119-10-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-10-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHRwW9fodM4poVL=OK47NU2-_PCfpHHfM2crBMefw+Uy2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

I just stumbed upon this mail... I see that I have done some similar
work in my recent patches. Maybe you could CC me in future when we are
duplicating efforts.

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Parse clock information from DTS file for mach-mmp.
>
> Changelog:
> v6:
> 1. Remove marvell string from properties in clock driver.
> 2. Append document for clock binding device tree.
> 3. Use apbc to replace apbcp. Since the main difference is register
> base.

If one replaces the other then why are both still present in the patch?
I think all these clock type acronyms deserve a quick comment
explaining what they are.

> +Required properties for divider clocks:
> +  - compatible : should be "marvell,mmp-apmu-clkdiv".
> +  - clocks : should be the input parent clock phandle for the clock. This
> +       should be the reference clock.
> +  - clock-output-names : should be reference name.
> +  - #clock-cells : from common clock binding; should be set to 0.
> +  - mmp-clk-reg : divider register offset & mask bits.

I think you should use the standard 'reg' property for providing
register offets, and then other properties (with better names) for
other info that needs to be supplied e.g. mask.

I see that your implementation here moves away from using the existing
code in clk-apmu.c and instead just uses clk-divider directly. That
might make sense, but your new DTS does not reimplement many of the
static APMU clocks that were previously implemented (e.g. ccic, sdh in
clk-mmp2.c). Why is this?

> +Required properties for gate clocks:
> +  - compatible : should be "marvell,mmp-apbc-clk".
> +  - clocks : should be the input parent clock phandle for the clock. This
> +       should be the reference clock.
> +  - clock-output-names : should be reference name.
> +  - #clock-cells : from common clock binding; should be set to 0.
> +  - mmp-clk-reg : gate register offset & mask bits.

mmp-clk-reg contains two elements, I guess. But the second element is
not used in your driver for mmp-apbc-clk.

Thanks
Daniel
