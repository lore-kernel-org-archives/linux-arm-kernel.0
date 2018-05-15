From: james.morse@arm.com (James Morse)
Date: Tue, 15 May 2018 17:17:41 +0100
Subject: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
In-Reply-To: <20180515043538.GB2737@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
 <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
 <20180507055906.GE11326@linaro.org> <20180515043538.GB2737@linaro.org>
Message-ID: <84d5da84-81c4-d311-10e9-ba6afaf72a8e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 15/05/18 05:35, AKASHI Takahiro wrote:
> On Mon, May 07, 2018 at 02:59:07PM +0900, AKASHI Takahiro wrote:
>> On Tue, May 01, 2018 at 06:46:09PM +0100, James Morse wrote:
>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>>> We need to prevent firmware-reserved memory regions, particularly EFI
>>>> memory map as well as ACPI tables, from being corrupted by loading
>>>> kernel/initrd (or other kexec buffers). We also want to support memory
>>>> allocation in top-down manner in addition to default bottom-up.
>>>> So let's have arm64 specific arch_kexec_walk_mem() which will search
>>>> for available memory ranges in usable memblock list,
>>>> i.e. !NOMAP & !reserved, 
>>>
>>>> instead of system resource tree.
>>>
>>> Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
>>> be safe in the EFI-memory-map/ACPI-tables case?
>>>
>>> It would be good to avoid having two ways of doing this, and I would like to
>>> avoid having extra arch code...
>>
>> I know what you mean.
>> /proc/iomem or system resource is, in my opinion, not the best place to
>> describe memory usage of kernel but rather to describe *physical* hardware
>> layout. As we are still discussing about "reserved" memory, I don't want
>> to depend on it.

I agree. We have funny stuff that isn't hardware-layout, but is important for
the next boot. The kernel doesn't have an ABI to support when it queries the
list itself.


>> Along with memblock list, we will have more accurate control over memory
>> usage.

>>> If the argument is walking memblock gives a better answer than the stringy
>>> walk_system_ram_res() thing, is there any mileage in moving this code into
>>> kexec_file.c, and using it if !IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK)?
>>>
>>> This would save arm64/powerpc having near-identical implementations.
>>> 32bit arm keeps memblock if it has kexec, so it may be useful there too if
>>> kexec_file_load() support is added.

> If you don't have further objection, I will take memblock approach
> (with factoring out powerpc's arch_kexec_walk_mem()).

If we're agreed that the memblock walking is generic, then it would be quicker
to make the arm64 version as close as possible and merge them as a later series.
(saves a cross arch dependency)

With that,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
