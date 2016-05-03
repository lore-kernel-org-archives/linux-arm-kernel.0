From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 3 May 2016 07:07:11 +0200
Subject: [PATCH V4 1/2] clk: bcm2835: mark enabled clocks with
 CLK_IS_CRITICAL
In-Reply-To: <87wpncueoq.fsf@eliezer.anholt.net>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
 <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
 <87zis8h3pp.fsf@eliezer.anholt.net>
 <5CC0D984-91E5-4401-8AB6-5827269C4395@martin.sperl.org>
 <87wpncueoq.fsf@eliezer.anholt.net>
Message-ID: <399371FE-CC25-469C-9917-FDFCDA741D56@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 03.05.2016, at 03:13, Eric Anholt <eric@anholt.net> wrote:
> 
> Martin Sperl <kernel@martin.sperl.org> writes:
> 
>>> On 02.05.2016, at 17:36, Eric Anholt <eric@anholt.net> wrote:
>>> 
>>> kernel at martin.sperl.org writes:
>>> 
>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>> 
>>>> The bcm2835 firmware enables several clocks and plls before
>>>> booting the linux kernel.
>>>> 
>>>> These plls should never get disabled as it may result in a
>>>> stopped system clock and more.
>>>> 
>>>> So during probing we check if the clock is enabled
>>>> and if it is then mark that clock with CLK_IS_CRITICAL.
>>>> 
>>>> As a consequence this will also enable the corresponding
>>>> parent plls and pll-divs.
>>>> 
>>>> This is intended as a stop-gap until CLK_ENABLE_HAND_OFF
>>>> becomes available, at which point it should be used instead.
>>>> 
>>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>> 
>>> I still think that we don't want this patch.  We should be able to
>>> disable clocks that the firmware turned on, unless they really need to
>>> stay on.  If you have troubles on the upstream DT, let's talk about
>>> individual clocks.
>> 
>> May I ask you what is your main concern about using
>> CLK_IS_CRITICAL as a stop-gap/in general?
> 
> Burning power when you shouldn't, which is a bug.
It is a bug, but it is better than a crash that happens currently
because of a stopped clock.
Also there is a proposed way forward when hand-off
becomes available.

> 
>> Also the current situation of the machine crashing when releasing the
>> PCM clock when the parent is PLLC or PLLD is worse than having some
>> clocks/pll running unnecessarily.
> 
> Are you saying this happens on the upstream kernel?  This sounds like a
> bug you'd see in the downstream kernel because they haven't hooked up
> the clocks in their DT.
This happens for both upstream and downstream when using
cprman...

You remember the main-uart crashing discussion (when 
loaded as a module or not used as the kernel console?) it is
exactly what an unclaimed clock is triggering when the clock
Is prepared/enabled and then released.

I have also seen the same issue happen with PCM without
the patch - as soon as we request a frequency which will use
pllc/d-per as the parent, and we later release the clock the
system crashes -  but there only if we run the dt with minimal
clocks using cprman, as it is hidden as soon as you increase enable
count of the plls because of an enabled clock by a different
device that also consumes the same pll.

So this bug is mostly hidden behind the complete dts that
just consumes lots of parent clocks, but it still may occur 
when we select a frequency that will select the firmware 
enabled but not claimed plla_per - no idea what stopping
that pll would trigger in the system.

Hence we need this patch for the running clocks , but we
also need it for the pll_divs, so actually my patch is
incomplete!
