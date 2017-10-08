From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 9 Oct 2017 00:30:52 +0300
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 02:34:37PM +0100, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I posted yesterday:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
> 
> I'd normally leave it longer before posting again, but Peter had a good
> suggestion to rework the layout of the lock word, so I wanted to post a
> version that follows that approach.
> 
> I've updated my branch if you're after the full patch stack:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock
> 
> As before, all comments (particularly related to testing and performance)
> welcome!
> 
> Cheers,
> 
> Will

Hi Will,

I tested your patches with locktorture and found measurable performance
regression. I also respin the patch of Jan Glauber [1], and I also
tried Jan's patch with patch 5 from this series. Numbers differ a lot
from my previous measurements, but since that I changed working
station and use qemu with the support of parallel threads.
                        Spinlock        Read-RW lock    Write-RW lock
Vanilla:                129804626       12340895        14716138
This series:            113718002       10982159        13068934
Jan patch:              117977108       11363462        13615449
Jan patch + #5:         121483176       11696728        13618967

The bottomline of discussion [1] was that queued locks are more
effective when SoC has many CPUs. And 4 is not many. My measurement
was made on the 4-CPU machine, and it seems it confirms that. Does
it make sense to make queued locks default for many-CPU machines only?

There were 2 preparing patches in the series: 
[PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock
and
[PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h

1st patch is not needed anymore because Babu Moger submitted similar patch that
is already in mainline: 9ab6055f95903 ("kernel/locking: Fix compile error with
qrwlock.c"). Could you revisit second patch?

[1] https://lkml.org/lkml/2017/5/3/330

Yury
