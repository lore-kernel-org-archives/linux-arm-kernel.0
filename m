From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2016 11:30:32 +0000
Subject: [bug report v4.8] fs/locks.c: kernel oops during posix lock
 stress test
In-Reply-To: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
References: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
Message-ID: <20161201113031.GB5813@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 11:10:14AM +0800, Ming Lei wrote:
> When I run stress-ng via the following steps on one ARM64 dual
> socket system(Cavium Thunder), the kernel oops[1] can often be
> triggered after running the stress test for several hours(sometimes
> it may take longer):
> 
> - git clone git://kernel.ubuntu.com/cking/stress-ng.git
> - apply the attachment patch which just makes the posix file
> lock stress test more aggressive
> - run the test via '~/git/stress-ng$./stress-ng --lockf 128 --aggressive'
> 
> 
> From the oops log, looks one garbage file_lock node is got
> from the linked list of 'ctx->flc_posix' when the issue happens.
> 
> BTW, the issue isn't observed on single socket Cavium Thunder yet,
> and the same issue can be seen on Ubuntu Xenial(v4.4 based kernel)
> too.

FWIW, I've been running this on Seattle for 24 hours with your patch applied
and not seen any problems yet. That said, Thomas did just fix an rt_mutex
race which only seemed to pop up on Thunder, so you could give those
patches a try.

  https://lkml.kernel.org/r/20161130205431.629977871 at linutronix.de

Will
