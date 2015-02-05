From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Feb 2015 11:08:56 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <1423134058.25197.9.camel@AMDC1943>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <1423134058.25197.9.camel@AMDC1943>
Message-ID: <20150205110856.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 12:00:58PM +0100, Krzysztof Kozlowski wrote:
> On czw, 2015-02-05 at 10:50 +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 11:14:30AM +0100, Krzysztof Kozlowski wrote:
> > > The complete() should not be used on offlined CPU. Rewrite the
> > > wait-complete mechanism with wait_on_bit_timeout().
> > 
> > Yuck.
> > 
> > I think that the IPI idea would be far better, and a much smaller patch.
> > We can continue using the completions, but instead of running the
> > completion on the dying CPU, the dying CPU triggers an IPI which does
> > the completion on the requesting CPU.
> > 
> > You're modifying arch/arm/kernel/smp.c, so you just hook it directly
> > into the IPI mechanism without any registration required.
> > 
> > We can also kill the second cache flush by the dying CPU - as we're
> > not writing to memory anymore by calling complete() after the first
> > cache flush, so this will probably make CPU hotplug fractionally faster
> > too.
> > 
> > (You'll get some fuzz with this patch as I have the NMI backtrace stuff
> > in my kernel.)
> > 
> > Something like this - only build tested so far (waiting for the compile
> > to finish...):
> 
> I am looking into IPI also. Maybe just smp_call_function_any() would be
> enough?

I really don't like that idea.  Let's keep it simple, and avoid calling
code unnecessarily which could end up with RCU issues - and avoid the
need for a second L1 cache flush.

This does seem to work on iMX6 (if you ignore the lockdep splat caused
by that frigging CMA lock - yes, that issue I reported earlier last
year still exists and is still unsolved, which is really disgusting.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
