From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 25 Nov 2010 19:38:07 +0100
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
Message-ID: <AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Jean
>
> On Thu, 25 Nov 2010, Jean Pihet wrote:
>
>> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > The console semaphore must be held while the OMAP UART devices are
>> > disabled, lest a console write cause an ARM abort (and a kernel crash)
>> > when the underlying console device is inaccessible. ?These crashes
>> > only occur when the console is on one of the OMAP internal serial
>> > ports.
>> This does not fix the issue for me on Beagle (console on ttyO2).
>>
>> Doing:
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>> and waiting 5 seconds hangs the console.
>
> If this is without sleep_while_idle enabled, then you're seeing an
> unrelated bug that is not related to this patch. ?That's because, when
> /debug/pm_debug/sleep_while_idle is 0, the pm34xx.c code that this patch
> touches won't be reached.
Ok so we still have a problem. I understood the correct fix is to
migrate the UART code to hwmod.

> By the way, you write that the above situation "hangs the console." ?Is it
> just the case that the console dies and the rest of the system is still
> alive, or does the whole system crash?
The console hangs, the rest of the system still runs.

>> However enabling sleep_while_idle before configuring the UART2 timeout
>> makes it work ok:
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>> ? / # echo 1 > /debug/pm_debug/sleep_while_idle
>> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>>
>> This result is similar to what I tested on a recent l-o master w/o the fix.
>> Am I missing something?
>
> It may depend on your loglevel settings. ?If warning messages aren't
> emitted to the console, then you won't see this crash.
>
> Whether the system crashes also depends on whether you happen to get a new
> worst-case deactivation latency from your console serial port during PM
> idle. ?If not, and there are no other console writes after the UART is
> disabled, then this patch won't affect anything.
>
> Just FYI, without this patch, Tony's N810 crashed reliably upon entering
> dynamic idle.
'crashed reliably' ;p

>
>> One more remark. With OFF mode enabled I noticed that PER can go OFF
>> without CORE going OFF, which could trigger the errata i582. I think
>> this is another latent problem.
>
> This appears to be unrelated to the patch under discussion. ?Maybe you
> should start a separate list thread on this issue? ?We do not appear to
> have the suggested workaround sequence in the TRM in the current code.
> This workaround is quite complex. ?Someone from TI should definitely put
> together some patches to implement it.
Yes this is unrelated, let's discuss this separately.

>
>
> - Paul

Thanks,
Jean
