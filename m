From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jun 2015 14:58:15 +0100
Subject: [PATCH 1/3] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
References: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150630135815.GK27725@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 07:52:34PM +0100, Timur Tabi wrote:
> Some debuggers, such as Trace32 from Lauterbach GmbH, do not handle
> reads/writes from/to DCC on secondary cores.  Each core has its
> own DCC device registers, so when a core reads or writes from/to DCC,
> it only accesses its own DCC device.  Since kernel code can run on
> any core, every time the kernel wants to write to the console, it
> might write to a different DCC.
> 
> In SMP mode, Trace32 only uses the DCC on core 0.  In AMP mode, it
> creates multiple windows, and each window shows the DCC output
> only from that core's DCC.  The result is that console output is
> either lost or scattered across windows.
> 
> Selecting this option will enable code that serializes all console
> input and output to core 0.  The DCC driver will create input and
> output FIFOs that all cores will use.  Reads and writes from/to DCC
> are handled by a workqueue that runs only core 0.

What happens if CPU0 is hotplugged off?

Will
