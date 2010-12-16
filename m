From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 16 Dec 2010 15:39:13 +0100
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
In-Reply-To: <AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
References: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
	<20101216115657.GP9937@n2100.arm.linux.org.uk>
	<AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
Message-ID: <AANLkTink3TJonOC+cnpRUKKu9_+OBhJKDQ25yvrZZsrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 1:47 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On 16 December 2010 11:56, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Dec 16, 2010 at 12:49:43PM +0100, Jean Pihet wrote:
>>> The following warning is issued by the compiler (gcc version 4.4.1
>>> (Sourcery G++ Lite 2010q1-202):
>>> arch/arm/mach-omap2/sleep34xx.S:87: Warning: swp{b} use is deprecated
>>> for this architecture
>>>
>>> Does this need fixing? If so any hint on how to do it?
>>>
>>> Here is the offending code excerpt:
>>>
>>> wait_sem:
>>> ? ? ? ? mov ? ? r0,#1
>>> ? ? ? ? ldr ? ? r1, sdrc_scratchpad_sem
>>> wait_loop:
>>> ? ? ? ? ldr ? ? r2, [r1] ? ? ? ?@ load the lock value
>>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ is the lock free ?
>>> ? ? ? ? beq ? ? wait_loop ? ? ? @ not free...
>>> ? ? ? ? swp ? ? r2, r0, [r1] ? ?@ semaphore free so lock it and proceed
>>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ did we succeed ?
>>> ? ? ? ? beq ? ? wait_sem ? ? ? ?@ no - try again
>>
>> (untested, as my LDP is useless because of OMAP regressions.)
>>
>> wait_sem:
>> ? ? ? ?mov ? ? r0, #1
>> ? ? ? ?ldr ? ? r1, sdrc_scratchpad_sem
>> wait_loop:
>> ? ? ? ?ldrex ? r2, [r1] ? ? ? ?@ load lock value
>> ? ? ? ?teq ? ? r2, r0 ? ? ? ? ?@ is lock free ( != 1)
>> ? ? ? ?beq ? ? wait_loop ? ? ? @ no, try again
>> ? ? ? ?strex ? r2, r0, [r1] ? ?@ try to lock
>> ? ? ? ?teq ? ? r2, #0 ? ? ? ? ?@ did store succeed?
>> ? ? ? ?bne ? ? wait_loop ? ? ? @ no, try again
>
> I'm not familiar with the OMAP code but I recall they needed swp for
> some synchronisation with external processor (DSP). Is this still the
> case?
This code is meant to be used by the new DVFS code which is not merged in yet.

Richard, Karthik,
Can you help on that point?

Thanks,
Jean
>
> --
> Catalin
>
