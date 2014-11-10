From: jan.kiszka@web.de (Jan Kiszka)
Date: Mon, 10 Nov 2014 10:36:12 +0100
Subject: AMR: sun7i: CPU hotplug support?
In-Reply-To: <546082A8.60401@arm.com>
References: <545FC215.7010802@web.de> <20141109231744.GC2989@lukather>
 <5460554A.1060701@web.de> <5460766B.8070000@web.de> <546082A8.60401@arm.com>
Message-ID: <5460870C.9010109@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-10 10:17, Marc Zyngier wrote:
> On 10/11/14 08:25, Jan Kiszka wrote:
>> On 2014-11-10 07:03, Jan Kiszka wrote:
>>> On 2014-11-10 00:17, Maxime Ripard wrote:
>>>> Hi Jan,
>>>>
>>>> On Sun, Nov 09, 2014 at 08:35:49PM +0100, Jan Kiszka wrote:
>>>>> did anyone already happen to look into enabling CPU hotplug
>>>>> for the Allwinner A20 in upstream? I'm currently running the
>>>>> sunxi-next branch on Banana Pi, and echo 0 > .../cpu1/online
>>>>> just hangs the system. The old 3.4 LeMaker kernel works fine
>>>>> in this regard. I can try to look into details and port
>>>>> things over, just want to avoid duplicate efforts.
>>>>
>>>> Having hotplug support would indeed be very welcome.
>>>>
>>>> However, it should be done in u-boot, through PSCI, and not in
>>>> the kernel itself.
>>>>
>>>> As far as I'm aware, no one worked actively on it, beside some
>>>> WIP commit from Marc a while ago: 
>>>> https://git.kernel.org/cgit/linux/kernel/git/maz/u-boot.git/commit/?h=wip/psci&id=45379c0f9cf812f0f62722f4015ec907fa5dc144
>>>
>>>
>>>>
> OK - I guess I will need a little guidance in then: Is there a good
>>> reference board to study and to derive from? And maybe also: What
>>> is missing or not working in that u-boot branch? If I get this
>>> interface right, I just takes some device tree bits to enable
>>> this for the kernel afterward, correct?
>>
>> Started to play with that patch in naive ways: CPU0 locks up when 
>> offlining CPU1 - unless I disable the FIQ signal from CPU1. Then
>> it "works", both offlining and onlining again. However, I suspect
>> that this only parks CPU1 in wfi and does not do anything
>> interesting to it.
> 
> Here's how this is supposed to work:
> - CPU1 sends a FIQ to CPU0, bringing it into secure mode.
> - CPU0 then kills CPU1 by doing the magic incantations on the power
> controller
> 
> What is missing here is all the cache cleaning before signalling CPU0.
> If you add that, things should look a lot better (patches welcome).

Unsure about this, or maybe this was too simplistic: I added calls to
u-boot's flush_dcache_all and invalidate_icache_all (right after
disabling the cache, just like the vendor kernel does), but CPU0 still
locks up. I suspect there is still a bug in the FIQ handling. There is
also a suspicious single "@" printed on the console. I'll play with the
FIQ handler a bit.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/bc1da8a2/attachment.sig>
