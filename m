From: omycle@gmail.com (Li Haifeng)
Date: Fri, 29 Mar 2013 16:36:55 +0800
Subject: [Crash-utility] Throw read error on vmcore produced by ARM soc.
In-Reply-To: <20130328163622.GD3368@n2100.arm.linux.org.uk>
References: <CAFNq8R7RdY8yiNonCca5Fjt8kzEkwA=T+UG76m-7cRoAMU0e8w@mail.gmail.com>
 <660127124.17160191.1364485054637.JavaMail.root@redhat.com>
 <20130328163622.GD3368@n2100.arm.linux.org.uk>
Message-ID: <CAFNq8R5Wu51OLeQMsZ2P3uHZngFB8yHKBeF6PXy36+i6Z1xO=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Mar 28, 2013 at 11:37:34AM -0400, Dave Anderson wrote:
>> I don't know about the arm_ioremap issue -- that's for the ARM guys to
>> answer.
>
> Not really.  Basically, we don't support ioremapping of areas of RAM
> already mapped elsewhere by the kernel.  In other words, if RAM is
> part of the kernel's memory map, then ioremap() is forbidden.
>
> Why?  Because if we were to allow it, we'd end up with conflicting
> mappings being created, which is a violation of the architecture
> requirements.
>
> The quoted pfn_valid() implementation isn't used if the memory map
> has holes in it - as selected by:
>
> config HAVE_ARCH_PFN_VALID
>         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>
> Maybe that also needs to be enabled with crashkernels if they also
> provide a memory map which has holes in?

Thanks.

At least, it looks like that comment for WARN_ON(pfn_valid()) in
arm_ioremap() will not lead to vmcore corrupt.

:-)

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
