From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Oct 2010 22:26:15 -0400 (EDT)
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <4CC9FAE4.5030605@codeaurora.org>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
	<20101027221428.GB28391@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010272227380.31220@xanadu.home>
	<1288283413.2683.2.camel@c-dwalke-linux.qualcomm.com>
	<20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
	<4CC9FAE4.5030605@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1010282218470.5029@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Oct 2010, Rohit Vaswani wrote:

> On 10/28/2010 10:46 AM, Russell King - ARM Linux wrote:
> > On Thu, Oct 28, 2010 at 09:41:06AM -0700, Daniel Walker wrote:
> > > On Thu, 2010-10-28 at 17:35 +0100, Russell King - ARM Linux wrote:
> > > > If you don't want it, don't enable DEBUG_LL.  DEBUG_LL is what you
> > > > enable for initial board bring-up and once you're getting kernel
> > > > messages via standard console drivers, you disable it.
> > > This board doesn't have the ability to support DEBUG_LL .. I don't want
> > > the user to have the option to even select that.
> > But do not leave this function empty otherwise if you
> > enable DEBUG_LL, you'll get unpredictable behaviour.
> > 
> With DEBUG_LL enabled and if all the 3 macros (addruart, senduart, waituart)
> are empty
> nothing references these values - so wouldn't this be okay?

The addruart macro is used to set up a mapping so the senduart and 
waituart can access the UART port.  But even if senduart and waituart 
are empty, the empty addruart is wrong because if it doesn't initialize 
the passed registers, a random mapping will be created with whatever was 
in those register before.  That random mapping could overwrite the 
mapping that just was created for the kernel image for example.


Nicolas
