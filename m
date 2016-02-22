From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 22 Feb 2016 09:39:28 -0600
Subject: [PATCH v3 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <CAKv+Gu8YYuE78QAzgFFZgPOz4o_4L70Ko-vO-GKwSFeYdNv+vA@mail.gmail.com>
References: <1455903983-23910-1-git-send-email-jeremy.linton@arm.com>
 <1455903983-23910-3-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu8YYuE78QAzgFFZgPOz4o_4L70Ko-vO-GKwSFeYdNv+vA@mail.gmail.com>
Message-ID: <56CB2BB0.8030409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2016 04:28 AM, Ard Biesheuvel wrote:
> On 19 February 2016 at 18:46, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> With 64k pages, the next larger segment size is 512M. The linux
>> kernel also uses different protection flags to cover its code and data.
>> Because of these requirements, the vast majority of the kernel code and
>> data structures end up being mapped with 64k pages instead of the larger
>> pages common with a 4k page kernel.
>>
>> Recent ARM processors support a contiguous bit in the
>> page tables which allows a TLB to cover a range larger than a
>> single PTE if that range is mapped into physically contiguous
>> RAM.
>>
>> So, for the kernel its a good idea to set this flag. Some basic
>> micro benchmarks show it can significantly reduce the number of
>> L1 dTLB refills.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>
> Tested on 4k/3 levels, and the page tables look correct to me
>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks,

>
> You didn't answer my question though, regarding implementing this at
> the PMD level for 16k pages kernels, so that we can use 1 GB chunks
> for mapping system RAM. Would that just be a matter of doing the exact
> same thing at the PMD level? Or is it more complicated than that?
>

AFAIK, yes. It should be similar with the PMD ranges being unmarked on 
permission change or PTE allocation.
