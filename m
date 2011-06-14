From: ankita@in.ibm.com (Ankita Garg)
Date: Tue, 14 Jun 2011 14:21:37 +0530
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610200233.5ddd5a31@infradead.org>
References: <20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
Message-ID: <20110614085137.GA7614@in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 10, 2011 at 08:02:33PM -0700, Arjan van de Ven wrote:
> On Fri, 10 Jun 2011 12:37:13 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jun 10, 2011 at 08:23:29PM +0100, Matthew Garrett wrote:
> > > On Fri, Jun 10, 2011 at 11:47:38AM -0700, Paul E. McKenney wrote:
> > > 
> > > > And if I understand you correctly, then the patches that Ankita
> > > > posted should help your self-refresh case, along with the
> > > > originally intended the power-down case and special-purpose use
> > > > of memory case.
> > > 
> > > Yeah, I'd hope so once we actually have capable hardware.
> > 
> > Cool!!!
> > 
> > So Ankita's patchset might be useful to you at some point, then.
> > 
> > Does it look like a reasonable implementation?
> 
> as someone who is working on hardware that is PASR capable right now,
> I have to admit that our plan was to just hook into the buddy allocator,
> and use PASR on the top level of buddy (eg PASR off blocks that are
> free there, and PASR them back on once an allocation required the block
> to be broken up)..... that looked the very most simple to me.
>

We were looking at a generic approach to exploit the different types of
memory power management features present in the hardware, like PASR,
power off and automatic transition into lower power states. To actively
create opportunities to exploit these features, appropriately guiding
memory allocations/deallocations, reclaim and statistics gathering is
essential. A few usecases are -

- allocating all memory from one region before moving over to the next
  region would theoretically ensure that the second region could be kept
  into lower power state for a longer period or turned off
- regions could be created consisting of only movable memory, thus
  making it possible to evacuate an entire region
- when memory utilization is low, selected memory regions could be
  removed as target for allocation itself. These regions need not be
  only turned off to save power, if the hardware supports, these regions
  could be put into content preserving lower power state if they are not
  being referenced
- depending upon the memory utilization of the different regions,
  targeted reclaim and memory migration could be triggered in a few
  regions with the aim of freeing memory

Grouping memory at the level of the buddy allocator for this purpose
might be tougher. 

> Maybe something much more elaborate is needed, but I didn't see why so
> far.
> 
> 

-- 
Regards,
Ankita Garg (ankita at in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
