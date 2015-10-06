From: a.aubert@overkiz.com (Antoine Aubert)
Date: Tue, 6 Oct 2015 17:26:26 +0200
Subject: at91sam9 Main crystal frequency problems
In-Reply-To: <20151006161244.06f3ceb4@bbrezillon>
References: <55ED3D3B.8060700@overkiz.com>
 <20150908181212.0b4336f0@bbrezillon> <55F6C07C.8080803@overkiz.com>
 <20151006161244.06f3ceb4@bbrezillon>
Message-ID: <5613E822.2020004@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris

Le 06/10/2015 16:12, Boris Brezillon a ?crit :
> Hi Antoine,
> 
> On Mon, 14 Sep 2015 14:41:32 +0200
> Antoine Aubert <a.aubert@overkiz.com> wrote:
> 
>> Hi Boris,
>>
>> Thank you for your help. I have some news thanks to traces in clk driver.
> 
> Any progress regarding this problem. I think Jiri (in Cc) has pretty
> much the same problem (see this thread [1]).
> IIRC, activating NO_HZ_IDLE solved the problem for you, but have you
> find the root cause?
I'm not sure that the same issue. Here I don't have slow xtal.

What I found:
* DTB was not up to date (build with an other kernel version)
  Since we start from kexec, we added --dtb option
* slow_xtal wasn't disabled in our DTS
* defconfig was outdated

What i did first:
* updated the dts, disabled slow xtal
* Update DTB
* activating NO_HZ_IDLE

> 20d updtime without WRST

Today what I did:
* use LTS last kernel: 4.1.6
* updated the dts, disabled slow xtal
* generate config from scratch using "make ARCH=arm at91_dt_defconfig"
  (without NO_HZ_IDLE=

12h uptime, at this time no WRST


> 
> Best Regards,
> 
> Boris
> 
> [1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/413356
> 
>>
>>
>> Le 08/09/2015 18:12, Boris Brezillon a ?crit :
>>> Hi Antoine,
>>>
>>> On Mon, 7 Sep 2015 09:31:07 +0200
>>> Antoine Aubert <a.aubert@overkiz.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> I currently bring up a board based on AT91SAM9G25cu, and I having
>>>> problems of watchdogs resets.
>>>>
>>>> We use linux-4.04 mainline, and i found some weird warnings on kernel
>>>> traces, concerning main clk.
>>>>
>>>> [    0.000000] Main crystal frequency not set, using approximate value
>>>> [    0.000000] master clk is overclocked
>>>> [    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
>>>> wraps every 16777216000000000ns
>>>> [    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
>>>>
>>>> I set crystal clock in the DT, but it doesn't seems to work.. I feel
>>>> that the board works out of the specified range.
>>>
>>> According to your clk_summary dump that's not the case.
>>>
>>>>
>>>> So here comes my questions:
>>>> Can there be a relationship with watchdog problems ? (1 per day)
>>>
>>> I'd say no, but could you tell me more about your watchdog issues.
>>
>> Yet, we did not take the analysis. We just observed these resets.
>>
>> But, I found a clue:
>> We recently removed the slow clock to the PCB. I forgot to disabled the
>> slow_xtal. :/
>>  Can there be a link ? (I think so...)
>>
>>>
>>>> Why is it that the frequency of Crystal is not found ?
>>>
>>> That's a good question, and honestly I don't. Everything seems to be
>>> defined properly in your device tree.
>>>
>>> Could you add some traces in the fixed-rate clk driver [1] to see if the
>>> main_xtal is correctly registered and if its registration occurs before
>>> the main_osc registration?
>>
>> On our board, there is two kernel boot phases.
>>
>> First, we boot from at91-bootstrap.
>> Second we launched kexec with an other kernel.
>>
>> I found that the device tree is well loaded from the at91-bootstrap. Any
>> crystal issues. But, on kexec --exec, (with the same kernel) those
>> issues appears. (see dmesg attached)
>>
>> If I launch kexec with --dtb, it's working ...
>> I thought kexec keep old dtb. Was I wrong ?
>>
>>>
>>> Best Regards,
>>>
>>> Boris
>>>
>>> [1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/clk/clk-fixed-rate.c?id=refs/tags/v4.0.4#n115
>>>
>>
>> Best regards,
>> Antoine Aubert
>> a.aubert at overkiz.com
> 
> 
> 

Antoine Aubert
a.aubert at overkiz.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/b7d54765/attachment.sig>
