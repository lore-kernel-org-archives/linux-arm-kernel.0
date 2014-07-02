From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 18:58:57 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140702191832.5e9f35fc@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140702191832.5e9f35fc@free-electrons.com>
Message-ID: <20140702175857.GR32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:18:32PM +0200, Thomas Petazzoni wrote:
>  1) The Armada 370 and Armada XP are perfectly detectable in the early
>     assembly, since they have different values in the main
>     identification register (they use PJ4B and PJ4B-MP cores).

You say that, but Dove is PJ4B too (I forget whether it's PJ4B or not.)
The only way to be sure is to compare the ID numbers.  The AP510 in
Dove I have here has an ID register value of 0x560f5815.  This ties up
with the PJ4B entry in proc-v7.S:

        .type   __v7_pj4b_proc_info, #object
__v7_pj4b_proc_info:
        .long   0x560f5800
        .long   0xff0fff00
        __v7_proc __v7_pj4b_setup, proc_fns = pj4b_processor_functions
        .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info

How does that compare to the ID you see on Armada 370 and XP?  (I've
no idea what IDs you get there...)  If the ID is different, then we
should be able to solve this pretty easily for these CPUs by creating
a new proc_info record as I think I have previously suggested.

With a separate record, we can set the S bit if we need to, and we can
also set the write-allocate mode too, now that the patch I sent you
is in mainline (which is something I definitely indicated along with
that patch.)

I've not really said anything new in this email which I haven't said
before, with the exception of stating what the ID is for the Dove SoC
I have.  That's the only ID I know, and I assume that those working on
mvebu have a better idea what ID numbers are found across all the
families.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
