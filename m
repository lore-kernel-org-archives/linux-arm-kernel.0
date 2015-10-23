From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Oct 2015 18:49:15 +0200
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <562A610F.4090101@arm.com>
References: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
 <562A610F.4090101@arm.com>
Message-ID: <CAKv+Gu_QKpL2X3ZNn9QVZnBa00JrF1v0W1DtkyuGzm1cLREPWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Laura)

http://thread.gmane.org/gmane.linux.ports.arm.kernel/450513

On 23 October 2015 at 18:32, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 10/23/2015 10:34 AM, Ard Biesheuvel wrote:
>>
>> It looks like fixup_executable() [with DEBUG_RODATA enabled] is the
>> culprit here: it calls create mapping() with a size that gets rounded
>> up to a multiple of PAGE_SIZE, which means the region that ends up
>> getting its exec bits cleared is larger than it should. Perhaps it is
>> better to fix that instead?
>
>
> Ard,
>         Thanks for taking a look at this!
>
>         Your probably right.
>
>         But AFAIK, with just that fix text/ro sections can be partially
> mapped without ro.

Yes.

> It seems to me that putting a little padding in so that
> they are on separate pages is a good idea, especially since it seems the
> remaining sections of interest are page aligned, either explicitly in the
> linker script or via assembly directives in assorted places.
>

This should do the trick then, I think:
------8<----------
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e9b8276ca079..db834a464986 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -104,7 +104,7 @@ SECTIONS
                _text = .;
                HEAD_TEXT
        }
-       ALIGN_DEBUG_RO
+       ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
        .text : {                       /* Real text segment            */
                _stext = .;             /* Text and read-only data      */
                        __exception_text_start = .;
------8<----------

>         Maybe a clearer fix is an additional ifdef in the DEBUG_ALIGN_RODATA
> stanza which sets ALIGN_DEBUG_RO to align to pagesize if DEBUG_RODATA is
> set, that way it only takes affect for RODATA.
>

I think the diff does what you mean here.

-- 
Ard.
