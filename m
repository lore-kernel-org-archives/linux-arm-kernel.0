From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Oct 2015 10:43:24 +0100
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <CAPAsAGzgqOZVdTfpBGADAhZjOJTCqdB1Paq-14vk-_1hu4DCyw@mail.gmail.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAPAsAGz7Tp6Z87tPq_NNh_mcwPF_DOaXzu0po5f6AQxPAcsALQ@mail.gmail.com>
 <20151009091037.GC26278@arm.com>
 <CAPAsAGzgqOZVdTfpBGADAhZjOJTCqdB1Paq-14vk-_1hu4DCyw@mail.gmail.com>
Message-ID: <20151009094324.GE26278@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 12:40:21PM +0300, Andrey Ryabinin wrote:
> 2015-10-09 12:10 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> > On Fri, Oct 09, 2015 at 11:12:24AM +0300, Andrey Ryabinin wrote:
> >> 2015-10-08 22:02 GMT+03:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> >> > --- a/arch/arm64/kernel/image.h
> >> > +++ b/arch/arm64/kernel/image.h
> >> > @@ -59,4 +59,31 @@
> >> >         _kernel_offset_le       = DATA_LE64(TEXT_OFFSET);       \
> >> >         _kernel_flags_le        = DATA_LE64(__HEAD_FLAGS);
> >> >
> >> > +#ifdef CONFIG_EFI
> >> > +
> >> > +/*
> >> > + * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> >> > + * isolate it from the kernel proper. The following symbols are legally
> >> > + * accessed by the stub, so provide some aliases to make them accessible.
> >> > + * Only include data symbols here, or text symbols of functions that are
> >> > + * guaranteed to be safe when executed at another offset than they were
> >> > + * linked at. The routines below are all implemented in assembler in a
> >> > + * position independent manner
> >> > + */
> >> > +__efistub_memcmp               = __pi_memcmp;
> >> > +__efistub_memchr               = __pi_memchr;
> >> > +__efistub_memcpy               = __pi_memcpy;
> >> > +__efistub_memmove              = __pi_memmove;
> >> > +__efistub_memset               = __pi_memset;
> >> > +__efistub_strlen               = __pi_strlen;
> >> > +__efistub_strcmp               = __pi_strcmp;
> >> > +__efistub_strncmp              = __pi_strncmp;
> >> > +__efistub___flush_dcache_area  = __pi___flush_dcache_area;
> >>
> >> So why we need these __pi_* aliases?
> >> We could just do __efistub_memcmp = memcmp; Right?
> >
> > We *could*, but that defeats the whole purpose of tagging
> > position-independent functions explicitly in the kernel text.
> >
> 
> I just don't get that "the whole purpose of tagging".
> 
> Yes, the EFI stub is allowed to call only PI kernel functions.
> But the EFI stub already protected by __efistub_ namespace.
> If we want to use some new PI function in the stub, we would need add
> it into this list at first.
> So that __pi_ namespace doesn't bring any protection or isolation.

What it does it force people making future changes to the __pi_* functions
to think about the stub, otherwise if the function happens to be
position-independent when efistub starts using it, it could easily break
due to some future patch where the author didn't realise that it was
being used in that manner.

Will
