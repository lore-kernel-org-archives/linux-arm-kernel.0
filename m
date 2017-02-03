From: opendmb@gmail.com (Doug Berger)
Date: Thu, 2 Feb 2017 18:00:02 -0800
Subject: Memory Incoherence Issue
Message-ID: <989deba2-f1fb-550c-afdd-e7732d97583c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a device that is based on a dual-core A15 MPCore host CPU
complex that has been exhibiting a problem with very infrequent memory
corruption when exercising a user space memory tester program
(memtester) in a system designed around a v3.14 Linux environment.
Unfortunately, it is not possible to update this system to the latest
kernel version for testing at this time.

We originally suspected hardware issues with the memory, but found no
apparent dependencies on environmental factors such as voltage and
temperature.

The behavior is similar to the issue that was patched in the ARM
architecture Linux kernel and referenced here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319761.html

This patch is included in our kernel and our cores are supposed to
contain the hardware fix for ARM erratum 798181 so while the kernel
contains the ARM_ERRATA_798181 patch, erratum_a15_798181_handler() is NULL.

The general failure case can be described as follows:
A memtester process is executed that runs a set of simple memory tests
over an address range. The address range is allocated at the beginning
of the program (based on command line parameters) and is split into two
buffers (named buf_a and buf_b) with a fixed offset between their
virtual addresses of half the size of the address range. Each individual
memory test follows the basic procedure of writing a pattern to both
buffers and then reading and comparing the results. The buffers are
accessed through pointers to volatile unsigned long integers (32-bit in
this case) in simple loops over the size of each buffer where each
pointer is dereferenced and incremented in each iteration. For example,
a specific memory test might contain one loop in which a value is
written to the first unsigned long integer location in buf_a and to the
first unsigned long integer location in buf_b. The pointers are
incremented and the loop continues to write the value at the next
respective location in each buffer until both buffers are full with the
same content. After the first loop completes, a second loop then reads
the first unsigned long integer location in buf_a and the first unsigned
long integer location in buf_b and compares them. If the read values do
not match each other an error message is output that displays the
mismatched values (the pointers are dereferenced again for the displayed
values). The second loop then updates the pointers and continues
comparing respective entries in each buffer until they have all been
compared. The memtester program is configured to repeat a set of memory
tests of the same cache-able, shareable, normal memory address range
indefinitely.

In preproduction testing we received reports that when running the
memtester process on approximately 100 systems a few would output error
messages reflecting mismatched values after a day or two and we have
been trying to determine the cause of the errors.

Observations:
The most common pattern of failure reported is a mismatch over a 32KB
(32768-byte) range within the buffers during a single memory test with
subsequent memory tests not showing any errors.
The next most common pattern of failure is a mismatch over a 64-byte
(cache line length) range within the buffers during a single memory test
with subsequent memory tests not showing any errors.
When it is possible to recognize the data pattern of a particular memory
test, the error messages generally show the mismatched data displayed
from buf_a and buf_b to be from two consecutive tests (i.e. one buffer
appears to hold stale data within the mismatch range).
The mismatched ranges appear to start on virtual addresses that are
aligned to the size of the mismatch range. For 32KB mismatches the
underlying physical addresses are only page aligned (i.e. 4KB not 32KB).
There is no obvious correlation in the location of a mismatch range
within a buffer.
Our L1 cache size is 32KB, but it seems unlikely that the alternating
buffer access pattern of memtester would allow the L1 data cache to
contain only lines from one buffer to account for the 32KB stale data.
One theory is that a page table walk might somehow read the wrong values
in a cache line of page table entries. Since we are using long
descriptors in our translation tables this would amount to 8 64-bit page
table entries and mismap 8 4KB pages or 32KB. However, we have not been
able to come up with a scenario that could cause this.
We tried switching to short descriptors for the page tables
(CONFIG_ARM_LPAE=n) to see if we might start getting 64KB failure ranges
to support this theory, but we have yet to see any failure ranges longer
than 64 bytes in this configuration.
There is some evidence in our testing that the failures may require
process migrations between processor cores since using taskset to set
the affinity of the processes appears to prevent the problem. We have
tried running multiple memtester processes in parallel and also forcing
memtester processes to switch back and forth between processors with
perhaps a slightly higher failure rate, but it is likely not
statistically significant.
Tests with many processes seem to show more 64-byte (or shorter)
failures and the mismatch data seems less likely to be from two
consecutive tests.  The data values may be from two different tests and
in some more interesting cases one of the buffers is observed to contain
page table entries. This suggests data leakage between user space processes.
The error behavior is almost always transient with the appearance that a
comparison is using stale data (e.g. from a cache) that may become
coherent during the compare loop. Some mismatch ranges are less than
64-byte and 32KB. We have even seen the extreme case where the values
read and compared mismatched but when they were reread for output in the
error message the values matched even though there are no writes to the
buffers between the reads.
We have also had some failures where the mismatch range is stable over
subsequent memory tests. In these cases it appears that the values of
one of the buffers in a 32KB mismatch range match the content of our
boot ROM. It is suspected that the writes of a test pattern may be
corrupting a page table such that the corresponding virtual addresses
are being mapped to the boot ROM. Attempts by memtester to write the
next pattern to the buffer fail to change the value of the ROM so the
failures reappear in the same 32KB range of the buffers in each memory
test that follows the first failure.  The expected test pattern in this
case was 0x00000800FFFFF7FF which if stored in a long descriptor page
table entry would point to our ROM physical address of 0x00FFFFF000.
However, I would expect a user space write to this address to fault
since AP[2:1] are 11b.

My current thinking is that the data cache lines themselves may not be
getting directly corrupted, but perhaps there is a problem with the
cache indexing which somehow allows the wrong cacheline content to be
returned on a cache read or a cache write may store data in the wrong
cacheline.  It would appear from the failure logs that under some
circumstance the data transactions initiated by the TLB page table walk
bus master and the data transactions initiated by the CPU load/store
master may interfere in a way that allows the data from one to be
incorrectly observed within the data cache(s) by the other.

Does this type of failure ring any bells?
Are there any test codes or procedures that you are aware of to
specifically stress these hardware subsytems (i.e. TLB and data caches)
to detect timing or implementation errors in an A15 MPCore system?
If you can provide any suggestions of what may be happening or methods
of gaining increased visibility into the source of the failures or
further experiments you think might be helpful in determining the root
of the failures and its solution we would greatly appreciate it.

Regards,
    Doug
