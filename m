From: james.morse@arm.com (James Morse)
Date: Thu, 06 Apr 2017 10:25:02 +0100
Subject: [PATCH] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <CAMj-D2A2QyvjUvbEcnaPcPsgySvAguWFkZSS1WxxT+T3uNU7aw@mail.gmail.com>
References: <20170315160727.16465-1-james.morse@arm.com>
 <CAMj-D2A2QyvjUvbEcnaPcPsgySvAguWFkZSS1WxxT+T3uNU7aw@mail.gmail.com>
Message-ID: <58E6096E.4060206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 05/04/17 00:05, gengdongjiu wrote:
> thanks for the patch, have you consider to told Qemu or KVM tools
> the reason for this bus error(SEA/SEI)?

They should never need to know. We should treat Qemu/kvmtool like any other
program. Programs should only need to know about the affect on them, not the
underlying reason or mechanism.


> when Qemu or KVM tools get this SIGBUS signal, it do not know receive
> this SIGBUS due to SEA or SEI.

Why would this matter?

Firmware signalled Linux that something bad happened. Linux handles the problem
and everything keeps running.

The interface with firmware has to be architecture specific. When signalling
user-space it should be architecture agnostic, otherwise we can't write portable
user space code.


If Qemu was affected by the error (currently only if some of its memory was
hwpoisoned) we send it SIGBUS as we would for any other program. Qemu can choose
if and how to signal the guest about this error, it doesn't have to use the same
interface as firmware and the host used. With TCG Qemu may be emulating a
totally different architecture!


Looking at the list of errors in table 250 of UEFI 2.6, cache-errors are the
only case I can imagine we would want to report to a guest, these are
effectively transient memory errors. SIGBUS is still appropriate here, but we
probably need a new si_code value to indicate the error can be cleared. (unlike
hwpoison which appears to never re-use the affected page).


Thanks,

James
