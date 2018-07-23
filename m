From: james.morse@arm.com (James Morse)
Date: Mon, 23 Jul 2018 18:04:00 +0100
Subject: [PATCH v11 11/15] arm64: kexec_file: add crash dump support
In-Reply-To: <20180723053923.GN11258@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-12-takahiro.akashi@linaro.org>
 <9efd0567-35dc-7435-74d6-1b540f3e5b9f@arm.com>
 <20180723053923.GN11258@linaro.org>
Message-ID: <8600c940-158a-f64f-8271-32f8fb40f198@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 23/07/18 06:39, AKASHI Takahiro wrote:
> On Wed, Jul 18, 2018 at 05:50:22PM +0100, James Morse wrote:
>> On 11/07/18 08:41, AKASHI Takahiro wrote:
>>> Enabling crash dump (kdump) includes
>>> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>>>   using crash_prepare_elf64_headers(), and
>>> * add two device tree properties, "linux,usable-memory-range" and
>>>   "linux,elfcorehdr", which represent respectively a memory range
>>>   to be used by crash dump kernel and the header's location
>>
>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>> index 69333694e3e2..eeb5766928b0 100644
>>> --- a/arch/arm64/include/asm/kexec.h
>>> +++ b/arch/arm64/include/asm/kexec.h
>>> @@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
>>>  struct kimage_arch {
>>>  	phys_addr_t dtb_mem;
>>>  	void *dtb_buf;
>>> +	/* Core ELF header buffer */
>>
>>> +	void *elf_headers;
>>
>> Shouldn't this be a phys_addr_t if it comes from kbuf.mem?
> 
> Do you mean elf_load_addr? You're right.
> But kexec_buf defined mem as unsigned long and so I'd rather change
> dtb_mem to unsigned long instead of elf_load_addr, which will also be
> renamed to elf_headers_mem for clarification.

>> (dtb_mem is, and they type tells us which way round the runtime/kexec-time
>> pointers are)

My preference would be for physical addresses to always be phys_addr_t, but as
long as we can easily spot the difference kexec-time versus runtime addresses,
it will save bugs where we use the wrong one.


>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>> index a0b44fe18b95..261564df7210 100644
>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>> @@ -132,6 +173,45 @@ static int setup_dtb(struct kimage *image,

>>> +		kbuf.buf_min = crashk_res.start;
>>> +		kbuf.buf_max = crashk_res.end + 1;
>>> +		kbuf.top_down = true;
>>> +
>>> +		ret = kexec_add_buffer(&kbuf);
>>> +		if (ret) {
>>> +			vfree(hdrs_addr);
>>> +			goto out_err;
>>> +		}
>>> +		image->arch.elf_headers = hdrs_addr;
>>> +		image->arch.elf_headers_sz = hdrs_sz;
>>> +		image->arch.elf_load_addr = kbuf.mem;
>>> +
>>> +		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>> +				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
>>> +	}
>>> +
>>>  	kbuf.image = image;
>>>  	/* not allocate anything below the kernel */
>>>  	kbuf.buf_min = kernel_load_addr + kernel_size;

>> I think the initramfs can escape the crash kernel range because you add to the
>> buf_max region:
>> |	/* within 1GB-aligned window of up to 32GB in size */
>> |	kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
>> |				?+ (unsigned long)SZ_1G * 32;
> 
> No worries.
> kexec_add_buffer() will limit the search only within crashk_res anyway.

via arch_kexec_walk_mem()? Got it.

But strangely the buf_min and buf_max still matter because
locate_mem_hole_callback() uses them.


> Are you reviewing other patches in my v11?
> If not, I will post v12 tomorrow.

No, (I try to batch replies to avoid that happening).
I'm reading up on Secure-boot and trying to test the pe_verification stuff...


Thanks,

James
