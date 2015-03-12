From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 21:22:02 +0000
Subject: [RFT/RFC PATCH 6/6] ARM: keep .text and .fixup regions together
In-Reply-To: <CAKv+Gu8h=8wQO7NWOXbLvvWF+WhiL63s9pF9JZCT7BUUu-pSdQ@mail.gmail.com>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426181892-15440-7-git-send-email-ard.biesheuvel@linaro.org>
 <20150312211051.GZ8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8h=8wQO7NWOXbLvvWF+WhiL63s9pF9JZCT7BUUu-pSdQ@mail.gmail.com>
Message-ID: <20150312212202.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 10:18:26PM +0100, Ard Biesheuvel wrote:
> On 12 March 2015 at 22:10, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Mar 12, 2015 at 06:38:12PM +0100, Ard Biesheuvel wrote:
> >> Fixup snippets are put into a dedicated section so that they don't
> >> bloat cache lines with instructions that are usually not executed.
> >> But there is no reason to put all these snippets together at the far
> >> end of the .text output region, where the branch instruction they
> >> contain could go out of range if the kernel grows in size.
> >>
> >> Instead, emit .text and .fixup regions together for each input object.
> >> They should still be out of the way, but not so far that they go out
> >> of range.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> Note that the TEXT_TEXT macro will emit *(.text) again but this should be
> >> harmless.
> >
> > However, I wonder if by doing this, we're weakening the ability for
> > kallsyms final link to succeed:
> >
> > /* .text section. Map to function alignment to avoid address changes
> >  * during second ld run in second ld pass when generating System.map */
> >
> > Can we not just move .fixup before TEXT_TEXT?  The only thing between it
> > and .text would be .text.hot.
> >
> 
> Putting .fixup before .text already helps, but not enough for the
> .config Arnd gave me that I have been testing this with.
> 
> What *(.text .fixup) does (i.e., putting both section names inside the
> parentheses), is emitting both sections for each input object file, so
> they will always be close to the object that it refers to, so it is
> not the same thing.

I'll suggest a different solution then - how about modifying
asm-generic/vmlinux.lds.h to change *(.text) to *(.text .text.fixup)
and we move all the .fixup sections to .text.fixup ?  Arnd?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
