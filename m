From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 02 Apr 2015 16:48:51 +0900
Subject: [PATCH 0/5] arm64: add kdump support
In-Reply-To: <551CDB2A.5060604@redhat.com>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <551C1537.2030009@redhat.com> <551C7EF5.9030806@linaro.org>
 <551CCC67.1040607@redhat.com> <551CD58E.60807@linaro.org>
 <551CDB2A.5060604@redhat.com>
Message-ID: <551CF463.9060702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2015 03:01 PM, Pratyush Anand wrote:
>
>
> On Thursday 02 April 2015 11:07 AM, AKASHI Takahiro wrote:
>> Pratyush,
>>
>> On 04/02/2015 01:58 PM, Pratyush Anand wrote:
>>>
>>>
>>> On Thursday 02 April 2015 04:57 AM, AKASHI Takahiro wrote:
>>>> Please try my latest kexec-tools in my linaro repo (branch name is
>>>> kdump/v0.11)
>>>> and let me know the result.
>>>
>>> Thanks a lot.. Just fetched your repo and found v.0.11.
>>>
>>> With this crash kernel loaded successfully, if I do not use initrd.
>>>
>>> With following I still see Overlapping memory segments
>>>
>>> kexec -p  /home/panand/work/kernel/bsa2_kdump/vmlinux
>>> --initrd=/boot/initramfs-3.19.0.bz1198945+.img --append="$( cat
>>> /proc/cmdline ) maxcpus=1 mem=64M reset_devices"
>>
>> How big is your initrd?
>> If it is good small, please tell me segments info, or messages from
>> add_segment_phys_virt()
>> for all the segments.
>>
>
> add_segment_phys_virt: 000000000dcd0b90 - 000000000dcd0f90 (00000400) -> 00000040c3ff0000 - 00000040c4000000 (00010000)
> add_segment_phys_virt: 000003ff88c10010 - 000003ff8984a010 (00c3a000) -> 00000040c0080000 - 00000040c1310000 (01290000)
> add_segment_phys_virt: 000000000dcd53c0 - 000000000dcd96b8 (000042f8) -> 00000040c0000000 - 00000040c0010000 (00010000)
> add_segment_phys_virt: 000003ff87360010 - 000003ff88bfcc2f (0189cc1f) -> 00000040c0010000 - 00000040c18b0000 (018a0000)
> Overlapping memory segments at 0x40c18b0000
> sort_segments failed
>
> Why do we try to fit dtb just after crash_reserved_mem.start. Should n't it should start after crash_reserved_mem.start
> + arm64_mem.text_offset + arm64_mem.image_size

Yeah, worth considering :)

-Takahiro AKASHI

>
> I tried following and it works perfectly:
>
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> index 41266f294589..75f4e4d269ca 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -312,5 +312,6 @@ void set_crash_entry(struct mem_ehdr *ehdr, struct kexec_info *info)
>   off_t locate_dtb_in_crashmem(struct kexec_info *info, off_t dtb_size)
>   {
>          return locate_hole(info, dtb_size, 128UL * 1024,
> -               crash_reserved_mem.start, crash_reserved_mem.end, 1);
> +               crash_reserved_mem.start + arm64_mem.text_offset +
> +               arm64_mem.image_size, crash_reserved_mem.end, 1);
>   }
>
> With this changes new allocations are:
> add_segment_phys_virt: 0000000010350b90 - 0000000010350f90 (00000400) -> 00000040c3ff0000 - 00000040c4000000 (00010000)
> add_segment_phys_virt: 000003ff7ad70010 - 000003ff7b9aa010 (00c3a000) -> 00000040c0080000 - 00000040c1310000 (01290000)
> add_segment_phys_virt: 00000000103553c0 - 00000000103596b8 (000042f8) -> 00000040c1360000 - 00000040c1370000 (00010000)
> add_segment_phys_virt: 000003ff794c0010 - 000003ff7ad5cc2f (0189cc1f) -> 00000040c1370000 - 00000040c2c10000 (018a0000)
> add_segment_phys_virt: 00000000103596c0 - 0000000010360190 (00006ad0) -> 00000040c2c10000 - 00000040c2c20000 (00010000)
>
>
> Crash kernel loaded upon panic.
>
> ~Pratyush
