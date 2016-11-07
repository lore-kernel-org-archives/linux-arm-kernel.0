From: dvyukov@google.com (Dmitry Vyukov)
Date: Sun, 6 Nov 2016 17:44:16 -0800
Subject: [PATCH] arm64: percpu: kill off final ACCESS_ONCE() uses
In-Reply-To: <1478283426-6649-1-git-send-email-mark.rutland@arm.com>
References: <1478283426-6649-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CACT4Y+Z5z-ywh8sMWuLEk48uqtZ6tS67kX+scXm+PtmTMj-neg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2016 at 11:17 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> For several reasons it is preferable to use {READ,WRITE}_ONCE() rather than
> ACCESS_ONCE(). For example, these handle aggregate types, result in shorter
> source code, and better document the intended access (which may be useful for
> instrumentation features such as the upcoming KTSAN).
>
> Over a number of patches, most uses of ACCESS_ONCE() in arch/arm64 have been
> migrated to {READ,WRITE}_ONCE(). For consistency, and the above reasons, this
> patch migrates the final remaining uses.

Thanks!

Acked-by: Dmitry Vyukov <dvyukov@google.com>


> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/percpu.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 5394c84..4afb6fc 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -101,16 +101,16 @@ static inline unsigned long __percpu_read(void *ptr, int size)
>
>         switch (size) {
>         case 1:
> -               ret = ACCESS_ONCE(*(u8 *)ptr);
> +               ret = READ_ONCE(*(u8 *)ptr);
>                 break;
>         case 2:
> -               ret = ACCESS_ONCE(*(u16 *)ptr);
> +               ret = READ_ONCE(*(u16 *)ptr);
>                 break;
>         case 4:
> -               ret = ACCESS_ONCE(*(u32 *)ptr);
> +               ret = READ_ONCE(*(u32 *)ptr);
>                 break;
>         case 8:
> -               ret = ACCESS_ONCE(*(u64 *)ptr);
> +               ret = READ_ONCE(*(u64 *)ptr);
>                 break;
>         default:
>                 BUILD_BUG();
> @@ -123,16 +123,16 @@ static inline void __percpu_write(void *ptr, unsigned long val, int size)
>  {
>         switch (size) {
>         case 1:
> -               ACCESS_ONCE(*(u8 *)ptr) = (u8)val;
> +               WRITE_ONCE(*(u8 *)ptr, (u8)val);
>                 break;
>         case 2:
> -               ACCESS_ONCE(*(u16 *)ptr) = (u16)val;
> +               WRITE_ONCE(*(u16 *)ptr, (u16)val);
>                 break;
>         case 4:
> -               ACCESS_ONCE(*(u32 *)ptr) = (u32)val;
> +               WRITE_ONCE(*(u32 *)ptr, (u32)val);
>                 break;
>         case 8:
> -               ACCESS_ONCE(*(u64 *)ptr) = (u64)val;
> +               WRITE_ONCE(*(u64 *)ptr, (u64)val);
>                 break;
>         default:
>                 BUILD_BUG();
> --
> 2.7.4
>
