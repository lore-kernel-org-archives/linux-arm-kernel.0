From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 19 Jun 2017 04:11:05 +0300
Subject: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
In-Reply-To: <20170618235108.peaxdi367jpkt542@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
Message-ID: <20170619011105.gjkisjrrtzlmgk6s@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/*
> > + * Minimum alignment requirement for the source and destination addresses
> > + * for function copying.
> > + */
> > +#define FNCPY_ALIGN 8
> 
> >From now this is not arm-only, and it's possible that some architectures
> might want to redefine it in their arch/xxx/include/asm/fncpy.h files.
> So it will be easier for them if you'll wrap FNCPY_ALIGN here with #ifdef
> guards.
> 
> By the way, compiler already has an information on the proper alignment.
> Maybe it's better to use it as the default value here instead of the
> hardcoded value?
> 
> #ifndef FNCPY_ALIGN
> #define FNCPY_ALIGN ({void foo(); __alignof__(&foo);})
> #endif

Ah sorry, at first it should be like this:
#define FNCPY_ALIGN ({void foo(); __alignof__(foo);})

And at second, the correct version returns 1 always.

Even if I pass falign-functions=4096 to gcc, and I see that functions
are aligned accordingly in elf file, the macro returns 1 anyway. So if 
it doesn't work, the hardcoded '8' is the only option.

Yury
