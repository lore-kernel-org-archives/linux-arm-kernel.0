From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 11:11:42 +0200
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <20120925053542.GK14266@lunn.ch>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1348531338-16624-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120925053542.GK14266@lunn.ch>
Message-ID: <5061754E.9050204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 07:35 AM, Andrew Lunn wrote:
> On Tue, Sep 25, 2012 at 02:02:17AM +0200, Sebastian Hesselbarth wrote:
>> The watchdog on dove requires an interrupt that is not yet
>> available on DT. Therefore, the watchdog DT node is removed
>> until the corresponding chained intc is available.
>
> Just for my understanding: Is the problem here:
>
> 	/* Clear watchdog timer interrupt */
> 	reg = readl(BRIDGE_CAUSE);
> 	reg&= ~WDT_INT_REQ;
> 	writel(reg, BRIDGE_CAUSE);
>
> I ask, because there is no need to pass an interrupt in the DT node.
>
> It is clear to me that bit of code above needs cleaning up sometime
> soon.

Andrew,

maybe I mixed up wdt and rtc here. It's not a big deal as wdt isn't
used at all on dove. Passing the irq on DT will require proper irq handler
for the bridge irqs. I had a discussion about chained irq vs shared irq
handlers a while ago with Gregory to reuse mvebu code for dove and I
finally implemented a chained irq for the bridge irqs.

I am not sure how wdt is implemented on Armada 370/XP but AFAIK they
don't have a bridge irq cause register. But having a chained irq handler
for the bridge irqs and power management irqs on dove will allow to share
wdt and rtc on dove and kirkwood and maybe even allow us to share the timer
with armada 370/xp.

I didn't try to post all the dove on mach-mvebu patches in the current
release cycle, because mach-mvebu is still evolving to fast for me to keep
up with my limited spare time. But I have dove running on mach-mvebu...

Sebastian
