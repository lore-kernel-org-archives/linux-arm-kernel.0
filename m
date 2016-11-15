From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Nov 2016 16:11:03 +0100
Subject: [PATCH v2 2/3] efi/libstub: add random.c to ARM build
In-Reply-To: <CAKv+Gu_=et=2zHBTYOr9thz2kS0cXHHYg96oWGRdD3D10fqXtw@mail.gmail.com>
References: <1476962486-18368-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476962486-18368-3-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_=et=2zHBTYOr9thz2kS0cXHHYg96oWGRdD3D10fqXtw@mail.gmail.com>
Message-ID: <2189664.D28O3TYR8x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 2, 2016 9:37:13 AM CET Ard Biesheuvel wrote:
> @@ -98,7 +100,7 @@
>                 efi_memory_desc_t *md = (void *)memory_map + map_offset;
>                 unsigned long slots;
> 
> -               slots = get_entry_num_slots(md, size, align);
> +               slots = get_entry_num_slots(md, size, ilog2(align));
>                 MD_NUM_SLOTS(md) = slots;
>                 total_slots += slots;
>         }
> """
> 
> This is because ARM does not have a division routine in the
> decompressor, and the fact that the division by 'align' should always
> involve a power of 2 is not visible to the compiler.
> 
> If nobody objects, I will fold this in when applying
> 
> 

I'm getting a link error here when building with -Os:

drivers/firmware/efi/libstub/random.stub.o: In function `efi_random_alloc':
random.c:(.text.efi_random_alloc+0x264): undefined reference to `__aeabi_llsr'

If I compile this with -O2, the ilog2 gets inlined and everything
works.

	Arnd
