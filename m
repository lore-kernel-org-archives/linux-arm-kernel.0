From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Oct 2017 12:09:05 +0100
Subject: [PATCH v2] arm64: optimize __memcpy_fromio and __memcpy_toio
In-Reply-To: <20171023162611.37098-1-salyzyn@android.com>
References: <20171023162611.37098-1-salyzyn@android.com>
Message-ID: <20171024110905.GA31064@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 09:25:35AM -0700, Mark Salyzyn wrote:
> __memcpy_fromio and __memcpy_toio functions do not deal well with
> harmonically unaligned addresses unless they can ultimately be
> copied as quads (u64) to and from the destination.  Without a
> harmonically aligned relationship, they perform byte operations
> over the entire buffer.
> 
> Dropped the fragment that tried to align on the normal memory,
> placing a priority on using quad alignment on the io-side.
> 
> Removed the volatile on the source for __memcpy_toio as it is
> unnecessary.
> 
> This change was motivated by performance issues in the pstore driver.
> On a test platform, measuring probe time for pstore, console buffer
> size of 1/4MB and pmsg of 1/2MB, was in the 90-107ms region. Change
> managed to reduce it to 10-25ms, an improvement in boot time.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> 
> v2:
> - simplify, do not try so hard, or through steps, to align on the
>   normal memory side, as it was a diminishing return.  Dealing with
>   any pathological short cases was unnecessary since there does not
>   appear to be any.
> - drop similar __memset_io changes completely.

I'm fine with the idea here, but can you leave the '8's alone and not
replace them with sizeof(u64) please? I don't think it helps anybody,
and we still use ++/-- for the u8 case.

Will
