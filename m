From: eric@anholt.net (Eric Anholt)
Date: Mon, 02 May 2016 18:09:22 -0700
Subject: [PATCH 2/2] clk: bcm2835: Skip PLLC clocks when deciding on a new
 clock parent
In-Reply-To: <FB575328-E891-4ECC-B0D5-E7243CDEE44E@martin.sperl.org>
References: <1461699585-6649-1-git-send-email-eric@anholt.net>
 <1461699585-6649-2-git-send-email-eric@anholt.net>
 <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
 <878tzsiilh.fsf@eliezer.anholt.net>
 <FB575328-E891-4ECC-B0D5-E7243CDEE44E@martin.sperl.org>
Message-ID: <87zis8uev1.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 02.05.2016, at 17:29, Eric Anholt <eric@anholt.net> wrote:
>> 
>> Martin Sperl <kernel@martin.sperl.org> writes:
>> 
>>>> On 26.04.2016, at 21:39, Eric Anholt <eric@anholt.net> wrote:
>>>> 
>>>> If the firmware had set up a clock to source from PLLC, go along with
>>>> it.  But if we're looking for a new parent, we don't want to switch it
>>>> to PLLC because the firmware will force PLLC (and thus the AXI bus
>>>> clock) to different frequencies during over-temp/under-voltage,
>>>> without notification to Linux.
>>>> 
>>>> On my system, this moves the Linux-enabled HDMI state machine and DSI1
>>>> escape clock over to plld_per from pllc_per.  EMMC still ends up on
>>>> pllc_per, because the firmware had set it up to use that.
>>>> 
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
>>>> ?
>>> 
>>> I guess this patch looks to me as if it is a policy inside the kernel,
>>> which is AFAIK frowned upon.
>> 
>> Can you come up with a use for putting peripherals on PLLC ever, such
>> that we need choice?
>
> For PLLC not right now, but with clk_notifier_register drivers could
> work around those clock changes (assuming we get that information
> from the firmware somehow - or if we could move this decision into the
> kernel: even better).

Why would you want to automatically choose an unstable clock instead of
the stable clock we have available?

> But I can come up with a scenario that would make use of the pllh_aux
> under some circumstances - e.g when requesting 290039Hz on clock gp0/1/2.
>
> Similarly: if we ever enable the testdebugX clocks these become immediate
> candidates for parent-clocks as well which can result in more headache.

How are you planning to make use of the testdebug inputs?  As far as I
know, those are for bit-banging your clocks during hardware bringup
debugging.  They wouldn't be clocks you'd automatically choose.

> Being able to define which clocks to use at least give the dts author
> a means also to control clock selection if he wants to enable the
> testdebug clocks.

If you were to clock-assigned-parents something to PLLC, this code won't
override that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/6df893d2/attachment.sig>
