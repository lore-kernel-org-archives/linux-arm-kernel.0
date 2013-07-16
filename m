From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jul 2013 20:16:58 +0100
Subject: [PATCH RFC v2 04/14] ARM: debug: provide 8250 debug uart
 register shift configuration option
In-Reply-To: <51E59338.6020102@ti.com>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8FU-00047a-AB@rmk-PC.arm.linux.org.uk> <51E59338.6020102@ti.com>
Message-ID: <20130716191658.GG24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 02:38:48PM -0400, Santosh Shilimkar wrote:
> Just a question. Exposing selection choice for UART port
> and probably flow control is just fine, but do we need to
> really need config entries for SHIFT, PA, VA etc ?

Let's look at the original problem.  We have lots of files in
arch/arm/include/debug who's sole purpose is to define a pair of base
addresses.  Maybe around 500 lines of code doing just that - though
much of it is copyright notices (can someone explain to me the point
of claiming copyright on four lines of code defining a base address of
a UART which is, apart from the addresses themselves, identical with
every other damned file?)

What this series does is remove many of those files by consolidating
much of them into a much denser way to represent all this variability.
However, this doesn't really address the root problem, which is that
we have all this information in the kernel, which needs to be added
to every single time we have a new platform come along no matter what
it is.

We need to stop that from happening - we need a way for people to tell
the kernel where their UART is without having to load the kernel up
with lots of platform specific information [*].

Also, even without this, the debug menu has become something of a
sprawling mess, with various people re-implementing what's already
there presumably because they don't look/don't bother to research what
support is already there - and is another source of constant additions.

So, the idea that every platform gets to somehow put its UART addresses
into the kernel image isn't scalable.  Either we end up with lots of
defaults in a Kconfig wihch are also prone to merge conflicts, or we
end up with lots of files in arch/arm/include/debug defining the base
addresses.

We need to stop all of these problems from happening before they
become a big headache for us - imagine Linus' reaction when our debug
menu grows to be the largest Kconfig file in the kernel tree!  Do you
want to be there when that happens?  We're the 22nd biggest Kconfig
file already at 25K - there's only one debug Kconfig larger and that's
the main lib/Kconfig.debug one which has recently been through a cleanup.

Therefore, the idea is to provide _generic_ options which people can
set according to their platforms needs.  Remember, this is *supposed*
to be a developer tool, not a user tool, so asking for addresses and
other parameters is perfectly acceptable - just make sure that they're
documented in a reasonable place.


Lastly, if you want to moan at someone about this, you only have to look
at the hardware guys who have made ARM hardware be soo diverse that we
have ended up with all these different implementations in the first place.
It is *their* problem that we have every platform doing this basic stuff
differently, and it is they who need to realise that this mentality
doesn't scale and hurts.  The "oh it's just software, they can deal
with it" attitude needs to be fought.


* - We've been around all the discussions before about getting this
information from DT, and quite frankly I'm *really* not in the mood for
a rehash of those arguments yet again - we'll only end up at the same
point.  (If anyone feels that they need to state their opinion on that,
please *first* go back and read the previous discussions about what the
LL debug infrastructure is about, it's purpose, etc.  If you don't do
your homework before piping up, I'm not going to bother replying to you.)
