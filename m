From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Feb 2015 22:56:51 +0800
Subject: [PATCH] efi: get_memory_map: add sufficient slack for memory
 descriptors
In-Reply-To: <20150212144727.GD4665@codeblueprint.co.uk>
References: <1423718659-795-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150212102226.GB1245@leverpostej>
 <CAKv+Gu88vzPpXoSEs1ZSQbO7wsqh7NRSZc=iSpC9D6vzus7f8g@mail.gmail.com>
 <20150212144727.GD4665@codeblueprint.co.uk>
Message-ID: <CAKv+Gu-NAKASZc4phj5x83mB8Ak4Gy2zYq-a0CDADEOTBD4pXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2015 at 22:47, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Thu, 12 Feb, at 06:39:46PM, Ard Biesheuvel wrote:
>>
>> I don't see how doing a single allocation could result in a single
>> free region to be split into more than 1 occupied region + 2 free
>> regions.
>> So no, I don't think it is ...
>
> I don't think that's a guarantee we can make, nor is it something we
> should rely upon.
>
> Please explain the user-visible failure that this patch fixes. Does your
> machine refuse to boot?

I am running UEFI under QEMU and Xen primarily at the moment, and
experimenting with various build options in Tianocore, One of the
options is preallocating and freeing blocks of various memory types,
in a way that should result in the final number of distinct regions to
be much lower. It could result however in a free memory region to be
carved up in three instead of two, and that is a failure I have seen
occur.

> Why is the 'goto again' loop insufficient in
> handling this scenario?
>

Yes, that should solve it as well, so if you prefer I reinstate that,
I can respin the patch. There is a theoretical possibility that it
would take more than just one more iteration, but that is highly
unlikely and it should still always complete.
