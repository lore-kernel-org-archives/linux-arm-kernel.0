From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 16 Dec 2010 18:16:51 +0100
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
In-Reply-To: <6188477658179778436@unknownmsgid>
References: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
	<20101216115657.GP9937@n2100.arm.linux.org.uk>
	<AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
	<AANLkTink3TJonOC+cnpRUKKu9_+OBhJKDQ25yvrZZsrQ@mail.gmail.com>
	<6188477658179778436@unknownmsgid>
Message-ID: <AANLkTinL3oonBvkZwZFr=Wh2m_EYQ1WVudV9cxNqKRBx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Dec 16, 2010 at 6:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Jean,
>
>> >>> Here is the offending code excerpt:
>> >>>
>> >>> wait_sem:
>> >>> ? ? ? ? mov ? ? r0,#1
>> >>> ? ? ? ? ldr ? ? r1, sdrc_scratchpad_sem
>> >>> wait_loop:
>> >>> ? ? ? ? ldr ? ? r2, [r1] ? ? ? ?@ load the lock value
>> >>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ is the lock free ?
>> >>> ? ? ? ? beq ? ? wait_loop ? ? ? @ not free...
>> >>> ? ? ? ? swp ? ? r2, r0, [r1] ? ?@ semaphore free so lock it and proceed
>> >>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ did we succeed ?
>> >>> ? ? ? ? beq ? ? wait_sem ? ? ? ?@ no - try again
>> >>
>> >> (untested, as my LDP is useless because of OMAP regressions.)
>> >>
>> >> wait_sem:
>> >> ? ? ? ?mov ? ? r0, #1
>> >> ? ? ? ?ldr ? ? r1, sdrc_scratchpad_sem
>> >> wait_loop:
>> >> ? ? ? ?ldrex ? r2, [r1] ? ? ? ?@ load lock value
>> >> ? ? ? ?teq ? ? r2, r0 ? ? ? ? ?@ is lock free ( != 1)
>> >> ? ? ? ?beq ? ? wait_loop ? ? ? @ no, try again
>> >> ? ? ? ?strex ? r2, r0, [r1] ? ?@ try to lock
>> >> ? ? ? ?teq ? ? r2, #0 ? ? ? ? ?@ did store succeed?
>> >> ? ? ? ?bne ? ? wait_loop ? ? ? @ no, try again
>> >
>> > I'm not familiar with the OMAP code but I recall they needed swp for
>> > some synchronisation with external processor (DSP). Is this still the
>> > case?
>> This code is meant to be used by the new DVFS code which is not merged in yet.
>
> I don't know what you do with this lock held or what the contention
> is like, but you probably want a memory barrier immediately after you've
> acquired it and another one before you release it.
OK, thanks for the suggestion.

Since this code is not used at the moment it will be removed.
It shall be added back, fixed and tested later when the API will be in real use.

Thanks,
Jean

>
> Will
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
