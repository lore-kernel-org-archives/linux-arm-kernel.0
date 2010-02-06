From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Feb 2010 12:12:03 +0000
Subject: [RFC PATCH v2 2/2] ARM: VFP: preserve the HW context when
	calling signal handlers
In-Reply-To: <20100206100221.GA1109@localhost>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57e.1265315249.git.imre.deak@nokia.com>
	<20100206092544.GB1923@n2100.arm.linux.org.uk>
	<20100206100221.GA1109@localhost>
Message-ID: <20100206121203.GA17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2010 at 12:02:21PM +0200, Imre Deak wrote:
> Right, don't know what made me think that this will work out. Perhaps
> someone mentioning that the corresponding IOCTL is not in use yet. But that
> was about half a year ago :)
> 
> I'll resend adding the new regs only to the signal frame, leaving the above
> as is.

Second point on this.  Currently, the VFP context which we thought
about saving onto the sigframe looks like this:

#if __LINUX_ARM_ARCH__ < 6
/* For ARM pre-v6, we use fstmiax and fldmiax.  This adds one extra
 * word after the registers, and a word of padding at the end for
 * alignment.  */
#define VFP_MAGIC               0x56465001
#define VFP_STORAGE_SIZE        152
#else
#define VFP_MAGIC               0x56465002
#define VFP_STORAGE_SIZE        144
#endif

struct vfp_sigframe
{
        unsigned long           magic;
        unsigned long           size;
        union vfp_state         storage;
};

This is horribly outdated.  We save:

- 16 or 32 64-bit registers depending on whether VFPv3
- one 32-bit word of fpmx state if < ARMv6
- one 32-bit word of fpexc
- one 32-bit word of fpscr
- one 32-bit word of fpinst
- one 32-bit word of fpinst2
- cpu if SMP

This gives potentially the following options:

VFPv3	ARMv6	SMP
n	n	n	16*8+5*4 = 148
y	n	n	32*8+5*4 = 276
n	y	n	16*8+4*4 = 144
y	y	n	32*8+4*4 = 272
n	n	y	16*8+6*4 = 152	*
y	n	y	32*8+6*4 = 280	*
n	y	y	16*8+5*4 = 148
y	y	y	32*8+5*4 = 276

The two marked with '*' are very unlikely to occur.

I think this technically comes under the heading of 'a disaster
waiting to happen'.

We currently have no way to convey these possibilities to anything
dealing with stack frames; certainly userspace applications which may
decide to inspect the sigframe aren't going to deal with all these
possibilities correctly - if we're lucky, they'll get one case right.

The stack frame should not care about whether we're running on SMP or
not - and that rules out using vfp_hard_struct or vfp_state in the
sigframe.  So we're into having a different structure.

Since sigframes are tagged, let's make use of that facility.  Let's
save the 64-bit VFP registers - that way, the size of this structure
defines how many registers there are.  num_regs = struct size / 8.

Save fpmx_state as a separate tagged entity if it's present.  (I doubt
anyone has need to use this - it's just required to preserve VFP state.)

Then, save the remainder of the state information (fpexc, fpscr, fpinst,
fpinst2 but _not_ cpu) as another separate tagged entity.

This means anyone who wants to inspect the VFP state has two or three
tags to look for, but they're all well-defined, and are hopefully
protected against the complexities of having to work out how to decode
the current variable sized structure which we have@present.
