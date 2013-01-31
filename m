From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 10:15:11 -0600
Subject: BogoMIPS change in 3.6+
Message-ID: <510A988F.6030508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BogoMIPS value has changed on highbank since the commit below in
3.6. It is now half the value it used to be. Does that matter other than
perception (I've checked that I'm not running at half the freq)?

Rob

commit d0a533b18235d36206b9b422efadb7cee444dfdb
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri Jul 6 15:47:17 2012 +0100

    ARM: 7452/1: delay: allow timer-based delay implementation to be
selected

    This patch allows a timer-based delay implementation to be selected by
    switching the delay routines over to use get_cycles, which is
    implemented in terms of read_current_timer. This further allows us to
    skip the loop calibration and have a consistent delay function in the
    face of core frequency scaling.

    To avoid the pain of dealing with memory-mapped counters, this
    implementation uses the co-processor interface to the architected timers
    when they are available. The previous loop-based implementation is
    kept around for CPUs without the architected timers and we retain both
    the maximum delay (2ms) and the corresponding conversion factors for
    determining the number of loops required for a given interval. Since the
    indirection of the timer routines will only work when called from C,
    the sa1100 sleep routines are modified to branch to the loop-based delay
    functions directly.
