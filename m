From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 25 Apr 2016 15:24:35 +0100
Subject: [PATCHv3 1/5] efi/runtime-wrappers: detect FW irq flag corruption
In-Reply-To: <CAKv+Gu8yH4u0-DNezUTk5b1DQJdEaH4RxR7YMQcwmkuRmEaNEw@mail.gmail.com>
References: <1461591994-14918-1-git-send-email-mark.rutland@arm.com>
 <1461591994-14918-2-git-send-email-mark.rutland@arm.com>
 <571E25B1.8070305@arm.com>
 <20160425141557.GA2829@codeblueprint.co.uk>
 <CAKv+Gu8yH4u0-DNezUTk5b1DQJdEaH4RxR7YMQcwmkuRmEaNEw@mail.gmail.com>
Message-ID: <20160425142435.GB2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr, at 04:18:41PM, Ard Biesheuvel wrote:
> On 25 April 2016 at 16:15, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> > On Mon, 25 Apr, at 03:12:01PM, Robin Murphy wrote:
> >> >+static void efi_call_virt_check_flags(unsigned long flags, const char *call)
> >> >+{
> >> >+    unsigned long cur_flags;
> >> >+    bool mismatch;
> >> >+
> >> >+    local_save_flags(cur_flags);
> >> >+
> >> >+    mismatch = !!((cur_flags ^ flags) & ARCH_EFI_IRQ_FLAGS_MASK);
> >>
> >> nit: the assignment itself is already a conversion to bool, so the
> >> excitement is redundant here.
> >
> > This was intentional. I asked Mark to make this change so that it's
> > explicit for the developer that we're performing the type conversion.
> 
> But replacing an implicit boolean cast with an explicit one makes
> little sense, no? Don't we simply want '!= 0' here if you need a
> boolean expression?

Aha but '!!' is fewer characters to type!!

I'm not that bothered as long as we don't stuff an int into a bool
without giving the programmer some idea we're doing that. It's not
about the compiler getting it wrong, more about a developer
introducing a bug when they change the code in the future. 

Unless anyone objects, I'll fix this up to use '!= 0' when I apply it.
