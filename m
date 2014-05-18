From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 18 May 2014 23:10:54 +0200
Subject: [PATCH v3 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <CACRpkdYJU3HN2u=eFPUyM4eMmuT1Xw19zxjpb5nj9nXnar3_-A@mail.gmail.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdYJU3HN2u=eFPUyM4eMmuT1Xw19zxjpb5nj9nXnar3_-A@mail.gmail.com>
Message-ID: <537921DE.3030107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2014 02:43 PM, Linus Walleij wrote:
> On Mon, May 5, 2014 at 7:27 AM, Antoine T?nart
> <antoine.tenart@free-electrons.com> wrote:
> 
>> This series adds support for the Marvell Berlin pin-controller, allowing
>> to configure the pin muxing from the device tree.
> 
> OK looking good!
> 
> I've applied patches 1,2,3,4 and 6 to the pin control tree.

Linus,

thanks for taking the driver. Unfortunately, while working on
clock drivers, I forgot you may take it in before I made up my
mind with the register set pinctrl _and_ clock are in.

Mike came up with a request to try to expose as little of the
clock internals as possible [1]. Also, after looking hours and
hours at the chip-ctrl and system-ctrl registers of Berlin SoCs,
I think using regmaps will be the only option.

I have reworked berlin's pinctrl drivers so they use a mmio regmap
instead of ioremapped addresses. Instead of "independent" pinctrl
nodes, there will be common chip-ctrl/system-ctrl nodes that provide
both clocks and pinctrl (and reset, padmux, ...).

Except regmap, there is no functional change in the driver itself,
just the way the DT compatible and node are accessed.

I need Alexandre and Antoine to add the necessary changes for BG2Q
clocks and pinctrl respectively first, but do you prefer proper
follow-up patches or can you squash them into the ones you've just
taken?

[1] https://lkml.kernel.org/r/20140515044106.19795.57249 at quantum

> Please carry patches 5 and 7 in the MVEBU tree or wherever
> the core SoC is stashed up. It'd not be necessary to pull in the
> pin control tree I think since you're just selecting symbols and
> adding device trees. (The dependencies will magically fall in
> during the merge window, so this is bisectable.)

Yeah, sure, as soon as we have an agreement with Mike on the clocks
and you on the groups/function binding I'll post reworked patches
5 and 7 that fit.

Sebastian
