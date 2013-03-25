From: illia.ragozin@grapecom.com (Elijah Ragozin)
Date: Mon, 25 Mar 2013 20:43:23 +0200
Subject: [PATCH] [ARM] Feroceon: fix kexec by setting outer_cache.inv_all
In-Reply-To: <20130325181346.GA28029@obsidianresearch.com>
References: <514E0D70.3060202@grapecom.com>
 <20130325172113.GC16690@obsidianresearch.com> <51508E17.6010701@grapecom.com>
 <20130325181346.GA28029@obsidianresearch.com>
Message-ID: <51509ACB.5010806@grapecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2013 20:13, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2013 at 07:49:11PM +0200, Elijah Ragozin wrote:
>
>> So there is no actually disable and invalidation cache after the old
>> kernel finished and the new one is not started yet, we're not safe
>> to relocate and decompress the kernel.
> Upon closer inspection I found the spec passage that the L2 becomes
> non-coherent with the CPU once the L1 D cache is turned off.
>
> So, the L2 has to be invalidated after the L1 D cache is turned off,
> or before the L1 D cache is turned on..
>
> Looks likes 'cpu_proc_fin' turns off the both L1 caches, so the
> invalidate is properly after.
>
> This looks right to me then.
>
> You might want to add some additional info to the the commit message
> along the lines of:
>
>    On Feroceon the L2 cache becomes non-coherent with the CPU when the
>    L1 caches are disabled. Thus the L2 needs to be invalidated after
>    both L1 caches are disabled.
>
>    .. text about kexec being the motivation ..
>
>
>> If in your case everything is working could you please send for me
>> .config and your kernel version, probably I also miss smth.
> Upon deeper reflection, in my case the L2 is re-initialized by a boot
> stub we use on the kexec path...
>
> Also, I will warn you that I could not figure out how to get Linux to
> shut off the DMA's in things like the ethernet, so kexec is very flaky
> on these systems.
>
> Jason
>

Thank you for this clarification,
I'll rework the commit message and resend the patch then.

-- 
Best Regards,
Illia Ragozin.
