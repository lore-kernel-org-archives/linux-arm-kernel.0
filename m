From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jun 2013 11:11:49 +0100
Subject: ARM cacheflush syscall with range that spans multiple vma
In-Reply-To: <20130610085948.GP18614@n2100.arm.linux.org.uk>
References: <51B51844.9050108@bitwagon.com>
 <20130610085948.GP18614@n2100.arm.linux.org.uk>
Message-ID: <20130611101149.GF24729@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 09:59:48AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 09, 2013 at 05:05:24PM -0700, John Reiser wrote:
> > Why does the ARM cacheflush syscall stop after the lowest vma
> > which intersects the user-requested range?  The range could
> > span more than one vma having contiguous addresses, such as
> > two files MAP_SHARED into adjacent pages; or even a region
> > that contains holes (pages not present.)
> 
> Because you're not supposed to use it on large ranges because it's
> an expensive operation.

FWIW: here's a simple test case which can really affect responsiveness on my
TC2 (2GB of memory). It just creates a single VMA, doesn't bother faulting it
in, then tries to cacheflush the whole range. On a kernel with
CONFIG_PREEMPT_NONE=y, this effectively stalls the system (interrupts are
still taken) until the flush has completed.

Will

--->8

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUFSIZE		0x70000000
#define NR_cacheflush	0xf0002

int main(void)
{
	int ret;
	char *region = malloc(BUFSIZE);

	if (!region) {
		fprintf(stderr, "Failed to allocate %u-byte buffer\n", BUFSIZE);
		return -1;
	}

	ret = syscall(NR_cacheflush, region, region + BUFSIZE, 0);
	if (ret)
		printf("syscall returned %d\n", ret);

	return ret;
}
