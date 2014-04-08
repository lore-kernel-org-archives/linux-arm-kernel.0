From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 8 Apr 2014 07:09:24 -0700
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140408133039.GH16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk>
 <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr2kxKXpPwy8vqF1+CjcRsu86tGir-NuC7AXYiJVi4TuGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2014 06:30, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Apr 08, 2014 at 09:05:49AM -0400, David Long wrote:
>> Unfortunately copy_to_user_page() also needs a pointer to a vma struct
>> so, while it presumably provides the model to follow, it can't simply be
>> dropped in.
>
> Well, isn't this code doing the same thing as ptrace?  It seems to want
> to modify a page in userspace of another process to change instructions
> that are going to be executed.  That's what ptrace does, and ptrace
> already copes with all the issues there.

As I see it, the difference between ptrace use and xol single stepping
it that in first all cores should be involved and potentially cache operation
would be broadcasted. In case of uprobes only local core is involved.
The way I read uprobes code xol slot will be used once by current core
to execute one instruction, then it will hit next breakpoint and xol slot
will be freed and potentially reused by next uprobe.

I assume that while doing xol single stepping task cannot migrate to
another core, wondering whether it is absolutely true. It seems that
similar ppc code that calls flush_dcache_page follow this assumption.
If uprobes xol single stepping need to handle all cores it will be very
expensive.

In ptrace case caches of all cores must be handled.

Having said above I do agree that large portion of flush_ptrace_access
could be reused between these two use cases.

Thanks,
Victor

> Given that we've already solved that problem, wouldn't it be a good idea
> if the tracing code would stop trying to reinvent broken solutions to
> problems we have already solved?
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
