From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Jun 2017 12:43:53 +0200
Subject: [PATCH v2 0/2] arm64: fix crash when reading /proc/kcore
Message-ID: <1497437035-11979-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up to patches from zhonjiang [0] and myself [1] that aim
to solve a problem in the kcore code, which gets confused by the presence
of block mappings in the vmalloc region.

While fixing the crash is quite straight forward [2], we need to tweak
the kcore code itself to ensure that it operates correctly on arm64.
Fortunately, we can achieve this with two very simple changes:

- replace a call to is_vmalloc_or_module_addr() in read_kcore() with a
  comparison of the kclist type field (#1)
- enable CONFIG_ARCH_PROC_KCORE_TEXT for arm64 (#2)

[0] http://marc.info/?l=linux-mm&m=149632393629295&w=2
[1] http://marc.info/?l=linux-mm&m=149685966530180&w=2
[2] http://marc.info/?l=linux-mm&m=149694975123959&w=2

v2: add acks only, no code changes

Will, Catalin, could you queue these for v4.13 please?

Ard Biesheuvel (2):
  fs/proc: kcore: use kcore_list type to check for vmalloc/module
    address
  arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT

 arch/arm64/Kconfig | 3 +++
 fs/proc/kcore.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4
