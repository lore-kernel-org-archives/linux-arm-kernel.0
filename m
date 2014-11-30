From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 30 Nov 2014 10:20:19 +0000
Subject: [PATCH 5/7] KVM: arm64: guest debug, add support for single-step
In-Reply-To: <20141130101056.GB484@cbox>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-6-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA-cjM9yUXi6tc79UP0fBKAagtFKQgV3iAjz5DWr9yxZUQ@mail.gmail.com>
 <20141130101056.GB484@cbox>
Message-ID: <CAFEAcA882aVrnkKFVMaLA0NzkN9OGHJTQseo_w5UFkmBfTDnTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2014 at 10:10, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> In any case, I think it was related to how userspace observes the state
> of the CPU, because when you do the MMIO operation emulation in
> userspace, currently if you observe the PC though GET_ONE_REG, you'll
> see a PC pointing to the next instruction, not the one you're emulating
> which is strange.

Also if we ever add support for userspace to say "this MMIO should
fault" then we definitely need the PC-advance to happen afterwards,
not before.

> Not sure what the relation to a guest single-stepping itself was.

I think it just came up in the course of that discussion, because
single-step handling also needs to perform an action (clear PSTATE.SS)
as part of the "advance over this insn" operation. But I think that
you're right that doing the advance before dropping out to userspace
is no worse for singlestep than it is for any other case.

-- PMM
