From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Jun 2015 18:37:00 -0700
Subject: [PATCH 1/4] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
Message-ID: <5593443C.5070800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 02:23 PM, Timur Tabi wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
>
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
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Acked-by: Adam Wallis <awallis@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Maybe we should look into making the console number (i.e. ttyHVC0,
ttyHVC1, etc.) correspond to the logical CPU number 0, 1, etc? We would
need some hotplug notifier to tear down and restore the console when the
CPU comes online and goes offline, but it may work out nicer than taking
the approach this patch does.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
