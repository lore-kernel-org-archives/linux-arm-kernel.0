From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 4 Jun 2015 12:35:31 +0100
Subject: [PATCH v5 0/6] QEMU support for KVM Guest Debug on arm64
In-Reply-To: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
References: <1432912764-7073-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA_prABrrwx5LQ6T0A1cG-jvfuJYeZE6kTqKO+5jWrqn1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2015 at 16:19, Alex Benn?e <alex.bennee@linaro.org> wrote:
> You may be wondering what happened to v3 and v4. They do exist but
> they didn't change much from the the original patches as I've been
> mostly looking the kernel side of the equation. So in summary the
> changes are:
>
>   - updates to the kernel ABI
>   - don't fall over on kernels without debug support
>   - better logging, syncing and use of internals.h
>   - debug exception re-injection for guest events*

Some generic remarks (which we've talked about in irc):

 * does this correctly handle single step over emulated MMIO insns?
   how about single step over insns emulated in the kernel
   without trapping out to userspace? (eg some of the sysregs)
   kvm_skip_instr() doesn't seem to update PSTATE.SS...
 * the kernel currently does kvm_skip_instr() before the
   emulated MMIO exit, not afterwards. That feels conceptually
   the wrong way round -- are there any interesting corner cases
   we would get wrong currently but that naturally fall out in
   the wash if it's done afterwards?
 * what about debugging a 32-bit guest which uses the 32-bit
   ARM/Thumb bkpt insns?

thanks
-- PMM
