From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 May 2012 09:58:28 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <4FA0D3CA.8080704@jonmasters.org>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
 <4FA0D3CA.8080704@jonmasters.org>
Message-ID: <20120502085828.GB547@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 07:27:22AM +0100, Jon Masters wrote:
> Right. So audit userspace has this:
> 
> static const struct int_transtab elftab[] = {
>     { MACH_X86,     AUDIT_ARCH_I386   },
>     { MACH_86_64,   AUDIT_ARCH_X86_64 },
>     { MACH_IA64,    AUDIT_ARCH_IA64   },
>     { MACH_PPC64,   AUDIT_ARCH_PPC64  },
>     { MACH_PPC,     AUDIT_ARCH_PPC    },
>     { MACH_S390X,   AUDIT_ARCH_S390X  },
>     { MACH_S390,    AUDIT_ARCH_S390   },
> #ifdef WITH_ALPHA
>     { MACH_ALPHA,   AUDIT_ARCH_ALPHA  }
> #endif
> #ifdef WITH_ARMEB
>     { MACH_ARMEB,   AUDIT_ARCH_ARMEB  }
> #endif
> };

Yes -- it seems that ARMEB was confused with ARM EABI, so it's probably
worth dropping the -EB suffix in the tools and then updating the RHS of the
above table to use the little-endian identifier. This raises some questions:

(1) Why does endianness come into this? Is there some structure parsing code
    somewhere that I can't see or is there an assumption about syscall ABIs
    being necessarily different if the endianness changes?

(2) What do we do about OABI? I think the two choices are either (a) add
    some new AUDIT_ARCH_ARM* entries (although then you have the messy
    problem of determining the ABI of the current task during tracing) or
    (b) support EABI only for the time being.

I had to hack a random switch statement in the tools too, otherwise I got a
cryptic message about `requested bit level not supported by machine'.

Anyway, I threw the kernel changes into my audit branch and will re-post later
on.

Will
