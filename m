From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 26 Aug 2013 14:53:35 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <20130826120716.GB24795@pengutronix.de>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <20130823073250.GB30135@pengutronix.de> <521B38BF.6040400@monstr.eu>
 <20130826120716.GB24795@pengutronix.de>
Message-ID: <521B4FCF.5000904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/13 14:07, Steffen Trumtrar wrote:
> On Mon, Aug 26, 2013 at 01:15:11PM +0200, Michal Simek wrote:
>> I agree with Soren - let's fix the current problem and then when Steffen has patches with syscon
>> we can look at them.
>>
>> If there is any discussion about early syscon registration please let me know.
>>
>
> Where I'm stuck at the moment is: if I map the whole register space to the
> parent node, how do I get its mapped address in the clkc?

Steffen,

if slcr is such an essential part of the SoC, you can choose to provide
zynq_slcr_readl/writel callbacks. You can then use those callback in the
clock driver without knowing the base address. Also, it allows you to
hide slcr specific locking details from subsequent drivers using the
callbacks.

> AFAIK the phandle is pretty useless in this early stage. In the pinmuxing
> case I should be able to find the registered driver for the lock via the
> phandle.

About the slcr phandle, yes, it is useless. IMHO phandles should only
be used if the referenced node is not known in advance, e.g. for gpios
or clocks. As you will always reference slcr node (and only that node)
you can just use of_find_compatible_node instead. But with the callbacks
above, you will solve it without exploiting DT but common non-static
functions instead.

Sebastian
