From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 13:39:58 +0000
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <20160201063256.GE32462@lukather>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
 <56A95811.8010200@arm.com> <20160201063256.GE32462@lukather>
Message-ID: <56B0B1AE.2060502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01/02/16 06:32, Maxime Ripard wrote:
> Hi Andre,
> 
> On Wed, Jan 27, 2016 at 11:51:45PM +0000, Andr? Przywara wrote:
>> Hi,
>>
>> On 18/01/16 14:28, Lee Jones wrote:
>>> This call matches clocks which have been marked as critical in DT
>>> and sets the appropriate flag.  These flags can then be used to
>>> mark the clock core flags appropriately prior to registration.
>>
>> I like the idea of having a generic property very much. Also this solves
>> a problem I have in a very elegant way.
> 
> Not really. It has a significant set of drawbacks that we already
> detailed in the initial thread, which are mostly related to the fact
> that the clocks are to be left on is something that totally depends on
> the software support in the kernel. Some clocks should be reported as
> critical because they are simply missing a driver for it, some should
> be because the driver for it as not been compiled, some should because
> we don't have the proper clocks drivers yet for one of their
> downstream clocks.
> 
> Basically, it all boils down to this: some clocks should never ever be
> shutdown because <hardware reason>, and I believe it's the case Lee is
> in. But most of the current code that would use it might, and might
> even need at some point to shut down such a clock.

I was bascically interested in pushing the critical-clock property into
DT to solve that cumbersome clk-sunxi init scheme - which you have fixed
now in a much better way (thanks for that, btw.)
For that particular case the CPU clock really looks like being actually
critical in the hardware sense - no-one maybe except the mgmt core
should turn the one single CPU clock source off.

So I wonder if we should document this "for hardware reasons only" and
still have that property in DT?
At the weekend I coded something into the generic DT clock code to let
it parse for basically every clock node - without a particular driver
needing to ask for it.
If this sounds useful to you I can post that one.

Cheers,
Andre.
> 
> Mike's solution with the flags + handover was solving all this, I'm
> not sure why he's not pushed it forward.
> 
> Maxime
> 
