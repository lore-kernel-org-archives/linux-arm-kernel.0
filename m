From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2011 21:47:55 +0000
Subject: 2b034922 breaks kexec on ARM
In-Reply-To: <CALZhoSRZu=fbsToqWQsxJBSQ6huwxtkR=M7iFZyJ576jeJ4FHw@mail.gmail.com>
References: <20111107185125.GA17464@mudshark.cambridge.arm.com>
 <20111107190314.GS12913@n2100.arm.linux.org.uk>
 <20111107191453.GC17464@mudshark.cambridge.arm.com>
 <20111107192043.GT12913@n2100.arm.linux.org.uk>
 <CALZhoSRZu=fbsToqWQsxJBSQ6huwxtkR=M7iFZyJ576jeJ4FHw@mail.gmail.com>
Message-ID: <20111107214755.GA27679@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 08:55:43PM +0000, Lei Wen wrote:
> Apologize for messing things up...
> But we have make in-depth testing over that patch already in our local
> code base...

Hmm, well even if we put Russell's concerns aside for a moment, the code
does:

		/* Loading another kernel to reboot into */
                if ((flags & KEXEC_ON_CRASH) == 0)
                        result = kimage_normal_alloc(&image, entry,
                                                        nr_segments, segments);
                /* Loading another kernel to switch to if this one crashes */
                else if (flags & KEXEC_ON_CRASH) {
                        /* Free any current crash dump kernel before
                         * we corrupt it.
                         */
                        kimage_free(xchg(&kexec_crash_image, NULL));
                        result = kimage_crash_alloc(&image, entry,
                                                     nr_segments, segments);
                        crash_map_reserved_pages();
                }
                if (result)
                        goto out;

                if (flags & KEXEC_PRESERVE_CONTEXT)
                        image->preserve_context = 1;
                result = machine_kexec_prepare(image);

At this point the image may be fresh out of kimage_normal_malloc, which sets
image->head to 0 (i.e. a NULL indirection page). So when machine_kexec_prepare
tries to determine the page list, it's NULL and relocate_new_kernel will do:

	/*
	 * If there is no indirection page (we are doing crashdumps)
	 * skip any relocation.
	 */
	cmp	r0, #0
	beq	2f

and not actually relocate the kernel sections at all! In fact, looking back at
kernel/kexec.c, right after calling machine_kexec_prepare it goes and loads
the segments:

                if (result)
                        goto out;

                for (i = 0; i < nr_segments; i++) {
                        result = kimage_load_segment(image, &image->segment[i]);
                        if (result)
                                goto out;
                }

so only at this point is it safe to start setting up the page list (as the
image entries are now populated).

So why is this passing your in-depth testing? It could be that:

  (1) You're only testing crashdumps, which don't need the indirection page.
  (2) You don't have the poison_init_mem patches in arch/arm/mm/init.c and
      actually end up using the old kernel that's still kicking around in
      memory.
  (3) Your testing isn't that in-depth after all.

It's probably a combination of all three, but the fact remains that this patch
is breaking things so you should probably roll another version if you really
need to move parts of the image setup earlier on.

Will
