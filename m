From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2018 18:32:57 +0100
Subject: [PATCH v7 7/8] arm64: update
 Documentation/arm64/tagged-pointers.txt
In-Reply-To: <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
 <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
Message-ID: <20181003173256.GG12998@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 03:12:42PM +0200, Andrey Konovalov wrote:
> diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
> index a25a99e82bb1..ae877d185fdb 100644
> --- a/Documentation/arm64/tagged-pointers.txt
> +++ b/Documentation/arm64/tagged-pointers.txt
> @@ -17,13 +17,21 @@ this byte for application use.
>  Passing tagged addresses to the kernel
>  --------------------------------------
>  
> -All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +Some initial work for supporting non-zero address tags passed to the
> +kernel has been done. As of now, the kernel supports tags in:

With my maintainer hat on, the above statement leads me to think this
new ABI is work in progress, so not yet suitable for upstream.

Also, how is user space supposed to know that it can now pass tagged
pointers into the kernel? An ABI change (or relaxation), needs to be
advertised by the kernel, usually via a new HWCAP bit (e.g. HWCAP_TBI).
Once we have a HWCAP bit in place, we need to be pretty clear about
which syscalls can and cannot cope with tagged pointers. The "as of now"
implies potential further relaxation which, again, would need to be
advertised to user in some (additional) way.

> -This includes, but is not limited to, addresses found in:
> +  - user fault addresses

While the kernel currently supports this in some way (by clearing the
tag exception entry, el0_da), the above implies (at least to me) that
sigcontext.fault_address would contain the tagged address. That's not
the case (unless I missed it in your patches).

> - - pointer arguments to system calls, including pointers in structures
> -   passed to system calls,
> +  - pointer arguments (including pointers in structures), which don't
> +    describe virtual memory ranges, passed to system calls

I think we need to be more precise here...

> +All other interpretations of userspace memory addresses by the kernel
> +assume an address tag of 0x00. This includes, but is not limited to,
> +addresses found in:
> +
> + - pointer arguments (including pointers in structures), which describe
> +   virtual memory ranges, passed to memory system calls (mmap, mprotect,
> +   etc.)

...and probably a full list here.

-- 
Catalin
