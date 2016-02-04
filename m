From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Feb 2016 16:31:59 +0100
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <20160204151303.GB6076@e104818-lin.cambridge.arm.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160204151303.GB6076@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9n=bmsZ=UOBiLWzaG2JSsbdC8k1mB7yFbH0czrbXS-1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2016 at 16:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
>> This adds support for emitting PLTs at module load time for relative
>> branches that are out of range. This is a prerequisite for KASLR, which
>> may place the kernel and the modules anywhere in the vmalloc area,
>> making it more likely that branch target offsets exceed the maximum
>> range of +/- 128 MB.
>
> Any downside to trying to keep the kernel+modules coupled together so
> that we avoid the PLT?
>

First of all, note that it is unlikely that the PLTs are ever required
in practice, considering that either
a) the kernel is loaded at the default location right at the base of
the vmalloc range, and in this case, the module space is reserved for
modules only, or
b) the kernel is loaded at some random offset in the 240+ GB vmalloc
space, and it is unlikely that all VMA space around the kernel happens
to be given out to non-randomized vmalloc/ioremap allocations

So while this patch was a requirement at first (since in the first
version of the series, the modules always remained below the vmalloc
area so they would always be out of range when KASLR was enabled), in
the current series, it is simply a last resort (although still
required) to make sure that modules can be loaded far away from the
kernel in the unlikely event that all VMA space in close proximity is
given to another user.

Reserving a dedicated module region around the kernel while it is
loaded at a random offset is not straight forward, since it affects
all other users of the vmalloc area. So generic vmalloc/vmap/ioremap
code would need to be updated to disregard the area around the kernel,
since simply reserving the VMA area for the modules would make it
inaccessible to module_alloc() as well (unless we reserve the whole
region and manage the module allocations separately)

So the bottom line is that it may be possible, but it is unlikely to
be worth the effort imo

-- 
Ard.
