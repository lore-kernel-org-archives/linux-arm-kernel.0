From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Apr 2017 11:56:29 +0100
Subject: Bad page state splats on arm64, v4.11-rc{3,4}
In-Reply-To: <20170331175845.GE6488@leverpostej>
References: <20170331175845.GE6488@leverpostej>
Message-ID: <20170403105629.GB18905@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 06:58:45PM +0100, Mark Rutland wrote:
> Hi,
> 
> I'm seeing intermittent bad page state splats on arm64 with 4.11-rc3 and
> v4.11-rc4. I have not tested earlier kernels, or other architectures.
> 
> So far, it looks like the flags are always bad in the same
> way:
> 
> 	bad because of flags: 0x80(waiters)
> 
> ... though I don't know if that's definitely the case for splat 4, the
> BUG at mm/page_alloc.c:800.
> 
> I see this in QEMU VMs launched by Syzkaller, triggering once every few
> hours. So far, I have not been able to reproduce the issue in any other
> way (including using syz-repro).

It looks like this may be an issue with the arm64 HUGETLB code.

I wasn't able to trigger the issue over the weekend on a kernel with
HUGETLBFS disabled. There are known issues with our handling of
contiguous entries, and this might be an artefact of that.

I'll see if I can narrow this down any further.

Thanks,
Mark.
