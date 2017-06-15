From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 16 Jun 2017 00:29:03 +0200
Subject: [PATCH v5] mm: huge-vmap: fail gracefully on unexpected huge vmap
 mappings
In-Reply-To: <20170615151637.77babb9a1b65c878f4235f65@linux-foundation.org>
References: <20170609082226.26152-1-ard.biesheuvel@linaro.org>
 <20170615142439.7a431065465c5b4691aed1cc@linux-foundation.org>
 <BE70CA51-B790-456E-B31C-399632B4DCD1@linaro.org>
 <20170615151637.77babb9a1b65c878f4235f65@linux-foundation.org>
Message-ID: <F0D43B2F-6811-4FEA-9152-75BD0792BD83@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16 Jun 2017, at 00:16, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Fri, 16 Jun 2017 00:11:53 +0200 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> 
>> 
>> 
>>>> On 15 Jun 2017, at 23:24, Andrew Morton <akpm@linux-foundation.org> wrote:
>>>> 
>>>> On Fri,  9 Jun 2017 08:22:26 +0000 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>> 
>>>> Existing code that uses vmalloc_to_page() may assume that any
>>>> address for which is_vmalloc_addr() returns true may be passed
>>>> into vmalloc_to_page() to retrieve the associated struct page.
>>>> 
>>>> This is not un unreasonable assumption to make, but on architectures
>>>> that have CONFIG_HAVE_ARCH_HUGE_VMAP=y, it no longer holds, and we
>>>> need to ensure that vmalloc_to_page() does not go off into the weeds
>>>> trying to dereference huge PUDs or PMDs as table entries.
>>>> 
>>>> Given that vmalloc() and vmap() themselves never create huge
>>>> mappings or deal with compound pages at all, there is no correct
>>>> answer in this case, so return NULL instead, and issue a warning.
>>> 
>>> Is this patch known to fix any current user-visible problem?
>> 
>> Yes. When reading /proc/kcore on arm64, you will hit an oops as soon as you hit the huge mappings used for the various segments that make up the mapping of vmlinux. With this patch applied, you will no longer hit the oops, but the kcore contents willl be incorrect (these regions will be zeroed out)
>> 
>> We are fixing this for kcore specifically, so it avoids vread() for  those regions. At least one other problematic user exists, i.e., /dev/kmem, but that is currently broken on arm64 for other reasons.
>> 
> 
> Do you have any suggestions regarding which kernel version(s) should
> get this patch?
> 

Good question. v4.6 was the first one to enable the huge vmap feature on arm64 iirc, but that does not necessarily mean it needs to be backported at all imo. What is kcore used for? Production grade stuff?
