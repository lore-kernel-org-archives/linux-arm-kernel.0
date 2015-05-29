From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 12:30:36 -0700
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <20150528224828.GI24204@codeaurora.org>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
 <55679085.6040402@wwwdotorg.org> <20150528224828.GI24204@codeaurora.org>
Message-ID: <87k2vrchb7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 05/28, Stephen Warren wrote:
>> On 05/18/2015 01:43 PM, Eric Anholt wrote:
>> > Unfortunately, the clock manager's registers are not accessible by the
>> > ARM, so we have to request that the firmware modify our clocks for us.
>> > 
>> > This driver only registers the clocks at the point they are requested
>> > by a client driver.  This is partially to support returning
>> > -EPROBE_DEFER when the firmware driver isn't supported yet, but it
>> > also avoids issues with disabling "unused" clocks due to them not yet
>> > being connected to their consumers in the DT.
>> 
>> It looks like you forgot to CC the clock subsystem maintainers:
>> 
>> M:      Mike Turquette <mturquette@linaro.org>
>> M:      Stephen Boyd <sboyd@codeaurora.org>
>> 
>
> Thanks, except I don't have the full patch context here to review
> the patch.
>
>> The description above sounds like a neat solution, but has the
>> disadvantage that the clocks without a client won't show up in debugfs.
>> I wonder if the clock maintainers know of a better way?
>
> Can you mark them as CLK_IGNORE_UNUSED? The probe defer problem
> has a solution in sight (see more below).

>> > +	init.flags = CLK_IS_ROOT;
>> 
>> Is it possible to add clock parent information to the driver, so the
>> clocks are all hooked together into the correct tree, rather than all
>> looking like root clocks?
>> 
>> One of the many reasons I didn't do anything FW-wise for the kernel was
>> the hope that such information would be forthcoming, and hence we could
>> have complete kernel drivers.
>> 
>> > +void __init rpi_firmware_init_clock_provider(struct device_node *node)
>> > +{
>> > +	/* We delay construction of our struct clks until get time,
>> > +	 * because we need to be able to return -EPROBE_DEFER if the
>> > +	 * firmware driver isn't up yet.  clk core doesn't support
>> > +	 * re-probing on -EPROBE_DEFER, but callers of clk_get can.
>> 
>> Oh, that's nasty. What would it take to fix the clock core to support
>> deferred probe? It really should.
>
> There are patches to support probe defer from clk_get() but they
> stalled because sunxi is needs to keep clocks on from their
> providing driver (termed "critical clocks"). If we can resolve
> the "critical clocks" thing then we should be able to support
> probe defer, unless we find other users of orphaned clk
> pointers.

Great!  I'm certainly happy to switch to a normal registration of all my
clocks once -EPROBE_DEFER works from the clock provider init.

If those patches aren't landing this release, that also gives us a
release to wire up all the clock consumers in the DT before we get hit
by stable DT ABI, so we'll be able to give a nice limited set of
CLOCK_IGNORE_UNUSED in the flags when we transition.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/f0a794cb/attachment.sig>
