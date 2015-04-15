From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 15 Apr 2015 10:27:55 -0700
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150415120738.GD2866@leverpostej>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk> <552C14F0.7020006@oracle.com>
 <20150415120738.GD2866@leverpostej>
Message-ID: <552E9F9B.2040400@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/15/2015 5:07 AM, Mark Rutland wrote:
> Hi,
>
[..]

>>>>> +ENTRY(lpae_pgtables_remap_asm)
>>>>> +       stmfd   sp!, {r4-r8, lr}
>>>>> +
>>>>> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
>>>>> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
>>>>> +       mcr     p15, 0, ip, c1, c0, 0
>>>>> +       dsb
>>>>> +       isb
>>>>
>>>> Shouldn't the DSB be between the STMFD and the MCR (given the SP doesn't
>>>> point to an idmap/physical address)?
>>>>
>>>> I don't see why we need a DSB after the write to the SCTLR.
>>>>
>> dsb can be moved up after stmfd but leaving as above should be fine
>> as well.
>
> I don't think that it's safe to leave it where it is. Currently the
> STMFD could be reordered w.r.t. the cp15 accesses, and hence the write
> may occur with translation disabled (and would go to the wrong physical
> address).
>
> We need to ensure that the STMFD is executed before the MCR potentially
> changes the execution context. The DSB will ensure that in addition to
> ensuring completion of the write (i.e. it isn't left sat in a write
> buffer).
>
I see your point. Thanks for expanding it.

Regards,
Santosh
