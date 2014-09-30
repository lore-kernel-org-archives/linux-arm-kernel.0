From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Sep 2014 11:03:55 +0100
Subject: [PATCH 0/5] ARM: move #include <asm/cp15.h> into cacheflush.h
In-Reply-To: <alpine.LFD.2.11.1409300016060.5311@knanqh.ubzr>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
 <alpine.LFD.2.11.1409300016060.5311@knanqh.ubzr>
Message-ID: <20140930100355.GM5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:30:06AM -0400, Nicolas Pitre wrote:
> On Mon, 29 Sep 2014, Brian Norris wrote:
> 
> > There are several places where an explicit include of <asm/cp15.h> is needed
> > just because cacheflush.h uses one of its macros in v7_exit_coherency_flush().
> > Let's put the include in the proper header.
> > 
> > These obviously have some dependencies, so I'd focus on:
> >   (1) Is patch 1 acceptable? If so, then:
> 
> Well, I'm wondering if it is really a gain to force a dependency for 
> cp15.h on every user of cacheflush.h just because of the seldomly used 
> v7_exit_coherency_flush(). But I don't mind either ways.

I don't like unnecessary dependencies.  We have too many of them already,
and it basically means that touching any header file triggers a full
kernel rebuild.

If we go down the path of adding unnecessary dependencies, we might as
well do away with make and just script the damn thing, and that'll
probably be faster since there'll be no dependencies to track.  Just
throw everything through ccache and let it deal with anything which
has changed.  Just don't allow your disk to fill up during the build,
ccache really doesn't like that.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
