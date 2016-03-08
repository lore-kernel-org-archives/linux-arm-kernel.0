From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Mar 2016 17:38:11 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <20160308173134.22a3ad64@free-electrons.com> (Thomas Petazzoni's
 message of "Tue, 8 Mar 2016 17:31:34 +0100")
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
 <20160308164117.2a3ed3a7@free-electrons.com>
 <87a8m93pt0.fsf@free-electrons.com>
 <20160308173134.22a3ad64@free-electrons.com>
Message-ID: <8760wx3oy4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., mars 08 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Tue, 08 Mar 2016 17:19:39 +0100, Gregory CLEMENT wrote:
>
>> OK, so let's only use clk_enable() which can't sleep. On mvebu SoCs
>> there is no prepare/unprepare operation for the clock, so trying to use
>> clk_prepare_enable() is useless. Especially for this code which is not
>> for a random IP but especially for the Armada XP SoC.
>> 
>> If in the future the same logic can be used for a new mvebu SoC which
>> need the prepare/unprepare feature, then we will see how to deal with
>> it, but I really doubt that it will happen.
>
> I am not sure doing a clk_enable() without a clk_prepare() before it is
> legal, and that's why the clk_prepare_enable() helper is widely used.
>
> From the clk_prepare() comment:
>
> ""
> In fact clk_prepare must be called before clk_enable.
> ""
>

And from clk_enable comment we have:
""
clk_enable must not sleep, which differentiates it from clk_prepare.  In a
simple case, clk_enable can be used instead of clk_prepare to ungate a clk
if the operation will never sleep.
""

Moreoever for me the "must" was to insist to the order of the call no to
the fact that both must be called.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
