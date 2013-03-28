From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 16:36:22 +0000
Subject: [Crash-utility] Throw read error on vmcore produced by ARM soc.
In-Reply-To: <660127124.17160191.1364485054637.JavaMail.root@redhat.com>
References: <CAFNq8R7RdY8yiNonCca5Fjt8kzEkwA=T+UG76m-7cRoAMU0e8w@mail.gmail.com>
 <660127124.17160191.1364485054637.JavaMail.root@redhat.com>
Message-ID: <20130328163622.GD3368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 11:37:34AM -0400, Dave Anderson wrote:
> I don't know about the arm_ioremap issue -- that's for the ARM guys to
> answer.

Not really.  Basically, we don't support ioremapping of areas of RAM
already mapped elsewhere by the kernel.  In other words, if RAM is
part of the kernel's memory map, then ioremap() is forbidden.

Why?  Because if we were to allow it, we'd end up with conflicting
mappings being created, which is a violation of the architecture
requirements.

The quoted pfn_valid() implementation isn't used if the memory map
has holes in it - as selected by:

config HAVE_ARCH_PFN_VALID
        def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM

Maybe that also needs to be enabled with crashkernels if they also
provide a memory map which has holes in?
