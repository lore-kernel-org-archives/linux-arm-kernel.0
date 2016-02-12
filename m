From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 13:09:50 +0100
Subject: [PATCH v2 3/3] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <CAKv+Gu_2xLeN+ySAhEBKh+NByjka_12HunprueV+ykE0njrgsw@mail.gmail.com>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160212114908.GK25087@arm.com>
 <CAKv+Gu_2xLeN+ySAhEBKh+NByjka_12HunprueV+ykE0njrgsw@mail.gmail.com>
Message-ID: <2388983.RePUKvokN0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 12:51:40 Ard Biesheuvel wrote:
> >> @@ -133,6 +135,12 @@ extern u64                       kimage_vaddr;
> >>  /* the offset between the kernel virtual and physical mappings */
> >>  extern u64                   kimage_voffset;
> >>
> >> +static inline void assert_memstart_addr_assigned(void)
> >> +{
> >> +     if (unlikely(memstart_addr == (phys_addr_t)-1))
> >> +             asm("brk #%0" :: "I"(0x800));
> >
> > Ok, I'll bite! Why isn't this just a BUG_ON?
> >
> 
> Because circular header dependencies prevent BUG_ON() from being used
> here, and I was reluctant to move this function into a .c file.

Maybe it works if you make assert_memstart_addr_assigned() a macro as well?

	Arnd
