From: labbott@redhat.com (Laura Abbott)
Date: Fri, 6 Nov 2015 15:41:57 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <20151106204641.GT8644@n2100.arm.linux.org.uk>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk> <563B81DA.2080409@redhat.com>
 <20151105162719.GQ8644@n2100.arm.linux.org.uk> <563BFCC4.8050705@redhat.com>
 <CAGXu5jLS8GPxmMQwd9qw+w+fkMqU-GYyME5WUuKZZ4qTesVzCQ@mail.gmail.com>
 <563CF510.9080506@redhat.com> <20151106204641.GT8644@n2100.arm.linux.org.uk>
Message-ID: <563D3AC5.4020203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2015 12:46 PM, Russell King - ARM Linux wrote:
> On Fri, Nov 06, 2015 at 10:44:32AM -0800, Laura Abbott wrote:
>> with my test patch. I think setting both current->active_mm and &init_mm
>> is sufficient. Maybe explicitly setting swapper_pg_dir would be cleaner?
>
> Please, stop thinking like this.  If you're trying to change the kernel
> section mappings after threads have been spawned, you need to change
> them for _all_ threads, which means you need to change them for every
> page table that's in existence at that time - you can't do just one
> table and hope everyone updates, it doesn't work like that.
>

That's a bad assumption assumption on my part based on what I was
observing. At the time of mark_rodata_ro, the only threads present
are kernel threads which aren't going to have task->mm. Only the
running thread is going to have active_mm. None of those are init_mm.
To be complete we need:

- Update every task->mm for every thread in every process
- Update current->active_mm
- Update &init_mm explicitly

All this would need to be done under stop_machine as well. Does that cover
everything or am I still off?

Thanks,
Laura
