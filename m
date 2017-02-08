From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Wed, 8 Feb 2017 10:30:37 -0700
Subject: [PATCH v3 06/10] arm64: efi: add EFI stub
In-Reply-To: <20170208170305.GI15459@leverpostej>
References: <1396637113-22790-1-git-send-email-leif.lindholm@linaro.org>
 <1396637113-22790-7-git-send-email-leif.lindholm@linaro.org>
 <CAOZdJXWU1dmFfCc88RMp3SvouU7roDiJsA=3aHzwijwhMH7naA@mail.gmail.com>
 <E4BDBC23-A96A-4D84-B7EE-B7967D4E4DDD@linaro.org>
 <73a460e5-98f5-86c2-142f-a9a084ee0203@codeaurora.org>
 <20170208170305.GI15459@leverpostej>
Message-ID: <a39d60da-ff74-0bcb-4a02-05cb41e58fa5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/8/2017 10:03 AM, Mark Rutland wrote:
> On Wed, Feb 08, 2017 at 10:35:02AM -0600, Timur Tabi wrote:
>> On 02/08/2017 10:29 AM, Ard Biesheuvel wrote:
>>>>>>> +       status = handle_cmdline_files(sys_table, image, cmdline_ptr,
>>>>>>> +                                     "initrd=", dram_base + SZ_512M,
>>>>>>> +                                     (unsigned long *)&initrd_addr,
>>>>>>> +                                     (unsigned long *)&initrd_size);
>>>>>
>>>>> So I know this patch is almost three years old, but why is there a
>>>>> 512M limit on the initrd size?
>>>>>
>>> How do you reckon this constitutes a limit?
>>
>> handle_cmdline_files() calls efi_high_alloc() with that limit.  I'm
>> still trying to understand all the details myself, but apparently
>> our firmware and initrd need to fit within the first 512MB because
>> of dram_base + SZ_512M. When we change "dram_base + SZ_512M" to
>> "~0", everything works.
>
> Just to check, how big is that initrd?
>
> I guess it's possible that there simply isn't sufficient contiguous free
> memory in that range, even if the initrd isn't that large. Can you share
> the EFI memory map dump from booting with efi=debug?
>
> We originally needed to restrict this to ensure that the kernel could
> map the initrd (and I think the 512M restriction specifically was
> inherited from the DTB mapping restriction). Since then, we have relaxed
> things in the kernel, and today Documentation/arm64/booting.txt says:
>
> 	If an initrd/initramfs is passed to the kernel at boot, it must
> 	reside entirely within a 1 GB aligned physical memory window of
> 	up to 32 GB in size that fully covers the kernel Image as well.
>
> ... so I think the EFI stub should be able to take advantage of that
> relaxation.

I agree.  The wrinkle I can see in this is it looks like KASLR can put 
the kernel anywhere in RAM.  How do we ensure initrd is within 32GB of 
the kernel on a system with 256 GB of RAM?

>
> Ard?
>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
