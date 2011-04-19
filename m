From: mbohan@codeaurora.org (Michael Bohan)
Date: Tue, 19 Apr 2011 15:34:47 -0700
Subject: MT_HIGH_VECTOR mapping set read-only creating illegal access
In-Reply-To: <alpine.LFD.2.00.1104122308400.28032@xanadu.home>
References: <4DA4F170.4020009@codeaurora.org>
	<alpine.LFD.2.00.1104122308400.28032@xanadu.home>
Message-ID: <4DAE0E07.9030806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2011 8:31 PM, Nicolas Pitre wrote:
> On Tue, 12 Apr 2011, Michael Bohan wrote:
> If set_tls() writes to 0xffff0ff0 in your case, then you must have an
> ARM core which is prior ARMv6k.

Actually, no, but for historical reasons we were not using the hwreg TLS 
support for all configurations. Our libc expected the data at this address.

>> Is there a reason this mapping must be read-only?
>
> It is read-only for user space to prevent user space from messing with
> the vector table.
>
> In the kernel, it is read-only _only_ when CONFIG_CPU_USE_DOMAINS is not
> enabled which may happen with ARMv6k and above.  Otherwise, if you are
> pre ARMv6k, you do use domains, and then the vector page is read-write
> for the kernel.

Yes, this seems to be the the key. In previous versions the kernel was 
given this privilege unconditionally in arch/arm/mm/proc-macros.S.

>> Perhaps we could apply write
>> access for these special cases only?
>
> I'd rather suggest you investigate what changes you did to your kernel
> tree that would explain the apparent inconsistency in your kernel
> config.

Yes, the inconsistency was on our end. We will revert all hacks and 
mandate that our libc do things correctly.

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
