From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  7 May 2014 10:51:55 +0100
Subject: [PATCH 0/2] arm: alignment trap tweaks
Message-ID: <cover.1399028497.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Revisiting the alignment trap again thanks to an obscure corner case
with NEON alignment hints - patch 1 is a repost from a while back as a
ping, because modern userspaces really should just get a resounding
"Don't do that!" if they manage to step outside the architecture.
Patch 2 is the fix for cases where fixup does need to be turned back on
for whatever reason.

The following testcase compiled with -marm illustrates the problem:
with fixup enabled, when the VLD1 instruction with the alignment hint
set faults by performing a misaligned access, it fails to load the NEON
registers as expected and eventually writes back nonsense to the base
register, resulting in a misleading segfault on the next iteration.

--->8---

#include <stdint.h>
#include <stdio.h>

static uint8_t buffer[256], got[256];

int main() {
	uint8_t *base = (uint8_t *)((intptr_t)buffer + 0x7 & ~0x7);
	void *p = base, *q = got;
	int i;

	for (i=0; i<64; i++)
		base[i] = i;
	for (i=0; i<4; i++) {
		asm volatile ("vld1.8 {d0,d1}, [%0]\n vst1.8 {d0,d1}, [%1]\n"
				: "=r"(p),"=r"(q) : "0"(p),"1"(q) : "d0","d1");
		printf("unaligned: %p [%d,%d,%d,...]\n", p++, got[0], got[1], got[2]);
	}
	p = base;
	for (i=0; i<4; i++) {
		asm volatile ("vld1.8 {d0,d1}, [%0:64]\n vst1.8 {d0,d1}, [%1]\n"
				: "=r"(p),"=r"(q) : "0"(p),"1"(q) : "d0","d1");
		printf("misaligned: %p [%d,%d,%d,...]\n", p++, got[0], got[1], got[2]);
	}
	return 0;
}

--->8---

Robin Murphy (2):
  arm: SIGBUS on unsupported ARMv6 unaligned accesses
  arm: don't break misaligned NEON load/store

 arch/arm/mm/alignment.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--
1.7.9.5
