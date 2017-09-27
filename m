From: rruigrok@codeaurora.org (Richard Ruigrok)
Date: Wed, 27 Sep 2017 12:00:06 -0600
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <20170927155007.GA16211@arm.com>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
 <20170925105335.GA24042@arm.com>
 <20170925140240.vl5mvbce5lb37dxe@yury-thinkpad>
 <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
 <a3b714ae-97a5-8458-9bf7-140eeeebc4b9@codeaurora.org>
 <20170926102324.GC8693@arm.com>
 <547ed590-3ab4-cc11-cbea-f587541d2b08@codeaurora.org>
 <20170926173112.GA16650@arm.com> <20170927155007.GA16211@arm.com>
Message-ID: <38058a06-1c8a-015c-cb9d-1c1b17a1edf3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/27/2017 9:50 AM, Will Deacon wrote:
> On Tue, Sep 26, 2017 at 06:31:12PM +0100, Will Deacon wrote:
>> On Tue, Sep 26, 2017 at 08:23:35AM -0600, Ruigrok, Richard wrote:
>>> On 9/26/2017 4:23 AM, Will Deacon wrote:
>>>> On Mon, Sep 25, 2017 at 01:54:57PM -0600, Ruigrok, Richard wrote:
>>>>> I also found this issue with kernels from 4.11 through 4.13.  In my tests, I
>>>>> found that it reproduces only with 4K page and Transparent Huge Pages. With 64K
>>>>> page I was not able to reproduce. RH also reported it here: https://
>>>>> bugzilla.redhat.com/show_bug.cgi?id=1491504 Linaro reported on the RPK kernel
>>>>> (4.12) on Centriq2400 and ThunderX
>>>>>  
>>>>>
>>>>> https://bugs.linaro.org/show_bug.cgi?id=3191
>>>>>
>>>>> https://bugs.linaro.org/show_bug.cgi?id=3068.
>>>> These two aren't the same bug (that's a forward progress issue that we're
>>>> currently working on). I don't have permission to look at the redhat one,
>>>> but is it just an RCU stall or actually the Oops reported by Yury?
>>>>
>>>>> I was able to bisect down to a specific commit.
>>>> I think we're chasing two different things here, so not sure I trust the
>>>> bisect!
>>>>
>>> The RCU stall is side effect.? The issue I'm seeing has the same stack
>>> trace and same stimulus (rwtest).? Following are the details.
>> FWIW, I think I've worked out what's going on here and I should have a patch
>> tomorrow.
> Diff below. I'm going to follow up with a separate thread about this,
> because the proper fix is going to be invasive. I'll keep you on cc.
>
> Out of curiosity: what version of GCC are you using to compile the kernel?
I'm using gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu
Thanks for the patch, test results to follow.
Richard
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index bc4e92337d16..b46e54c2399b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -401,7 +401,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  /* Find an entry in the third-level page table. */
>  #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
>  
> -#define pte_offset_phys(dir,addr)	(pmd_page_paddr(*(dir)) + pte_index(addr) * sizeof(pte_t))
> +#define pte_offset_phys(dir,addr)	(pmd_page_paddr(READ_ONCE(*(dir))) + pte_index(addr) * sizeof(pte_t))
>  #define pte_offset_kernel(dir,addr)	((pte_t *)__va(pte_offset_phys((dir), (addr))))
>  
>  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
