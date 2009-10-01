From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:10 +0200
Subject: [PATCH] FCSE
Message-ID: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Here comes the FCSE patch for Linux 2.6.32-rc1. 

To summarize a bit the story of this patch which you will find in
various posts on this list, this patch adds an option to the kernel
configuration which allows using the ARM FCSE in one of two modes:
- the guaranteed mode, where context switches are guaranteed to run
without flushing the caches, but where the number of processes is
limited to 95 with a virtual memory space limited to 32 MB;
- the best-effort mode, where the limitations are removed, but where
the cache is flushed when needed during context switches.

The patch can be considered as relatively stable, it has not changed
much since Linux 2.6.27, and has been validated by running LTP with
the best-effort mode, with no differences in the LTP results compared
to an unpatched kernel. Furthermore, it has been reported to work in
the field.

As for the performance improvement, running the hackbench test with
400 processes (so, well above the 95 processes limit) on an AT91RM9200
showed an improvement in the runing time which can be visualized here:
http://sisyphus.hd.free.fr/~gilles/hackbench.png.

The user-space worst-case scheduling latency is also improved by the
guaranteed mode, but this only interests people running an RT kernel
of any kind.

The patch is relatively simple and only modifies ARM-specific code,
but has been split to ease review, as I have been advised off-list to
do. Some parts of it, however, could be implemented more elegantly
(to say the least), especially patches 8 and 9 which intercept
set_pte_at() to count pages belonging to some types of mappings
whereas counting mappings would be enough but would probably require
to modify generic code.

Thanks in advance for your review.
Regards

-- 
					    Gilles.
