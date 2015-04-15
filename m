From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Apr 2015 12:01:12 +0200
Subject: [PATCH] efi: stub: use a pool allocation for the cmdline
In-Reply-To: <20150415095506.GA4804@codeblueprint.co.uk>
References: <1428670569-23089-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAFECyb9efREE=BU5RGSbzAGHqi5CkivUuTf=BRdq02GvFqJaOA@mail.gmail.com>
 <CAKv+Gu-KHpSWLKOgA7UW8C6L1-K3dOieNmF2=qq_t5N73u3Spg@mail.gmail.com>
 <20150415095506.GA4804@codeblueprint.co.uk>
Message-ID: <CAKv+Gu-Gcie0-voFTwjsbz1Z0tGfY-fwjfsNausAwRBfQknNQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2015 at 11:55, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Fri, 10 Apr, at 07:14:34PM, Ard Biesheuvel wrote:
>>
>> It is not such a big deal: the memory is reclaimed anyway, I was just
>> trying to reduce the fragmentation a bit, and trying to avoid
>> efi_xxx_alloc() which are substantially heavier than calling
>> allocate_pool() or allocate_pages() directly.
>
> Out of curiosity, do you have any runtime numbers to backup the claim
> that allocate_*() is substantially more lightweight?
>

No, I do not. But since efi_[high|low]_alloc() call
efi_get_memory_map() internally, which itself calls allocate_pool() at
least twice [typically], and then iterate over the entire memory map
to select a suitable slot which gets allocated using allocate_pages(),
calling either of allocate_[pool|pages] directly is arguably more
lightweight. But claiming they are 'substantially heavier' is
unsubstantiated.

-- 
Ard.
