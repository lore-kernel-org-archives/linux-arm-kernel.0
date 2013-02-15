From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 15 Feb 2013 10:04:37 +0000
Subject: [BUG] v7_coherent_kern_range broken on big.LITTLE
In-Reply-To: <20130214171615.GH12629@mudshark.cambridge.arm.com>
References: <1360861663.3266.58.camel@linaro1.home>
 <20130214171615.GH12629@mudshark.cambridge.arm.com>
Message-ID: <1360922677.4078.12.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-14 at 17:16 +0000, Will Deacon wrote:
> Hi Tixy,
> 
> On Thu, Feb 14, 2013 at 05:07:43PM +0000, Jon Medhurst (Tixy) wrote:
> > The function v7_coherent_kern_range uses the macro icache_line_size to
> > read the current CPUs icache line size for the purpose of invalidating
> > all cache lines in the given range.
> > 
> > Unfortunately, on the TC2 big.LITTLE test chip, the A15 icache line size
> > is 64 bytes, but the A7 size is only 32 bytes. So when the function
> > executes on the A15 it will miss out every alternate cache line for the
> > A7.
> 
> There is a signal (IMINLN) to the core which allows A15 to behave as though
> it has a 32-byte line size and this should be driven correctly for big/little.

How do we set that signal? Is that something we have to set up in Linux
or is it something that we expect the Firmware to set up?

> Can you confirm that on your TC2 the I-line size is advertised differently
> depending on the cluster?

Yes, I had printed out the value returned by icache_line_size when I had
ftrace_replace_code running on an A7 and on an A15.

The reason I suspected this was because I had tried all four
combinations of A15 and A7 setup, and it was only when booting on A15
with an A7 second CPU that enable function tracing kills the system.
A15+A15, A7+A15 and A7+A7 are OK.

To eliminate the kind of boot CPU as a factor I tried the A7+A15 system
with ftrace forced to run on the A15, and the bug stil occurred. And the
final straw was when hard coding the icache line size to 32 fixed
things.

-- 
Tixy
