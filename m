From: eric@anholt.net (Eric Anholt)
Date: Mon, 02 May 2016 18:13:09 -0700
Subject: [PATCH V4 1/2] clk: bcm2835: mark enabled clocks with
 CLK_IS_CRITICAL
In-Reply-To: <5CC0D984-91E5-4401-8AB6-5827269C4395@martin.sperl.org>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
 <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
 <87zis8h3pp.fsf@eliezer.anholt.net>
 <5CC0D984-91E5-4401-8AB6-5827269C4395@martin.sperl.org>
Message-ID: <87wpncueoq.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 02.05.2016, at 17:36, Eric Anholt <eric@anholt.net> wrote:
>> 
>> kernel at martin.sperl.org writes:
>> 
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>> 
>>> The bcm2835 firmware enables several clocks and plls before
>>> booting the linux kernel.
>>> 
>>> These plls should never get disabled as it may result in a
>>> stopped system clock and more.
>>> 
>>> So during probing we check if the clock is enabled
>>> and if it is then mark that clock with CLK_IS_CRITICAL.
>>> 
>>> As a consequence this will also enable the corresponding
>>> parent plls and pll-divs.
>>> 
>>> This is intended as a stop-gap until CLK_ENABLE_HAND_OFF
>>> becomes available, at which point it should be used instead.
>>> 
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> 
>> I still think that we don't want this patch.  We should be able to
>> disable clocks that the firmware turned on, unless they really need to
>> stay on.  If you have troubles on the upstream DT, let's talk about
>> individual clocks.
>
> May I ask you what is your main concern about using
> CLK_IS_CRITICAL as a stop-gap/in general?

Burning power when you shouldn't, which is a bug.

> Also the current situation of the machine crashing when releasing the
> PCM clock when the parent is PLLC or PLLD is worse than having some
> clocks/pll running unnecessarily.

Are you saying this happens on the upstream kernel?  This sounds like a
bug you'd see in the downstream kernel because they haven't hooked up
the clocks in their DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/a6e893d2/attachment.sig>
