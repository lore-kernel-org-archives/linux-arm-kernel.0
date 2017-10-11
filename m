From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 09:24:16 +0100
Subject: [PATCH v5 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20171011050734.GE6756@linaro.org>
References: <20171010063619.6303-1-takahiro.akashi@linaro.org>
 <20171010063619.6303-4-takahiro.akashi@linaro.org>
 <a8a0f36b-e797-289b-04e3-aa87b4088cdd@arm.com>
 <20171011050734.GE6756@linaro.org>
Message-ID: <cbeb01e5-8758-1205-1e79-de01de899ef6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/10/17 06:07, AKASHI Takahiro wrote:
> On Tue, Oct 10, 2017 at 12:02:01PM +0100, Julien Thierry wrote:
> 
> [snip]
> 
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -26,30 +26,79 @@
>>>   #include <linux/vmalloc.h>
>>>   #include "kexec_internal.h"
>>>
>>> +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
>>> +
>>>   static int kexec_calculate_store_digests(struct kimage *image);
>>>
>>> +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
>>> +                          unsigned long buf_len)
>>> +{
>>> +     const struct kexec_file_ops *fops;
>>> +     int ret = -ENOEXEC;
>>> +
>>> +     for (fops = kexec_file_loaders[0]; fops && fops->probe; ++fops) {
>>
>> Hmm, that's not gonna work (and I see that what I said in the previous
>> patch was not 100% correct either).
> 
> Can you elaborate this a bit more?
>

Yes. With the current state of the loop, you are going to check the 
first element of kexec_file_loaders[0], and what will get incremented is 
the pointer contained in kexec_file_loaders rather than a pointer 
pointer pointing at an element of kexec_file_loaders.


> I'm sure that, with my code, any member of fops, cannot be changed;
> "const struct kexec_file_ops *fops" means that fops is a pointer to
> "constant sturct kexec_file_ops," while "struct kexec_file_ops *
> const kexec_file_loaders[]" means that kexec_file_loaders is a "constant
> array" of pointers to "constant struct kexec_file_ops."
> 

Hmm, right, my suggestion below doesn't have the right constness, fops 
should be declared as:
const struct kexec_file_ops * const * fops;

This can point at elements of kexec_file_loaders.

Hope this makes more sense.

Cheers,

> Thanks,
> -Takahiro AKASHI
> 
> 
>> 'fops' should be of type 'const struct kexec_file_ops **', and the loop
>> should be:
>>
>> for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops)
>>
>> With some additional dereferences in the body of the loop.
>>
>> Unless you prefer the previous state of the loop (with i and the break
>> inside), but I still think this looks better.
>>
>> Cheers,
>>


-- 
Julien Thierry
