From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 13:44:17 +0000
Subject: clcdfb: Question about clcdfb_check() routine
In-Reply-To: <4D6F83E2.2020701@st.com>
References: <4D6F83E2.2020701@st.com>
Message-ID: <20110303134417.GB25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 05:34:50PM +0530, vksamar wrote:
> I had a doubt on clcdfb_check() routine in include/linux/amba/clcd.h.
> Hard coded lower value of right margin, left margin and hsync len is (5+1).

The +1 is there as we always subtract one off of the value:

        val |= (var->hsync_len - 1) << 8;
        val |= (var->right_margin - 1) << 16;
        val |= (var->left_margin - 1) << 24;

The 5 comes from these statements:

For PL110:

Horizontal timing restrictions DMA requests new data at the start of a
horizontal display line. Some time must be allowed for the DMA transfer
and for the data to propagate down the FIFO path in the LCD interface.
The data path latency forces some restrictions on the usable minimum
values for horizontal porch width in STN mode. The minimum values are
HSW = 2 and HBP = 2.
Single panel mode:
 ? HSW = 3
 ? HBP = 5
Dual panel mode:
 ? HSW = 3
 ? HBP = 5
 ? HFP = 5
 ? PCD = 5 (CLCDCLK/7).
If sufficient time is given at the start of the line (for example, setting
HSW = 6, HBP = 10), data will not get corrupted for PCD = 4 (minimum value).

For PL111:

Horizontal timing restrictions DMA requests new data at the start of a
horizontal display line. You must allocate some time for the DMA transfer
and for the data to propagate down the FIFO path in the LCD interface. The
data path latency forces some restrictions on the usable minimum values
for horizontal porch width in STN mode. The minimum values are HSW = 2
and HBP = 2.
Single-panel mode:
 ? HSW = 3
 ? HBP = 5
 ? HFP = 5
 ? Panel Clock Divisor (PCD) = 1 (CLCDCLK/3).
Dual-panel mode:
 ? HSW = 3
 ? HBP = 5
 ? HFP = 5
 ? PCD = 5 (CLCDCLK/7).
If enough time is given at the start of the line, for example, setting
HSW = 6, HBP = 10, data does not corrupt for PCD = 4, the minimum value.

As we don't know@'check' time which conditions will be satisfied, to
ensure that we always program the registers with legal values we have
to enforce the highest minimum limits, which is right_margin = 5 + 1,
left_margin = 5 + 1, hsync_len = 3 + 1 - I suspect this can be reduced
to '4'.  But apparantly not '1'.
