From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 16:01:36 +0000
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for
	function body copying
In-Reply-To: <AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
Message-ID: <20110117160136.GA25829@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 03:02:20PM +0100, Jean Pihet wrote:
> On Fri, Jan 14, 2011 at 10:17 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > + * These macros are intended for use when there is a need to copy a low-level
> > + * function body into special memory.
> > + *
> > + * For example, when reconfiguring the SDRAM controller, the code doing the
> > + * reconfiguration may need to run from SRAM.
> > + *
> > + * NOTE: that the copied function body must be entirely self-contained and
> > + * position-independent in order for this to work properly.
> > + *
> > + * NOTE: in order for embedded literals and data to get referenced correctly,
> > + * the alignment of functions must be preserved when copying. ?To ensure this,
> > + * the source and destination addresses for fncpy() must be aligned to a
> > + * multiple of 8 bytes: you will be get a BUG() if this condition is not met.
> > + * You will typically need a ".align 3" directive in the assembler where the
> > + * function to be copied is defined, and ensure that your allocator for the
> > + * destination buffer returns 8-byte-aligned pointers.
> 
> Note that aligning the source and destination pointers to a multiple
> of 8 bytes has an impact on the behavio(u)r and so must be carefully
> thought and tested on OMAP1/2/3 platforms.

OMAP3 is ARMv7, so is EABI.  EABI requires 64-bit data to be aligned to
natural 64-bit boundaries, so architecturally it's correct.

Nevertheless, the code may not be using 64-bit data, so that doesn't
apply - but fncpy() can't know that.
