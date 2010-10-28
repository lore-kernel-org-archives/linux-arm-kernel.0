From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Oct 2010 11:00:24 -0700
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <20101028174653.GH3122@n2100.arm.linux.org.uk>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
	<20101027221428.GB28391@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010272227380.31220@xanadu.home>
	<1288283413.2683.2.camel@c-dwalke-linux.qualcomm.com>
	<20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
Message-ID: <1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-28 at 18:46 +0100, Russell King - ARM Linux wrote:

> There is no such option present - and there never has been.  This raises
> the question about what you did before with .phys_io and .io_pg_offst
> on these platforms which can't support it at all.

We had this in some of the boards (or something like it),

#ifdef CONFIG_MSM_DEBUG_UART
        .phys_io        = MSM_DEBUG_UART_PHYS,
        .io_pg_offst    = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
#endif 

and the code in debug-macro.S had similar ifdefs.

I should change what I said in the last email. It's not that these
boards can't support this, it's that they can't support it _right now_.
It's something we can add, but haven't yet.

> Effectively, rp is what you would've returned as .phys_io, and rv is
> the virtual address corresponding to .io_pg_offst - so just replicate
> that behaviour.  But do not leave this function empty otherwise if you
> enable DEBUG_LL, you'll get unpredictable behaviour.

This is what the function currently has,

        .macro  addruart, rp, rv
        ldr     \rp, =MSM_DEBUG_UART_PHYS
        ldr     \rv, =MSM_DEBUG_UART_BASE
        .endm

So if we have a MSM_DEBUG_UART_PHYS and MSM_DEBUG_UART_BASE we're
returning it. We don't actually have those values for all the boards
tho. My understanding was that there are some generic arm changes
needed, but I need to confirm that.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
