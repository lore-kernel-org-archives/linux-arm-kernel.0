From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 19 Sep 2010 09:54:23 +0200
Subject: [PATCH 1/3] [ARM] tegra: add PCI Express clocks
In-Reply-To: <A0A1E7539300DF49AA383E614C7827BC04EBA10BBA@HQMAIL01.nvidia.com>
References: <cover.1284655723.git.mike@compulab.co.il>	<79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>	<AANLkTinN0rYG7rp5Gs3TyGOAQu5qJ18V_-yEuManuX33@mail.gmail.com>,
	<AANLkTi=Mw33sVDdGLMxKh0HN0fKbzzUKqr6R9NHKEUFT@mail.gmail.com>
	<A0A1E7539300DF49AA383E614C7827BC04EBA10BBA@HQMAIL01.nvidia.com>
Message-ID: <4C95C1AF.7080903@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gary King wrote:
>> On Thu, Sep 16, 2010 at 11:27 PM, Colin Cross <ccross@google.com> wrote:
>>> On Thu, Sep 16, 2010 at 9:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> 
> <snip>
> 
>>> I've been told by Nvidia that the pll lock bits are not reliable, and
>>> will be removing uses of tegra2_pll_clk_wait_for_lock and replacing
>>> them with delays selected by each pll.  Can you confirm with Nvidia
>>> that PLLE_MISC_READY works?
> 
>> I'll try to get a confirmation from NVidia....
>> From what I've seen during testing the PLLE_MISC_READY works. When I
>> used loops that counted udelay(1) I've noticed that the
>> PLLE_MISC_READY is set after up to 3usecs.
> 
> All of the PLL lock bits in Tegra 2 are unreliable.
> 
> The safe way to ensure that PLLE is stable is to wait 1ms after changing it.

1 millisecond is a long time... Can you please elaborate about the unreliability 
of PLL lock bits?

>>> <snip>
>>>
>>>> +static struct clk_ops tegra_pcie_clk_ops = {
>>>> +       .enable     = tegra2_periph_clk_enable,
>>>> +       .disable    = tegra2_periph_clk_disable,
>>>> +};
>>> Why is this needed?  Won't the regular periph ops work?
>> They didn't. I haven't found anything about what feeds these clocks,
>> can they change rate, what clock can be their parent and if there is
>> any muxing options for these clocks.
> 
> You can follow the example used by the csi and isp clocks, which also
> only support enable and disable. give the PCI clocks a single-choice parent
> mux (like mux_clk_m), flags = 0, reg = 0, and a dummy max_rate.

Ok, I'll try.

> - Gary--
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
