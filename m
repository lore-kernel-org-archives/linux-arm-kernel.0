From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 15 Nov 2010 17:11:50 -0500 (EST)
Subject: [PATCH v2 03/20] ARM: LPAE: use u32 instead of unsigned long for
	32-bit ptes
In-Reply-To: <AANLkTi=FFpCwEhSgs-zOh32JQvqQWqnaQVTitwJeDyzj@mail.gmail.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<20101114151445.GB10871@n2100.arm.linux.org.uk>
	<AANLkTinuUCYMa8e7=ehhExFzBAhPZBKA16M1GVQ=RMMH@mail.gmail.com>
	<201011151047.37103.arnd@arndb.de>
	<AANLkTi=FFpCwEhSgs-zOh32JQvqQWqnaQVTitwJeDyzj@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011151707310.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Nov 2010, Catalin Marinas wrote:

> On 15 November 2010 09:47, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 15 November 2010 10:39:30 Catalin Marinas wrote:
> >> > There will be compiler warnings because u32 is unsigned int, and we
> >> > print it as %08lx. ?Generic code cases pte values to (long long) and
> >> > prints them using %08llx. ?We should do the same.
> >>
> >> We still need some kind of macro because with LPAE we need %016llx
> >> since the phys address can go to 40-bit and there are some additional
> >> bits in the top word. Unless you'd like to always print 16 characters
> >> even for 32-bit ptes (or if there is some other printk magic I'm not
> >> aware of).
> >
> > Why not just %010llx? That would just be two extra characters.
> 
> We still have attributes (like XN, bit 54) stored in the top part of
> the pte. This may be of interest when debugging.

They will be printed if they exist. The %010 in front of llx only means 
to have a minimum of 10 zero-paded digits if the value is smaller than 
that.

However, not having aligned values will be confusing.  A macro for the 
format might be the best compromize.


Nicolas
