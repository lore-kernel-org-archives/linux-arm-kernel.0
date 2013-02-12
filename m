From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 Feb 2013 08:15:30 -0800
Subject: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
In-Reply-To: <20130210195417.GK2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <20130210180607.GA1375@redhat.com>
 <20130210195417.GK2666@linux.vnet.ibm.com>
Message-ID: <20130212161530.GA9929@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 11:54:17AM -0800, Paul E. McKenney wrote:
> On Sun, Feb 10, 2013 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > On 02/08, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > > +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
> > > > +			       unsigned int cpu)
> > > > +{
> > > > +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
> > >
> > > As I understand it, the purpose of this memory barrier is to ensure
> > > that the stores in drop_writer_signal() happen before the reads from
> > > ->reader_refcnt in reader_uses_percpu_refcnt(), thus preventing the
> > > race between a new reader attempting to use the fastpath and this writer
> > > acquiring the lock.  Unless I am confused, this must be smp_mb() rather
> > > than smp_rmb().
> > 
> > And note that before sync_reader() we call announce_writer_active() which
> > already adds mb() before sync_all_readers/sync_reader, so this rmb() looks
> > unneeded.
> > 
> > But, at the same time, could you confirm that we do not need another mb()
> > after sync_all_readers() in percpu_write_lock() ? I mean, without mb(),
> > can't this reader_uses_percpu_refcnt() LOAD leak into the critical section
> > protected by ->global_rwlock? Then this LOAD can be re-ordered with other
> > memory operations done by the writer.
> 
> As soon as I get the rest of the way through Thomas's patchset.  ;-)

There is a memory barrier associated with write_lock(), but it is
only required to keep the critical section inside the lock -- and is
permitted to allow stuff outside of the lock to be reordered into the
critical section.  So I believe we do indeed need an smp_mb() between
sync_all_readers() and write_lock() in percpu_write_lock().

Good eyes, Oleg!

							Thanx, Paul
