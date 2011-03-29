From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Mar 2011 16:21:44 +0100
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in
	for device accesses
In-Reply-To: <AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
Message-ID: <1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-29 at 16:02 +0100, Martin Furmanski wrote:
> Do you have a reference on this?

Usually the ARM ARM but a document with examples is this:

http://infocenter.arm.com/help/topic/com.arm.doc.genc007826/Barrier_Litmus_Tests_and_Cookbook_A08.pdf

(infocenter.arm.com -> Developer Guides and Articles -> ARM architecture
-> Barrier Litmus and Tests Cookbook)

> I have been under the impression that DMB is a barrier for all memory
> accesses. I find no support in ARMv7, for the hypothesis that DSB is
> needed to order between Device and Normal.

The key point is that DMB only ensures the *observability* of memory
accesses by the processors and not arrival to the device or block of
memory. In the drawing below, DMB only ensures the ordering at point
(1). For arrival to RAM or Device you need a DSB.

       +------+     +------+
       |  P1  |     |  P2  |
       +------+     +------+
          |     (1)     |
          +------+------+
                 |
   +-------------+-------------+
   |             |             |
+------+     +------+     +--------+
| RAM1 |     | RAM2 |     | Device |
+------+     +------+     +--------+

-- 
Catalin
