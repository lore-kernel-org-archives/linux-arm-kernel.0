From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 12 Oct 2012 14:53:00 +0800
Subject: When will unwind_backtrace end?
Message-ID: <20121012065259.GA15907@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

kernel 3.0.35, memory begin from 0x80000000, which happens to be same
as virtual address.

When enable CONFIG_LOCKDEP, it keep printing

unwind: Unknown symbol address 80008040
unwind: Index not found 80008040
unwind: Unknown symbol address 80008040
unwind: Index not found 80008040
unwind: Unknown symbol address 80008040
unwind: Index not found 80008040
unwind: Unknown symbol address 80008040

I did some investigation. It looks like:
unwind_frame didn't fail at:
if (!kernel_text_address(frame->pc))
                return -URC_FAILURE;

When it backtrace to 0x80008040, it took it as kernel text address.
But it's a physical address, which point to
"1:      b       __enable_mmu" in stext.

Is it a known issue?

Thanks
Richard
