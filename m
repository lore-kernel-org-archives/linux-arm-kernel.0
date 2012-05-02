From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 May 2012 16:39:33 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <1335970090.30722.13.camel@localhost>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
 <4FA0D3CA.8080704@jonmasters.org>
 <20120502085828.GB547@mudshark.cambridge.arm.com>
 <42BD0A3B-1820-4C51-8303-A73A6AB974B8@jonmasters.org>
 <1335970090.30722.13.camel@localhost>
Message-ID: <20120502153933.GD547@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 03:48:10PM +0100, Eric Paris wrote:
> On Wed, 2012-05-02 at 10:10 -0400, Jon Masters wrote:
> > On May 2, 2012, at 4:58 AM, Will Deacon wrote:
> > > Yes -- it seems that ARMEB was confused with ARM EABI, so it's probably
> > > worth dropping the -EB suffix in the tools and then updating the RHS of the
> > > above table to use the little-endian identifier. This raises some questions:
> 
> Absolutely I will get all references s/ARMEB/ARM/g in the userspace
> tools.

Cracking, thanks.

> Endianness doesn't really matter from audit's PoV.  It really cares
> about ABI.  Most of the communication from kernel to userspace is
> strings.  The only portion of that communiction which doesn't seem to be
> a string is the netlink message type.  So as long as userspace is the
> same endianness as the kernel creating the netlink message the type is
> going to come out just fine.  Historically ABI has been indicated by a
> mixture of 32/64bit, endianness, and the elf header e_machine field.

For ARM, we can't really use the endianness to tell us anything about the
ABI. You'll need to rely on the ELF header instead (see EF_ARM_EABI_MASK).
With that, can we get rid of the endianness checks in ptrace.c and simply
advertise AUDIT_ARCH_ARM unconditionally?

> > > (2) What do we do about OABI? I think the two choices are either (a) add
> > >    some new AUDIT_ARCH_ARM* entries (although then you have the messy
> > >    problem of determining the ABI of the current task during tracing) or
> > >    (b) support EABI only for the time being.
> > 
> > I think the answer is?nobody cares about OABI :) Seriously though, for
> > "new" stuff, let's just look to the future I say. But that's my opinion.

Well, we care enough about it not to cause regressions since some people are
still using it. I would say that audit can be EABI only though (we can add
support later for OABI if somebody shouts).

> I'm fine with not supporting things.  But I'm pretty stupid here.  Is
> this just not supporting some old chip?  Or is this some ABI that a new
> chip could have both and can switch at run time?  If the latter, we need
> to support it.  If the former, and hints on how to make sure you can't
> build audit with OABI?

My current hack in the kernel is to change the Kconfig entries for audit. As
for userspace, I guess you have to check the toolchain triplet somehow. v6
onwards makes use only of EABI and it's becoming increasingly more difficult
to find distributions supporting OABI (required for CPUs prior to v4t).

Short answer: audit can concern itself only with EABI.

> > > I had to hack a random switch statement in the tools too, otherwise I got a
> > > cryptic message about `requested bit level not supported by machine'.
> > > 
> 
> Got a patch?

Something like:

Index: lib/libaudit.c
===================================================================
--- lib/libaudit.c	(revision 693)
+++ lib/libaudit.c	(working copy)
@@ -1327,6 +1327,10 @@
 						if (bits == __AUDIT_ARCH_64BIT)
 							return -6;
 						break;
+					case MACH_ARMEB:
+						if (bits == __AUDIT_ARCH_64BIT)
+							return -6;
+						break;
 					case MACH_86_64: /* fallthrough */
 					case MACH_PPC64: /* fallthrough */
 					case MACH_S390X: /* fallthrough */

Will
