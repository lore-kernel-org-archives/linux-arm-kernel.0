From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Aug 2013 07:07:04 +1000
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <520A7B00.8060405@arm.com>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
Message-ID: <1376428024.4255.14.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 19:29 +0100, Sudeep KarkadaNagesha wrote:
> I don't understand completely the use of ibm,ppc-interrupt-server#s and
> its implications on generic of_get_cpu_node implementation.
> I see the PPC specific definition of of_get_cpu_node uses thread id only
> in 2 instances. Based on that, I have tried to move all the other
> instances to use generic definition.
> 
> Let me know if the idea is correct.

No. The device-tree historically only represents cores, not HW threads, so
it makes sense to retrieve also the thread number corresponding to the CPU.

However, the mechanism to represent HW threads in the device-tree is currently
somewhat platform specific (the ibm,ppc-interrupt-server#s).

So what you could do for now is:

 - Have a generic version that always returns 0 as the thread, which is weak

 - powerpc keeps its own implementation

 - Start a discussion on the bindings (if not already there) to define threads
in a better way at which point the generic function can be updated.

Cheers,
Ben.
