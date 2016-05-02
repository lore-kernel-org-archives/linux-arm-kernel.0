From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 2 May 2016 18:16:08 +0200
Subject: [PATCH V4 1/2] clk: bcm2835: mark enabled clocks with
 CLK_IS_CRITICAL
In-Reply-To: <87zis8h3pp.fsf@eliezer.anholt.net>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
 <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
 <87zis8h3pp.fsf@eliezer.anholt.net>
Message-ID: <5CC0D984-91E5-4401-8AB6-5827269C4395@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 02.05.2016, at 17:36, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> The bcm2835 firmware enables several clocks and plls before
>> booting the linux kernel.
>> 
>> These plls should never get disabled as it may result in a
>> stopped system clock and more.
>> 
>> So during probing we check if the clock is enabled
>> and if it is then mark that clock with CLK_IS_CRITICAL.
>> 
>> As a consequence this will also enable the corresponding
>> parent plls and pll-divs.
>> 
>> This is intended as a stop-gap until CLK_ENABLE_HAND_OFF
>> becomes available, at which point it should be used instead.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> I still think that we don't want this patch.  We should be able to
> disable clocks that the firmware turned on, unless they really need to
> stay on.  If you have troubles on the upstream DT, let's talk about
> individual clocks.

May I ask you what is your main concern about using
CLK_IS_CRITICAL as a stop-gap/in general?

This is just a stop-gap until we get CLK_ENABLE_HAND_OFF merged
and I really want to use HAND_OFF as soon as possible, that is why
I have split it into 2 patches.

We essentially just replace the CLK_IS_CRITICAL with
CLK_ENABLE_HAND_OFF (plus comments and debug messages).

Any custom temporary code for specific clocks (which you propose)
is much more complicated than this simple patch and does not handle
things better in any way.

Also the current situation of the machine crashing when releasing the
PCM clock when the parent is PLLC or PLLD is worse than having some
clocks/pll running unnecessarily.

Also this is an incentive to merge HAND_OFF - there is now an
immediate user that would make immediate use of it.
