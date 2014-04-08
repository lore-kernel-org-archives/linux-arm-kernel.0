From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 8 Apr 2014 08:35:01 -0700
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <CAA3XUr2kxKXpPwy8vqF1+CjcRsu86tGir-NuC7AXYiJVi4TuGw@mail.gmail.com>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk>
 <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
 <CAA3XUr2kxKXpPwy8vqF1+CjcRsu86tGir-NuC7AXYiJVi4TuGw@mail.gmail.com>
Message-ID: <CAA3XUr1Bj4CD2fhZkWAHx+9W8eGz755OvnE+-3sxaAcQNV6Q-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2014 07:09, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> On 8 April 2014 06:30, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Tue, Apr 08, 2014 at 09:05:49AM -0400, David Long wrote:
>>> Unfortunately copy_to_user_page() also needs a pointer to a vma struct
>>> so, while it presumably provides the model to follow, it can't simply be
>>> dropped in.
>>
>> Well, isn't this code doing the same thing as ptrace?  It seems to want
>> to modify a page in userspace of another process to change instructions
>> that are going to be executed.  That's what ptrace does, and ptrace
>> already copes with all the issues there.
>
> As I see it, the difference between ptrace use and xol single stepping
> it that in first all cores should be involved and potentially cache operation
> would be broadcasted. In case of uprobes only local core is involved.
> The way I read uprobes code xol slot will be used once by current core
> to execute one instruction, then it will hit next breakpoint and xol slot
> will be freed and potentially reused by next uprobe.
>
> I assume that while doing xol single stepping task cannot migrate to
> another core, wondering whether it is absolutely true. It seems that
> similar ppc code that calls flush_dcache_page follow this assumption.
> If uprobes xol single stepping need to handle all cores it will be very
> expensive.
>
> In ptrace case caches of all cores must be handled.
>
> Having said above I do agree that large portion of flush_ptrace_access
> could be reused between these two use cases.

Looking at flush_ptrace_access more closely. Now I am not sure that
ptrace write code could easily reused.

1) flush_ptrace_access seems to handle both data and text segments
write. In case of xol write we always know that it is code write

2) as I pointed before flush_ptrace_access handles smp case whereas
xol write does not need to do that

3) flush_ptrace_access needs vma, which uprobe code does not have on
layer where xol is installed. That is probably most critical issue that
could stop suggested code sharing. And note that vma in
flush_ptrace_access is needed only for cases cases 1) and 2) above,
about which xol write does not really care. If we take only required
pieces from flush_ptrace_access would not xol cache flush look like
this:

void arch_uprobe_xol_sync_dcache_icache(struct page *page,
                    unsigned long addr, unsigned long size)
{
    if (icache_is_vipt_aliasing())
        flush_icache_alias(page_to_pfn(page), addr, size);
    else
        __cpuc_coherent_user_range(addr, size);
}

of course, above function should be properly places or flush_icache_alias
function should be made globally visible.

Note on the side: flush_ptrace_access works with user-land memory
but it still uses __cpuc_coherent_kern_range. I think it should use
__cpuc_coherent_user_range. It looks like implementation wise it is
the same but user variant seems more appropriate in given situation.
Or am I missing something here?

Thanks,
Victor

> Thanks,
> Victor
>
>> Given that we've already solved that problem, wouldn't it be a good idea
>> if the tracing code would stop trying to reinvent broken solutions to
>> problems we have already solved?
>>
>> --
>> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
>> improving, and getting towards what was expected from it.
