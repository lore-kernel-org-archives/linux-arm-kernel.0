From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Fri, 28 Nov 2014 15:17:59 +0100
Subject: [RFC 0/7] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <54788417.6020408@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am 12.10.2014 um 20:13 schrieb Stefan Agner:
> One thing I noticed that when I move the xipImage below the DRAM base
> address, the kernel freezes:
> ...
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [freeze]
> 
> I think it happens when the scheduler gets started. Any idea what could
> go wrong here?

I ran into a similar issue on STM32F4 recently - hanging there, or:

Unhandled exception: IPSR = 00000006 LR = fffffff1
CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc5-00003-g489983a-dirty #25
task: 90432000 ti: 90434000 task.ti: 90434000

Unhandled exception: IPSR = 00000003 LR = fffffff1
CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc5-00003-g489983a-dirty #25
task: 90432000 ti: 90434000 task.ti: 90434000
-Boot 2010.03-00003-g934021a-dirty (Nov 26 2014 - 06:52:49)

My debugging indicated that %pF was not working, used among others in
checking for blacklisted initcalls. Disabling CONFIG_KALLSYMS worked
around this, so I assume something there is not compatible with XIP...

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
