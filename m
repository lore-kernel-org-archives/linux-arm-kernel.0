From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Feb 2016 18:02:56 +0000
Subject: [PATCH v5sub1 8/8] arm64: allow kernel Image to be loaded
 anywhere in physical memory
In-Reply-To: <CAKv+Gu__yQUPyTKLBGeFYk2ehM8XkOXKXRisMyX1V-iAch5JNw@mail.gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-9-git-send-email-ard.biesheuvel@linaro.org>
 <20160201150624.GG15514@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8rgkBWfJXfWzWSkxyKhLOnxirycu-wdcmvRovpDB5hKw@mail.gmail.com>
 <CAKv+Gu8+DdtGQmZtKsB8YOabH1NfzSJge=w0vQwFZPwbQkgYzA@mail.gmail.com>
 <20160201173120.GI15514@e104818-lin.cambridge.arm.com>
 <CAKv+Gu__yQUPyTKLBGeFYk2ehM8XkOXKXRisMyX1V-iAch5JNw@mail.gmail.com>
Message-ID: <20160201180256.GJ15514@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 06:57:05PM +0100, Ard Biesheuvel wrote:
> On 1 February 2016 at 18:31, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> On Mon, Feb 01, 2016 at 11:54:53AM +0100, Ard Biesheuvel wrote:
> >> >>> Note that limiting memory using mem= is not unambiguous anymore after
> >> >>> this change, considering that the kernel may be at the top of physical
> >> >>> memory, and clipping from the bottom rather than the top will discard
> >> >>> any 32-bit DMA addressable memory first. To deal with this, the handling
> >> >>> of mem= is reimplemented to clip top down, but take special care not to
> >> >>> clip memory that covers the kernel image.
> >> >>
> >> >> I may have forgotten the reason - why do we need to avoid clipping the
> >> >> memory that covers the kernel image? It's already mapped in the vmalloc
> >> >> area, so we wouldn't need it in the linear map as well.
[...]
> > I don't care about efficiency, I was hoping to avoid the additional
> > arm64-specific memory clipping but it seems that it could easily get
> > more complicated. So let's leave as it is.
> 
> Alternatively, we could simply apply the memory limit as before, and
> add back the [__init_begin, _end] interval right afterwards using
> memblock_add()

If the code ends up simpler, yes, I'm fine with it.

-- 
Catalin
