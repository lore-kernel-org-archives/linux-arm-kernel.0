From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Dec 2017 14:56:18 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171212164900.GA6673@linux.vnet.ibm.com>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
Message-ID: <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Dec 12, 2017 at 2:49 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> On the perhaps unlikely off-chance that it is both useful and welcome,
> the (untested, probably does not even build) patch below illustrates the
> use of smp_call_function_single().  This is based on the patch Russell
> sent -- for all I know, it might well be that there are other places
> needing similar changes.
>
> But something to try out for anyone wishing to do so.
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit c579a1494ccbc7ebf5548115571a2988ea1a1fe5
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Dec 11 09:40:58 2017 -0800
>
>     ARM: CPU hotplug: Delegate complete() to surviving CPU
>
>     The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
>     does so after RCU has stopped watching the outgoing CPU, which results
>     in lockdep complaints because complete() invokes functions containing RCU
>     readers.  This patch therefore uses Thomas Gleixner's trick of delegating
>     the complete() call to a surviving CPU via smp_call_function_single().
>
>     This patch is untested, and probably does not even build.
>
>     Reported-by: Peng Fan <van.freenix@gmail.com>
>     Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

With your patch applied I no longer get the RCU warning, thanks:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
