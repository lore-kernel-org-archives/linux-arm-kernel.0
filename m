From: gking@nvidia.com (Gary King)
Date: Tue,  7 Sep 2010 13:45:34 -0700
Subject: [PATCH] bounce: call flush_dcache_page after bounce_copy_vec
Message-ID: <1283892334-9238-1-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been seeing problems on Tegra 2 (ARMv7 SMP) systems with HIGHMEM
enabled on 2.6.35 (plus some patches targetted at 2.6.36 to perform
cache maintenance lazily), and the root cause appears to be that the
mm bouncing code is calling flush_dcache_page before it copies the
bounce buffer into the bio.

The patch below reorders these two operations, and eliminates numerous
arbitrary application crashes on my dev system.

Gary

--
