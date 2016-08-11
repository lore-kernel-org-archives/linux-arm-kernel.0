From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 12:01:43 +0100
Subject: [PATCH] arm64: suspend: avoid potential TLB conflict
In-Reply-To: <57AAF666.2030501@arm.com>
References: <1470651050-18291-1-git-send-email-mark.rutland@arm.com>
 <57AA0401.1020809@arm.com> <20160809175157.GC13591@leverpostej>
 <57AAF666.2030501@arm.com>
Message-ID: <20160811110143.GB3805@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 10:39:50AM +0100, James Morse wrote:
> Hi Mark,
> 
> On 09/08/16 18:51, Mark Rutland wrote:
> > On Tue, Aug 09, 2016 at 05:25:37PM +0100, James Morse wrote:
> >> fe12c00d21bb ("PM / hibernate: Introduce test_resume mode for hibernation") came
> >> in with the merge window, this does a suspend followed by a resume with the user
> >> page tables still loaded in ttbr0_el1.
> > 
> > Hmmm... given that, it looks like if we bail out in swsusp_arch_resume()
> > after the call to create_safe_exec_page(), we may return to userspace
> > with a corrupted TTBR0.
> 
> Ah, didn't spot that.
> 
> > We probably need to defer the call to create_safe_exec_page() after the
> > other potential failure sites so as to avoid that.
> > 
> > Looking around it's not clear to me how/where the get_safe_page()
> > allocations are cleaned up when a failure occurs.
> 
> Its dealt with by the core code: they get added to to one of
> kernel/power/snapshot.c's plethora of bitmaps, and freed via
> free_basic_memory_bitmaps() -> memory_bm_free() -> free_list_of_pages() ->
> free_image_page().
> 
> It looks like pages allocated by get_safe_page() are on the 'forbidden_pages_map'.

Thanks for the pointer!

Given that, it looks like a simple reshuffling of swsusp_arch_resume is
all that's necessary. I'll spin that along with v2 of this patch.

Thanks,
Mark.
