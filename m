From: koct9i@gmail.com (Konstantin Khlebnikov)
Date: Sun, 11 Jan 2015 12:23:56 +0400
Subject: [RFC] mm:change meminfo cached calculation
In-Reply-To: <alpine.LSU.2.11.1501061747540.2041@eggly.anvils>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <CALYGNiOuBKz8shHSrFCp0BT5AV6XkNOCHj+LJedQQ-2YdZtM7w@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
 <20141205143134.37139da2208c654a0d3cd942@linux-foundation.org>
 <35FD53F367049845BC99AC72306C23D103E688B313F4@CNBJMBX05.corpusers.net>
 <20141208114601.GA28846@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313FB@CNBJMBX05.corpusers.net>
 <CALYGNiMEytHuND37f+hNdMKqCPzN0k_uha6CaeL_fyzrj-obNQ@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B31408@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103EDAF89E14C@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103EDAF89E160@CNBJMBX05.corpusers.net>
 <20150106164340.55e83f742d6f57c19e6500ff@linux-foundation.org>
 <alpine.LSU.2.11.1501061654340.1497@eggly.anvils>
 <20150106172518.8f84bffdfa0d35336b233d07@linux-foundation.org>
 <alpine.LSU.2.11.1501061747540.2041@eggly.anvils>
Message-ID: <CALYGNiM11DRqJ5OT+27Db3O_0w7v7iMHquRH+V-gi=rjYy4hKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 7, 2015 at 5:03 AM, Hugh Dickins <hughd@google.com> wrote:
> On Tue, 6 Jan 2015, Andrew Morton wrote:
>> On Tue, 6 Jan 2015 17:04:33 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
>> > On Tue, 6 Jan 2015, Andrew Morton wrote:
>> > > On Fri, 26 Dec 2014 19:56:49 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:
>> > >
>> > > > This patch subtract sharedram from cached,
>> > > > sharedram can only be swap into swap partitions,
>> > > > they should be treated as swap pages, not as cached pages.
>> > > >
>> > > > ...
>> > > >
>> > > > --- a/fs/proc/meminfo.c
>> > > > +++ b/fs/proc/meminfo.c
>> > > > @@ -45,7 +45,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>> > > >         committed = percpu_counter_read_positive(&vm_committed_as);
>> > > >
>> > > >         cached = global_page_state(NR_FILE_PAGES) -
>> > > > -                       total_swapcache_pages() - i.bufferram;
>> > > > +                       total_swapcache_pages() - i.bufferram - i.sharedram;
>> > > >         if (cached < 0)
>> > > >                 cached = 0;
>> > >
>> > > Documentation/filesystems/proc.txt says
>> > >
>> > > :      Cached: in-memory cache for files read from the disk (the
>> > > :              pagecache).  Doesn't include SwapCached
>> > >
>> > > So yes, I guess it should not include shmem.
>> > >
>> > > And why not do this as well?
>> > >
>> > >
>> > > --- a/Documentation/filesystems/proc.txt~mm-change-meminfo-cached-calculation-fix
>> > > +++ a/Documentation/filesystems/proc.txt
>> > > @@ -811,7 +811,7 @@ MemAvailable: An estimate of how much me
>> > >       Buffers: Relatively temporary storage for raw disk blocks
>> > >                shouldn't get tremendously large (20MB or so)
>> > >        Cached: in-memory cache for files read from the disk (the
>> > > -              pagecache).  Doesn't include SwapCached
>> > > +              pagecache).  Doesn't include SwapCached or Shmem.
>> > >    SwapCached: Memory that once was swapped out, is swapped back in but
>> > >                still also is in the swapfile (if memory is needed it
>> > >                doesn't need to be swapped out AGAIN because it is already
>> >
>> > Whoa.  Changes of this kind would have made good sense about 14 years ago.
>> > And there's plenty more which would benefit from having anon/shmem/file
>> > properly distinguished.  But how can we make such a change now,
>> > breaking everything that has made its own sense of these counts?
>>
>> That's what I was wondering, but I was having some trouble picking a
>> situation where it mattered much.
>
> If it doesn't matter, then we don't need to change it.
>
>> What's the problematic scenario
>> here?  Userspace that is taking Cached, saying "that was silly" and
>> subtracting Shmem from it by hand?
>
> Someone a long time ago saw "that was silly", worked out it was because
> of Shmem, adjusted their scripts or whatever accordingly, and has run
> happily ever since.

Totally agree. I know some of these guys.
But that's here not for so long time, 'Shmem' has appeared only in 2.6.32.

>
>>
>> I suppose that as nobody knows we should err on the side of caution and
>> leave this alone.  But the situation is pretty sad - it would be nice
>> to make the code agree with the documentation at least.
>
> By all means fix the documentation.  And work on a /proc/meminfo.2015
> which has sensibly differentiated counts (and probably omits that
> wonderful Linux 2.2-compatible "Buffers").

'Buffers' is actually very useful. Ext4 keeps almost all metadata in
bdev page-cache.

Meminfo has a bigger and much more confusing problem: there is no subset of
fields which sums to all ram. Some paged allocations are showed nowhere.

Probably it would be good to show that 'Untracked' memory as well,
calculated as:
Total - Free - Cached - Buffers - Slab - PageTables - KernelStack - AnonPages.
(fix me if I'm wrong =)

>
> But there's more to do than I can think of.  Cc'ing Jerome who has a
> particular interest in this (no, I haven't forgotten his patches,
> but nor have I had a moment to reconsider them).
>
> Hugh
