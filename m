From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Nov 2018 11:47:15 -0800
Subject: revisit arm64 per-task stack canaries
In-Reply-To: <CAKv+Gu-UodqRkpK3jVgkgVos=+U5RuBpsPVj5H3CwbzUUPQzKg@mail.gmail.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
 <20180213180436.GA21758@arm.com>
 <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
 <20181030103502.GD19955@arm.com>
 <CAKv+Gu96pRfneQ-SLL3a9d-uLAqOPvkLcB25Md=f+z9f5Yg+fg@mail.gmail.com>
 <9f84b541-1d23-5143-70e3-f42bef3c8e1a@arm.com>
 <CAKv+Gu-UodqRkpK3jVgkgVos=+U5RuBpsPVj5H3CwbzUUPQzKg@mail.gmail.com>
Message-ID: <CAKv+Gu9Px=RKue=6DT3y+GYZ3vehYs+B6nfVYjtWjjfJpHk4dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2018 at 09:04, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 19 Nov 2018 at 08:50, Ramana Radhakrishnan
> <Ramana.Radhakrishnan@arm.com> wrote:
> >
> >
> >
> >
> > > Ramana -- was this just a cosmetic preference, or are there good
> > > technical reasons to avoid the new symbol (which isn't an awful lot
> > > different to what we currently use).
> > >
> >
> > I couldn't immediately  remember why I preferred the offset on the
> > command line in the conversations those months ago about this. But then ...
> >
> > After talking a bit with Ard at LPC and then thinking about it while
> > hacking up a prototype implementation, I suspect the main reason would
> > have been to avoid the standalone relocation in the first place and just
> > deal with it as an immediate.
> >
> > I don't work enough in the kernel but a simple git grep
> > mstack-protector-guard-offset in the kernel tree I have checked out did
> > find this.
> >
> > arch/powerpc/Makefile:  $(eval KBUILD_CFLAGS +=
> > -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY")
> > print $$3;}' include/generated/asm-offsets.h))
> > arch/powerpc/Makefile:  $(eval KBUILD_CFLAGS +=
> > -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY")
> > print $$3;}' include/generated/asm-offsets.h)
> >
> > Is there any reason why the same trick wouldn't work for aarch64 ?
> >
>
> What a wonderful hack :-) From a quick test, it looks like this should
> work on AArch64 as well, yes.

Turns out this code is brand new (introduced in v4.20-rc1) which is
why we didn't spot it before.

> I think it makes sense not to deviate
> from other architectures, both on the kernel and on the GCC side. And
> as I pointed out the other day, the relocation presents some
> complications of its own (due to the fact that we cannot easily export
> absolute symbols to kernel modules now that we started using relative
> references to refer to them internally in the core kernel)
>
> > I've been hacking up a prototype that seems to work, need to make it
> > clean and ready to go upstream on the GCC lists.
> >
>
> That's great - thanks. If you send me a source link, I can give it a
> spin with my kernel changes.

I've pushed a branch here that uses the compiler based support

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=rfc-arm64-per-task-ssp

(assuming the options will be called
-mstack-protector-guard-[reg|offset] like on power)

Just building the defconfig with a compiler that implements this
should be sufficient, like below:

export ARCH=arm64
export CROSS_COMPILE=[/path/to/]aarch64-linux-gnu-
make defconfig
make Image modules
