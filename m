From: jonathan@jonmasters.org (Jon Masters)
Date: Wed, 02 May 2012 02:27:22 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <20120501110744.GD2305@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <4F9EE024.8000906@redhat.com>
 <20120501110744.GD2305@mudshark.cambridge.arm.com>
Message-ID: <4FA0D3CA.8080704@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2012 07:07 AM, Will Deacon wrote:
> On Mon, Apr 30, 2012 at 07:55:32PM +0100, Jon Masters wrote:
>> But I'll look over your patch and do some poking. Now that we know where
>> this problem is, I think the priority is for me to test this patch from
>> you (took the day off, but I'll give it a test tonight) to make sure
>> nothing blows up, then schedule some time for audit to make sure it's
>> actually doing anything useful. I'll email you later today. Still
>> leaning toward recommending nobody actually turn on audit on ARM systems
>> until we know that it doesn't do anything else that's terrible.
> 
> Well this might make you smile.

It did :)

> The original audit code blew up the ARM kernel because it assumed a big-endian
> target, which we since fixed. However, it looks like the userspace audit tools
> only support ARMEB, so I've not been able to get them working on my board.
> Linaro even had the heart to package them up nicely in their v7l filesystem!
> 
> I doubt it's much effort to fix the tools, but it implies nobody is using
> them on armv7l today and turning it off is probably your safest bet for the time
> being.

Right. So audit userspace has this:

static const struct int_transtab elftab[] = {
    { MACH_X86,     AUDIT_ARCH_I386   },
    { MACH_86_64,   AUDIT_ARCH_X86_64 },
    { MACH_IA64,    AUDIT_ARCH_IA64   },
    { MACH_PPC64,   AUDIT_ARCH_PPC64  },
    { MACH_PPC,     AUDIT_ARCH_PPC    },
    { MACH_S390X,   AUDIT_ARCH_S390X  },
    { MACH_S390,    AUDIT_ARCH_S390   },
#ifdef WITH_ALPHA
    { MACH_ALPHA,   AUDIT_ARCH_ALPHA  }
#endif
#ifdef WITH_ARMEB
    { MACH_ARMEB,   AUDIT_ARCH_ARMEB  }
#endif
};

However. I went through all of the kernel code and could see no arch
specificness other than the mach type (it already supports little arm)
so I think it's just userspace, and not much that needs changing. It
seems that it "works" for me because the default audit rules in Fedora
are "-D" (delete everything basically), unless I'm missing something.

Anyway. I'd like to get this fixed. I'll make some hardware available to
Eric (initially a shared test box, but we'll buy him an ARM board) and
I'm happy to test patches. I may get time this week to poke at it
myself, but I'm not counting on it. Meanwhile, I think it's harmless
actually to have audit enabled, just that userspace won't use it. I
prefer that we get in the habit of leaving non-embedded stuff turned on
where we can - and where we know it won't explode (I don't think this
will now that I've looked at it some more) for test coverage.

Finally, as an aside, and not meant as a jab, the the thing with Linaro
shipping this alludes to a bigger problem. We need to band together to
ensure that features common to "bigger" x86 systems get more coverage.
I'm trying to push us to do this on our end, and anything we can do
collaboratively to spot things like this is win for us all.

Thanks,

Jon.
