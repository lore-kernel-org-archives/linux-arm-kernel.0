From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Sep 2012 16:20:06 +0100
Subject: [kvmarm] [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM
 support
In-Reply-To: <CAFEAcA-3hcteG2pOLh3ZtRF+uw-X2LS+zkAp2tq7BT4SkYqtaw@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
 <20120927141314.GK25916@mudshark.cambridge.arm.com>
 <CAFEAcA-3hcteG2pOLh3ZtRF+uw-X2LS+zkAp2tq7BT4SkYqtaw@mail.gmail.com>
Message-ID: <20120927152006.GN25916@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 03:45:50PM +0100, Peter Maydell wrote:
> On 27 September 2012 15:13, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
> >> this API has been discussed to death on the KVM lists, and we can of
> >> course revive that if the regset makes it nicer - I'd prefer getting
> >> this upstream the way that it is now though, where GET_REG / SET_REG
> >> seems to be the way forward from a KVM perspective.
> >
> > I'm sure the API has been discussed, but I've not seen that conversation and
> > I'm also not aware about whether or not regsets were considered as a
> > possibility for this stuff.
> 
> Can you point me at some documentation for regsets? It's a bit
> difficult to have a sensible conversation about their suitability
> otherwise...

The actual regset structure (struct user_regset) is internal to the kernel,
so it's not very well documented. As far as userspace interaction goes, the
usual method is via an iovec (see readv/writev) which is well documented, but
of course the kvm ioctl would still need documenting. For ptrace, that's just
a small paragraph in a user header:

/*
 * Generic ptrace interface that exports the architecture specific regsets
 * using the corresponding NT_* types (which are also used in the core dump).
 * Please note that the NT_PRSTATUS note type in a core dump contains a full
 * 'struct elf_prstatus'. But the user_regset for NT_PRSTATUS contains just the
 * elf_gregset_t that is the pr_reg field of 'struct elf_prstatus'. For all the
 * other user_regset flavors, the user_regset layout and the ELF core dump note
 * payload are exactly the same layout.
 *
 * This interface usage is as follows:
 *      struct iovec iov = { buf, len};
 *
 *      ret = ptrace(PTRACE_GETREGSET/PTRACE_SETREGSET, pid, NT_XXX_TYPE, &iov);
 *
 * On the successful completion, iov.len will be updated by the kernel,
 * specifying how much the kernel has written/read to/from the user's iov.buf.
 */

but obviously you'd probably have something under Documentation/.

> (The potentially tricky area to handle is the cp15 registers, where
> it's quite likely that new registers might be added later and so
> userspace has to be able to query the kernel for what is supported
> and possibly deal with the kernel reporting attempts to set read
> only bits within registers, etc. Using the same ABI for simpler
> cases like the GPRs and FP registers is then just a matter of
> being consistent in the interface we expose to userspace.)

You *could* split up cp15 into lots of regsets but realistically that's going
to hurt down the line. GPR and FP would be good though.

Will
