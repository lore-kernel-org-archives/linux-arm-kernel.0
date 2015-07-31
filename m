From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 31 Jul 2015 03:09:48 +0300
Subject: [PATCH v2 0/2] pd: fix resource deallocation on error path
Message-ID: <1438301390-7397-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first change fixes a bug introduced by 2be2a3ff42a5, memory
allocated by kstrdup_const() must be always deallocated with
kfree_const(), otherwise there is a risk of kfree'ing ro memory.

The second change removes double of_node_put(), if
for_each_compatible_node() body execution is not terminated. This
prevents from object refcounter overflow over zero in OF_DYNAMIC
build.

Vladimir Zapolskiy (2):
  ARM: EXYNOS: pd: fix potentian kfree() of ro memory
  ARM: EXYNOS: fix double of_node_put() on error path

 arch/arm/mach-exynos/pm_domains.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.1.4
