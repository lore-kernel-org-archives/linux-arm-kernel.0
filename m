From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jul 2015 21:49:09 +0100
Subject: mx6: suspicious RCU usage
In-Reply-To: <20150714162600.GJ3717@linux.vnet.ibm.com>
References: <CAOMZO5DeOLORXUAgYN2_BkB1BS8wuF8CoTf=QOfU1fB-je0UHQ@mail.gmail.com>
 <20150714160006.GI3717@linux.vnet.ibm.com>
 <CAOMZO5Bbj2FjWxNGDUHSHXCPFC1A7F6sO6AepZjRZoxHY-kgYg@mail.gmail.com>
 <20150714162600.GJ3717@linux.vnet.ibm.com>
Message-ID: <20150714204909.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 09:26:00AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 14, 2015 at 01:06:32PM -0300, Fabio Estevam wrote:
> > Hi Paul,
> > 
> > On Tue, Jul 14, 2015 at 1:00 PM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Does this patch help?
> > >
> > >         https://lkml.org/lkml/2015/5/12/885
> > 
> > I am using an ARM 32-bit machine, so I used this one instead:
> > https://lkml.org/lkml/2015/5/12/892
> > 
> > , and it fixes the problem. Thanks!
> > 
> > Feel free to add:
> > 
> > Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Glad it helped!
> 
> Russell, did you want me to push this, or would you rather take it?

If it's the one I'm thinking of (using the generic code) because it
doesn't actually solve the problem we have.  It may shut up the RCU
warning, but it doesn't solve the underlying problem - one which is
caused by the use of atomics (which use the exclusive instructions)
vs cache line migration between CPUs vs speculative prefetching...

It's possible right now that _dirty_ cache lines can be migrated to
the dying CPU, which are then lost on power down - and if we disable
the caches on the dying CPU, we then can't use exclusives, so atomics
(and all of the other normal kernel synchronisation mechanisms) are
out of the question.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
