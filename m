From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 7 Jul 2016 09:32:34 +0200
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <146783774807.35356.6362595927321996311@resonance>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
 <577D035C.7090504@arm.com> <146783774807.35356.6362595927321996311@resonance>
Message-ID: <dad950db-4c02-e5a2-0ce9-682a40cd12d7@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On 06.07.2016 22:42, Michael Turquette wrote:
> Hi Julien,
>
> Quoting Julien Grall (2016-07-06 06:10:52)
>> On 06/07/16 02:34, Michael Turquette wrote:
>>> Hi!
>>
>> Hello Michael,
>>
>>> Quoting Dirk Behme (2016-06-30 03:32:32)
>>>> Some clocks might be used by the Xen hypervisor and not by the Linux
>>>> kernel. If these are not registered by the Linux kernel, they might be
>>>> disabled by clk_disable_unused() as the kernel doesn't know that they
>>>> are used. The clock of the serial console handled by Xen is one
>>>> example for this. It might be disabled by clk_disable_unused() which
>>>> stops the whole serial output, even from Xen, then.
>>>
>>> This whole thread had me confused until I realized that it all boiled
>>> down to some nomenclature issues (for me).
>>>
>>> This code does not _register_ any clocks. It simply gets them and
>>> enables them, which is what every other clk consumer in the Linux kernel
>>> does. More details below.
>>>
>>>>
>>>> Up to now, the workaround for this has been to use the Linux kernel
>>>> command line parameter 'clk_ignore_unused'. See Xen bug
>>>>
>>>> http://bugs.xenproject.org/xen/bug/45
>>>
>>> clk_ignore_unused is a band-aid, not a proper medical solution. Setting
>>> that flag will not turn clocks on for you, nor will it guarantee that
>>> those clocks are never turned off in the future. It looks like you
>>> figured this out correctly in the patch below but it is worth repeating.
>>>
>>> Also the new CLK_IS_CRITICAL flag might be of interest to you, but that
>>> flag only exists as a way to enable clocks that must be enabled for the
>>> system to function (hence, "critical") AND when those same clocks do not
>>> have an accompanying Linux driver to consume them and enable them.
>>
>> I don't think we want the kernel to enable the clock for the hypervisor.
>> We want to tell the kernel "don't touch at all to this clock, it does
>> not belong to you".
>
> But the patch *does* touch the clock from the kernel. It enables the
> clock via a call clk_prepare_enable. I'm utterly confused.


Maybe we need some advice here :)


I've used clk_prepare_enable() 'just' to get the enable count incremented

http://lxr.free-electrons.com/source/drivers/clk/clk.c#L751

Because it's my understanding that enable_count is needed to prevent 
clk_disable_unused() from disabling the clock.


If there is an other / better / correct way to achieve that, please let 
us know.


I've had a look to use the CLK_IGNORE_UNUSED flag, too. But couldn't 
find a function exported by the clock framework to set that flag (?)


Best regards

Dirk
