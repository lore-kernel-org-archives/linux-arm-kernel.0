From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2011 12:37:08 +0100
Subject: [PATCH 1/1] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
In-Reply-To: <3a6d2636489958d097cd013cad646fed012421dd.1309163073.git.wolfgang.betz@st.com>
References: <cover.1309163073.git.wolfgang.betz@st.com>
	<3a6d2636489958d097cd013cad646fed012421dd.1309163073.git.wolfgang.betz@st.com>
Message-ID: <20110627113707.GD16103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 01:12:27PM +0200, Wolfgang BETZ wrote:
> The aim of this patch is to enable thread support in the context ID register
> (CONTEXTIDR) as it comes with ARM architectures v6 & v7.
> 
>  On ARMv6 & v7, we have the following structure in the context ID:
> 
>    31                         7          0
>    +-------------------------+-----------+
>    |      process ID         |   ASID    |
>    +-------------------------+-----------+
>    |              context ID             |
>    +-------------------------------------+
> 
> - The ASID is used to tag entries in the CPU caches and TLBs.
> - The context ID is used by debuggers and trace logic, and
>   should be unique within all running processes.

When I added ARMv6 and v7 support to the kernel, I purposely ignored that
detail because it's silly.

The issue here is that the debuggers and trace logic use both the
process ID and the ASID together, and the ASID does not have a stable
value for any particular process in the system.  When we have used
the last ASID (255), the next request for a new ASID causes the ASID
generation to increment, which in turn causes all processes in the
system to have their ASIDs reassigned.

At that point, if you have debugging/trace hardware setup to look for
a process with a particular process ID+ASID, you're no longer going to
get matches for your original process.

This makes the whole concept of debuggers/tracing using the context ID
rather pointless especially in a multiprocessor system.

How are you working around this issue?
