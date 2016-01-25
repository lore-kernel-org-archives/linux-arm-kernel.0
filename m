From: hannes@cmpxchg.org (Johannes Weiner)
Date: Mon, 25 Jan 2016 13:55:38 -0500
Subject: [PATCH] mm/memcontrol: avoid a spurious gcc warning
In-Reply-To: <1453736756-1959377-3-git-send-email-arnd@arndb.de>
References: <1453736756-1959377-3-git-send-email-arnd@arndb.de>
Message-ID: <20160125185538.GF29291@cmpxchg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jan 25, 2016 at 04:45:50PM +0100, Arnd Bergmann wrote:
> When CONFIG_DEBUG_VM is set, the various VM_BUG_ON() confuse gcc to
> the point where it cannot remember that 'memcg' is known to be initialized:
> 
> mm/memcontrol.c: In function 'mem_cgroup_can_attach':
> mm/memcontrol.c:4791:9: warning: 'memcg' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> On ARM gcc-5.1, the above happens when any two or more of the VM_BUG_ON()
> are active, but not when I remove most or all of them. This is clearly
> random behavior and the only way I've found to shut up the warning is
> to add an explicit initialization.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

This has been fixed upstream already:

commit eed67d75b66748a498a0592d9704081a98509444
Author: Ross Zwisler <ross.zwisler@linux.intel.com>
Date:   Wed Dec 23 14:53:27 2015 -0700

    cgroup: Fix uninitialized variable warning
    
    Commit 1f7dd3e5a6e4 ("cgroup: fix handling of multi-destination migration
    from subtree_control enabling") introduced the following compiler warning:
    
    mm/memcontrol.c: In function ?mem_cgroup_can_attach?:
    mm/memcontrol.c:4790:9: warning: ?memcg? may be used uninitialized in this function [-Wmaybe-uninitialized]
       mc.to = memcg;
             ^
    
    Fix this by initializing 'memcg' to NULL.
    
    This was found using gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6).
    
    Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
    Signed-off-by: Tejun Heo <tj@kernel.org>
