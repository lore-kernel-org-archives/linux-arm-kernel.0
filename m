From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 11:42:54 -0700
Subject: [PATCH 1/9] arm64: Fix efi kernel entry
In-Reply-To: <CAKv+Gu8V1xXtGZm5ae+NiFGDuNr20TUBhL=vCgQ6J2S5CQJakg@mail.gmail.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <873e73a998c198de69f6f01f92176be2b613c500.1408736066.git.geoff@infradead.org>
 <20140826155505.GG16482@arm.com>
 <CAKv+Gu8V1xXtGZm5ae+NiFGDuNr20TUBhL=vCgQ6J2S5CQJakg@mail.gmail.com>
Message-ID: <1409078574.11425.29.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2014-08-26 at 18:19 +0200, Ard Biesheuvel wrote:
> First of all, the 'add x13, x18, #0x16' was carefully chosen to be
> both a "MZ" prefix and an executable instruction without any harmful
> side effects. 

OK, I didn't look so closely to realize this was an instruction with out
side effects.

> So currently, the EFI stub jumps to that add
> instruction, and not to the 'b stext' that comes after. There is an
> issue with that, which I have already proposed a patch for (arm64/efi:
> efistub: jump to 'stext' directly, not through the header), but this
> is related to the guarantees the UEFI spec gives about where the
> header gets loaded (if at all).
> 
> However, going back to your patch, setting ENTRY() only affects the
> vmlinux ELF image, and this information gets stripped when creating
> the binary. Do you need the entry point to be set so you can load
> vmlinux using the debugger, perhaps? In that case, did you have any
> problems branching to the add instruction? If so, I would like to know
> about it.

kexec-tools [1] can load vmlinux elf files, and uses ehdr.e_entry as the
kernel entry point.  I tested without this patch (branching to _text),
and it works OK, so we can drop this patch.

-Geoff

[1] https://git.linaro.org/people/geoff.levand/kexec-tools.git

-Geoff
