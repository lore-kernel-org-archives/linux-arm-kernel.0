From: mpatocka@redhat.com (Mikulas Patocka)
Date: Fri, 3 Aug 2018 13:09:02 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180803094129.GB17798@arm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
Message-ID: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 3 Aug 2018, Will Deacon wrote:

> On Fri, Aug 03, 2018 at 09:16:39AM +0200, Ard Biesheuvel wrote:
> > On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > > On Thu, 2 Aug 2018, Matt Sealey wrote:
> > >
> > >> The easiest explanation for this would be that the memory isn?t mapped
> > >> correctly. You can?t use PCIe memory spaces with anything other than
> > >> Device-nGnRE or stricter mappings. That?s just differences between the
> > >> AMBA and PCIe (posted/unposted) memory models.
> > 
> > Whoa hold on there.
> > 
> > Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?
> > 
> > Most accelerated graphics drivers rely heavily on the ability to map
> > the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
> > ordinary memory.
> 
> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
> fine for prefetchable BARs, no?
> 
> Will

So - why does it corrupt data then? I've created this program that 
reproduces the data corruption quicky. If I run it on /dev/fb0, I get an 
instant failure. Sometimes a few bytes are not written, sometimes a few 
bytes are written with a value that should be 16 bytes apart.

I tried to run it on system RAM mapped with the NC attribute and I didn't 
get any corruption - that suggests the the bug may be in the PCIE 
subsystem.

Jingoo Han and Joao Pinto are maintainers for the designware PCIE 
controllers. Could you suggest why does the controller corrupt data when 
writing to videoram? Are there any tricks that could be tried to work 
around the corruption?

Mikulas



#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define LEN		256
#define PRINT_STRIDE	0x20

static unsigned char data[LEN];
static unsigned char val = 0;

static unsigned char prev_data[LEN];

static unsigned char map_copy[LEN];

int main(int argc, char *argv[])
{
	unsigned long n = 0;
	int h;
	unsigned char *map;
	unsigned start, end, i;

	if (argc < 2) fprintf(stderr, "argc\n"), exit(1);
	if (argc >= 4) srandom(atoll(argv[3]));
	h = open(argv[1], O_RDWR | O_DSYNC);
	if (h == -1) perror("open"), exit(1);
	map = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, h, argc >= 3 ? strtoull(argv[2], NULL, 16) : 0);
	if (map == MAP_FAILED) perror("mmap"), exit(1);

	memset(data, 0, LEN);
	memset(prev_data, 0, LEN);
	memset(map, 0, LEN);

	sleep(1);

	while (1) {
		start = (unsigned)random() % (LEN + 1);
		end = (unsigned)random() % (LEN + 1);
		if (start > end)
			continue;
		for (i = start; i < end; i++)
			data[i] = val++;
		memcpy(map + start, data + start, end - start);
		if (memcmp(map, data, LEN)) {
			unsigned j;
			memcpy(map_copy, map, LEN);
			fprintf(stderr, "mismatch after %lu loops!\n", n);
			fprintf(stderr, "last copied range: 0x%x - 0x%x (0x%x)\n", start, end, (unsigned)(end - start));
			for (j = 0; j < LEN; j += PRINT_STRIDE) {
				fprintf(stderr, "p[%03x]", j);
				for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
					fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", prev_data[i]);
				fprintf(stderr, "\n");
				fprintf(stderr, "d[%03x]", j);
				for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
					fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", data[i]);
				fprintf(stderr, "\n");
				fprintf(stderr, "m[%03x]", j);
				for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
					fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", map_copy[i]);
				fprintf(stderr, "\n\n");
			}
			exit(1);
		}
		memcpy(prev_data, data, LEN);
		n++;
	}
}
