From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Feb 2016 15:42:34 +0000
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <CAKv+Gu9n=bmsZ=UOBiLWzaG2JSsbdC8k1mB7yFbH0czrbXS-1g@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160204151303.GB6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9n=bmsZ=UOBiLWzaG2JSsbdC8k1mB7yFbH0czrbXS-1g@mail.gmail.com>
Message-ID: <20160205154234.GF6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 04:31:59PM +0100, Ard Biesheuvel wrote:
> On 4 February 2016 at 16:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
> >> This adds support for emitting PLTs at module load time for relative
> >> branches that are out of range. This is a prerequisite for KASLR, which
> >> may place the kernel and the modules anywhere in the vmalloc area,
> >> making it more likely that branch target offsets exceed the maximum
> >> range of +/- 128 MB.
> >
> > Any downside to trying to keep the kernel+modules coupled together so
> > that we avoid the PLT?
> 
> First of all, note that it is unlikely that the PLTs are ever required
> in practice, considering that either
> a) the kernel is loaded at the default location right at the base of
> the vmalloc range, and in this case, the module space is reserved for
> modules only, or
> b) the kernel is loaded at some random offset in the 240+ GB vmalloc
> space, and it is unlikely that all VMA space around the kernel happens
> to be given out to non-randomized vmalloc/ioremap allocations

My worry is that we merge some code that's rarely tested.

> So the bottom line is that it may be possible, but it is unlikely to
> be worth the effort imo

The alternative of having our own allocator for modules isn't that
appealing either, so let's stick with the PLTs.

-- 
Catalin
