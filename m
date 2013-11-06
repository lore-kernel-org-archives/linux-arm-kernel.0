From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Nov 2013 00:40:58 +0000
Subject: ARM audit, seccomp, etc are broken wrt OABI syscalls
In-Reply-To: <CAGXu5jJreo001uBLV8oAgR_Z2WZK2qtH8YfvriQJVAQ4SgdRzw@mail.gmail.com>
References: <CALCETrUt7Ojh5Yy4KYgBPj_wBr=fzKKJ=OOgGP9BtXoKrr9QnA@mail.gmail.com>
 <CAGXu5jJreo001uBLV8oAgR_Z2WZK2qtH8YfvriQJVAQ4SgdRzw@mail.gmail.com>
Message-ID: <20131106004058.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 04:14:49PM -0800, Kees Cook wrote:
> I would agree: option 1 seems cleanest of the 3. 3 is sort of like a
> built-in automatic check for a mismatched arch, so maybe that works
> better?
> 
> Alternatively, CONFIG_SECCOMP_FILTER could depend on
> !CONFIG_OABI_COMPAT. That seems like the least work, given the desire
> to kill OABI in the real world. (Though I would note that at least
> Ubuntu's ARM kernels build with CONFIG_OABI_COMPAT; Chrome OS does
> not.)

OABI compat is really only something you want to deal with if you have
a reason to run OABI programs on the kernel; it is in no way guaranteed
that the OABI programs will run properly (many ALSA programs will not
because of different layouts with ioctls).

OABI compat was meant to allow a transition from OABI to EABI.  While
a lot of effort went in to the kernel side of that, which does allow
OABI based userspace to boot with an EABI kernel, and allows OABI built
test programs to run under an EABI kernel, actually being able to
migrate userland is far from trivial - and something that I've never
been able to do.  Hence, virtually all my long-running ARM machines
here are stuck with OABI, and I don't see that situation ever changing.

As a rule, distros should not be enabling OABI compat.  OABI compat
is more something that a developer (like me) who has a reason to enable
it turns it on.
