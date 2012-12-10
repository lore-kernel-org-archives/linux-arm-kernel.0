From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 10 Dec 2012 09:06:05 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <20121210135747.GK14363@n2100.arm.linux.org.uk>
References: <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <1354902347.8263.12.camel@linaro1.home>
 <20121210100433.GB6624@mudshark.cambridge.arm.com>
 <1355144537.17101.155.camel@gandalf.local.home>
 <20121210135747.GK14363@n2100.arm.linux.org.uk>
Message-ID: <1355148365.17101.168.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-10 at 13:57 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 10, 2012 at 08:02:17AM -0500, Steven Rostedt wrote:
> > On Mon, 2012-12-10 at 10:04 +0000, Will Deacon wrote:
> > > Yes, and I think if you do use two 16-bit nops, you can even get rid of all
> > > the intermediate `sync' operations (I guess you might want one at the end if
> > > you want the call to become visible at a particular point).
> > 
> > Wont work. We are replacing a 32bit call with a nop. That nop must also
> > be 32bits, because we could eventually replace the nop(s) with a 32bit
> > call.
> 
> ... which, if it's misaligned to a 32-bit boundary, which can happen with
> Thumb-2 code, will require the replacement to be done atomically; you will
> need to use stop_machine() to ensure that other CPUs don't try to execute
> the instruction mid-way through modification... as I have already
> explained in my previous mails.

If there's no way to modify a 32bit operation without stop_machine(),
ever with a breakpoint, than we can stop the discussion here. ARM will
forever require stop_machine() for use with tracepoints and ftrace. Too
bad, as ARM was the x86 competitor. Here's something that x86 has a one
up on ARM.

-- Steve
