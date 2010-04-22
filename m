From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 22 Apr 2010 16:59:31 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <000101cae21e$403e4740$4044010a@Emea.Arm.com>
References: <20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421193534.GC26616@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1004211723230.7232@xanadu.home>
	<20100421214447.GK26616@n2100.arm.linux.org.uk>
	<20100421215425.GL26616@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1004211848151.7232@xanadu.home>
	<000001cae20a$6ab7c820$4044010a@Emea.Arm.com>
	<20100422122901.GA5126@desktop>
	<000101cae21e$403e4740$4044010a@Emea.Arm.com>
Message-ID: <20100422155931.GB6265@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave P. Martin wrote:
> From: anfei [mailto:anfei.zhou at gmail.com] 
> > On Thu, Apr 22, 2010 at 11:56:09AM +0100, Dave P. Martin wrote:
> > >   * I haven't tested this on 926 myself
> > >   * On armv7, I have observed the problem only on *old* kernels 
> > > (<2.6.32; which lack any of the patches under discussion)
> > >   * Using 2.6.34-rc1 (from rmk's versatile branch) on 
> > armv7, I get the 
> > > expected SEGV when userspace tries to execute >= TASK_SIZE
> > > 
> > > so...
> > >   * Sasha's problem is caused by a problem in the current kernel
> > >   on 926.
> > >   * My problem relates to v7 and has already been fixed (but isn't 
> > > fixed in the Ubuntu kernels yet)
> > > 
> > > The test case was
> > > 
> > > int main(void)
> > > {
> > >   ((void (*)(void))0xc0000000)();
> > >   return 0;
> > > }
> > > 
> > I did a test on arm926 using QEMU with the latest kernel 
> > (just pull from git.kernel.org).  Without checking user_mode, 
> > this test case will continue to trigger do_translation_fault 
> > with address 0xc0000000, so I think that two-liner patch is 
> > necessary.  With it, the case will get SIGSEGV, and the 
> > system seems running well.
> 
> That matches my understanding--- it sounds like the two-liner is relevant
> for all pre-v6 platforms (including ARM926), so it probably makes sense to
> merge it.

Good. Both results are consistent with the earlier discussion about
the two patches (one already committed).

There are two different bugs with the same symptom on different
devices.  No wonder Russell's confused by this thread.

The two-liner is the least complicated solution for pre-v6.
Commit the damn thing already ;-)

Reviewed-By: Jamie Lokier <jamie@shareable.org>

-- Jamie
