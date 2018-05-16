From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 07:43:34 +0200
Subject: vm_fault_t conversion, for real
Message-ID: <20180516054348.15950-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series tries to actually turn vm_fault_t into a type that can be
typechecked and checks the fallout instead of sprinkling random
annotations without context.

The first one fixes a real bug in orangefs, the second and third fix
mismatched existing vm_fault_t annotations on the same function, the
fourth removes an unused export that was in the chain.  The remainder
until the last one do some not quite trivial conversions, and the last
one does the trivial mass annotation and flips vm_fault_t to a __bitwise
unsigned int - the unsigned means we also get plain compiler type
checking for the new ->fault signature even without sparse.

This has survived an x86 allyesconfig build, and got a SUCCESS from the
buildbot that I don't really trust - I'm pretty sure there are bits
and pieces hiding in other architectures that it hasn't caught up to.

The sparse annotations are manuall verified for the core MM code and
a few other interesting bits (e.g. DAX and the x86 fault code)

The series is against linux-next as of 2018/05/15 to make sure any
annotations in subsystem trees are picked up.
