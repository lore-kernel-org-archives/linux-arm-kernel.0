From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 17:55:53 +0000
Subject: [PATCH 0/9] Clean up SMP IPI support
Message-ID: <20101115175553.GC31421@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is aimed at cleaning up our SMP IPI support.  As has been
recently pointed out, we have a spinlock in percpu data, which is not
very nice.

If we switch to using the GIC SGIs, one for each IPI function, then
we don't need the mask of ipi bits indicating what work needs to be
done.  This allows us to get rid of the troublesome spinlock in
send_ipi_message().

However, we end up with slightly more expense on the IPI receiver side,
as they no longer have a word to read to process a set of pending IPIs.
This isn't much of a down-side as you hardly end up with masses of
pending IPIs.  Modern Cortex A9 platforms usually only clock up the
reschedule IPI.

This leaves us with just ipi_count in the ipi per-cpu data structure.
Other platforms put this in the global irq_stat array, and break this
down into individual IPIs.  So, let's do the same.

One down-side of this patchset is that platforms which use SGI 1 to
wake their secondary CPUs will receive an "Unknown IPI message" kernel
critical message at boot time - as SGI 1 is no longer recognised as a
Linux IPI interrupt.  We _could_ make this 'IPI_BOOT', something which
is only used for booting and therefore simply ignored.
