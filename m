From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Dec 2017 17:34:51 +0000
Subject: WARNING: suspicious RCU usage
In-Reply-To: <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
Message-ID: <20171212173450.GD10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 02:56:18PM -0200, Fabio Estevam wrote:
> Hi Paul,
> 
> On Tue, Dec 12, 2017 at 2:49 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On the perhaps unlikely off-chance that it is both useful and welcome,
> > the (untested, probably does not even build) patch below illustrates the
> > use of smp_call_function_single().  This is based on the patch Russell
> > sent -- for all I know, it might well be that there are other places
> > needing similar changes.
> >
> > But something to try out for anyone wishing to do so.
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit c579a1494ccbc7ebf5548115571a2988ea1a1fe5
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Dec 11 09:40:58 2017 -0800
> >
> >     ARM: CPU hotplug: Delegate complete() to surviving CPU
> >
> >     The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
> >     does so after RCU has stopped watching the outgoing CPU, which results
> >     in lockdep complaints because complete() invokes functions containing RCU
> >     readers.  This patch therefore uses Thomas Gleixner's trick of delegating
> >     the complete() call to a surviving CPU via smp_call_function_single().
> >
> >     This patch is untested, and probably does not even build.
> >
> >     Reported-by: Peng Fan <van.freenix@gmail.com>
> >     Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> With your patch applied I no longer get the RCU warning, thanks:
> 
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

It's fundamentally unsafe.

You need to test with CONFIG_BL_SWITCHER enabled - there's spinlocks
in smp_call_function_single() path that are conditional on that symbol.
If CONFIG_BL_SWITCHER is disabled, then the spinlocks are not present.

The problem is that the IPI will be sent with the spinlock held.  The
IPI'd CPU will then do the completion, and the CPU requesting the
death will continue, and could power down the dying CPU _before_ the
unlock of that spinlock becomes visible to other CPUs in the system.

So, we end up with a spinlock permanently held.

Whether this happens or not depends on timing, and whether the unlock
gets evicted from the dying CPU.

If you attempt to clean the caches after the unlock to force that unlock
out, then you need a way to make the requesting CPU wait for the dying
CPU to finish that action... oh, that's what this complete() is trying
to do here in the first place.

So we're back to exactly where we were without this patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
