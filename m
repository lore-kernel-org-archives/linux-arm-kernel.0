From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jun 2011 11:29:12 +0100
Subject: [PATCH 1/1] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
In-Reply-To: <4E097B58.3050301@st.com>
References: <cover.1309163073.git.wolfgang.betz@st.com>
	<3a6d2636489958d097cd013cad646fed012421dd.1309163073.git.wolfgang.betz@st.com>
	<20110627113707.GD16103@n2100.arm.linux.org.uk>
	<4E097B58.3050301@st.com>
Message-ID: <20110628102912.GB21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 08:57:28AM +0200, Wolfgang BETZ wrote:
> First of all, the case you are mentioning is very rarely met in embedded
> systems, where we are dealing with less processes - not hundreds.
> Furthermore, we are tracing seconds to minutes. So usually this is not
> an issue for Lauterbach and above all their customers. They already
> have several customers using this patch - without running into this
> trouble.

It is not about how many processes are running in total, it is about
how many processes you are running _and_ how many you've started up.

Each time a thread is created via fork(), or it executes a new program
via execve(), a new ASID number will be assigned to the new context.
So, each time a process decides to execute something as a sub-process,
you will eat through two ASID numbers.

This means that if your system boot has run around 120 programs, you
are very close to an ASID reallocation event, and if you are tracing
or debugging at that time using this facility, all your context IDs
immediately become invalid.

If your system does not involve executing programs after boot, then
you are safe, but I suspect that is only true of a very small minority
of embedded systems.

> In any case - *if* we get into this, it's very simple in TRACE32 to
> ignore the ASID while extracting the ContextID from the trace - the
> PID should be unique anyway. Therefore we think it is more a problem
> of the back-end tool which elaborates the trace.

My concern is that you may be tempted to use CONTEXTIDR to control
debugging activity, users will set a breakpoint and (to them) for some
unknown reason their breakpoint isn't hit because the ASIDs were
reallocated.

To me it just feels extremely fragile, leads to surprises, and I _really_
don't like that.  I've been on the customer end of fragile embedded tools,
and I know full well that its these kinds of things that piss customers
off and waste their time.

I've spent more time debugging CPU ICE systems than debugging my programs
which are supposed to be running on those CPUs - and had to because the
real CPU was an OTP device.

So, when presented with a patch which is inherently fragile, I'm going
to say no to it given my personal frustrating experiences of fragile
embedded tools.

I hope that by saying no to this kind of thing I can save some other poor
embedded engineer many hours of head-scratching wondering why the
expensive tool they bought/hired doesn't actually work.
