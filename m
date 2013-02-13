From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Feb 2013 14:52:08 +0000
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of
 the kernel when HIGHMEM is ON
In-Reply-To: <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
 <20130213090317.GY17833@n2100.arm.linux.org.uk>
 <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
Message-ID: <20130213145208.GC17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 03:39:21PM +0100, Michal Simek wrote:
> ok. Can you describe me this configuration? Enough to tell me dts memory
> fragment and kernel load addr which match this case.

Anything which uses more than 1GB of memory and has PAGE_OFFSET set at
0xc0000000 (3GB).  Simple maths will tell you that, and why it fails.

Look:
- if __va(bank->start) = PAGE_OFFSET, and PAGE_OFFSET is at 3GB.
- if bank->size = 1GB (which we _do_ have), then
     __va(bank->start + bank->size) = 4GB.  4GB represented as a 32-bit
  pointer is NULL.  NULL < (void *)PAGE_OFFSET.

Therefore, your patch will cause systems with 1GB or more of memory in
one bank to ignore _all_ the memory passed in.

And if you look@the code:

                if (__va(bank->start) >= vmalloc_min ||
                    __va(bank->start) < (void *)PAGE_OFFSET)
                        highmem = 1;

notice the facy that we're marking all memory starting with an apparant
virtual address outside of PAGE_OFFSET...vmalloc_min as highmem.  This is
to catch cases exactly like this.

Memory for which __va(bank->start) < (void *)PAGE_OFFSET will also have
__va(bank->start + bank->size - 1) (in your patch) also below PAGE_OFFSET,
and your modification will cause the kernel to ignore this memory -
which is not acceptable.

I don't think there's much option for solutions to this; not with a common
kernel designed to run on multiple platforms.  If a platform doesn't
conform to the Linux requirements for a common kernel, then it doesn't
conform and it can't use it.

In much the same way that we ended up saying "no" to people who wanted
to place two physical banks of memory in reverse order in the virtual
mapping, I think this is another case of "no, we can't permit this with
common cross-subarch kernels".
