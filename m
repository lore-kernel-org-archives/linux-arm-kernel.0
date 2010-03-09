From: smuckle@codeaurora.org (Steve Muckle)
Date: Tue, 09 Mar 2010 11:33:12 -0800
Subject: secondary processor initialization
Message-ID: <4B96A278.4060300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Scorpion CPU requires some low level initialization (like cache
timing registers). Currently we take care of that in the bootloader.
This seems to fit with what I've heard as a desire to keep CPU
implementation-specific initialization out of the kernel.

We are adding support for a dual core Scorpion target. The second core
will require some amount of initialization as well. If we take the
second core out of reset directly into the kernel, we would have to put
this initialization in the kernel.

Another option is having the secondary CPU(s) execute a portion of the
bootloader and come in through the main kernel entrypoint. This
simplifies things but would mean having to put a hook very early in the
primary boot path, compiled if SMP is configured, which checks the MPIDR
and reroutes secondary CPUs.

It would also be possible to somehow communicate the secondary CPU
entrypoint from CPU0 in the kernel to secondary CPUs in the bootloader,
but that seems uglier than the second option above IMO.

Any thoughts?

thanks,
Steve
